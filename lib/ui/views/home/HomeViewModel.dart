import 'dart:async';

import 'package:clipboarda/app/app.locator.dart';
import 'package:clipboarda/app/app.router.dart';
import 'package:clipboarda/dataModel.dart';
import 'package:clipboarda/services/SupaclientService.dart';
import 'package:clipboarda/services/UserAuthService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends BaseViewModel {
  final SupaclientService _service = locator<SupaclientService>();
  final UserAuthService _authService = locator<UserAuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<DataModel> data = [];
  StreamSubscription? streamSub;
  final SnackbarService _snackbarService = locator<SnackbarService>();

  expand(DataModel data) async {
    data.expanded = !data.expanded;
    notifyListeners();
  }

  addData() async {
    setBusyForObject('add', true);
    ClipboardData? clipData = await Clipboard.getData('text/plain');
    if (clipData != null) {
      RegExp regexpURL = RegExp(
        '/(?:(?:https?|ftp):\/\/|\b(?:[a-z\d]+\.))(?:(?:[^\s()<>]+|\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))?\))+(?:\((?:[^\s()<>]+|(?:\(?:[^\s()<>]+\)))?\)|[^\s`!()\[\]{};:\'".,<>?«»“”‘’]))?/ig',
      );
      RegExp regexpPhone =
          RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\$');
      bool isPhone = regexpPhone.hasMatch(clipData.text ?? '');
      bool isURL = regexpURL.hasMatch(clipData.text ?? '');
      String dataType = isPhone
          ? 'phone'
          : isURL
              ? 'url'
              : 'text';
      DataModel clipDataToAdd = DataModel(
          data: clipData.text,
          type: dataType,
          uuid: _service.client.client.auth.currentUser?.id);
      final PostgrestResponse response =
          await _service.addUserData(clipDataToAdd);
      // data = [DataModel.fromJson(response.data[0]), ...data];
      // notifyListeners();
    }
    setBusyForObject('add', false);
  }

  addToClipBoard(DataModel dataModel) async {
    await Clipboard.setData(ClipboardData(text: dataModel.data));
    _snackbarService.showSnackbar(message: 'copied to clipboard');
  }

  void launchURL(DataModel dataModel) async {
    if (dataModel.data != null && await canLaunch(dataModel.data ?? '')) {
      await launch(dataModel.data ?? '');
    }
  }

  getSupaData() async {
    data = [];
    setBusy(true);
    PostgrestResponse response = await _service.getUserData();
    if (streamSub == null) {
      streamSub = _service.client.client
          .from('clipData')
          .stream(['uuid'])
          .execute()
          .listen((event) {});
      _service.client.client.from('clipData').on(SupabaseEventTypes.insert,
          (payload) {
        print(payload);
        data = [DataModel.fromJson(payload.newRecord), ...data];
        notifyListeners();
      });
    }
    if (response.data.length > 0) {
      (response.data as List<dynamic>).forEach((element) {
        data.add(DataModel.fromJson(element));
      });
      notifyListeners();
      setBusy(false);
    }
    setBusy(false);
  }

  share(DataModel dataModel) {
    if (dataModel.data != null) {
      try {
        Share.share(dataModel.data ?? '');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  signOut() async {
    await _authService.logout();
    streamSub?.cancel();
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
