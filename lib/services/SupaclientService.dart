import 'dart:async';

import 'package:clipboarda/dataModel.dart';
import 'package:clipboarda/key.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaclientService {
  final Supabase client = Supabase.instance;
  final StreamController supaStream = StreamController.broadcast();

  final socket = RealtimeClient(
    url,
    params: {'apikey': key},
    // ignore: avoid_print
    logger: (kind, msg, data) => {print('$kind $msg $data')},
  );

  addUserData(DataModel data) async {
    final response =
        await client.client.from('clipData').insert(data.toJson()).execute();
    return response;
  }

  getUserData() async {
    PostgrestResponse response = await client.client
        .from('clipData')
        .select()
        .eq('uuid', client.client.auth.currentUser?.id)
        .order('created_at')
        .limit(30)
        .execute();
    return response;
  }

  setUpSocket() async {
    final channel = socket.channel('realtime:public');
    channel.on('INSERT', (payload, {ref}) {
      supaStream.sink.add(payload);
    });
    socket.onMessage((message) => print('MESSAGE $message'));
    // on connect and subscribe
    socket.connect();
    channel.subscribe().receive('ok', (_) => print('SUBSCRIBED'));
  }
}
