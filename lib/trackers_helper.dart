import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';

class TrackersHelper extends ITrackersHelper {
  @override
  Widget trackedPrimaryButton({
    required String btnId,
    required String btnTitle,
    required VoidCallback? onPress,
    Map<String, Object>? infosToTrack,
  }) {
    return Container();
  }

  @override
  Widget trackedSecondaryButton({
    required String btnId,
    required String btnTitle,
    required VoidCallback? onPress,
    Map<String, Object>? infosToTrack,
  }) {
    return Container();
  }

  @override
  initPageTrack(String pageName) {
    debugPrint('INIT_PAGE_TRACK: $pageName');
  }

  @override
  stopPageTrack(String pageName, {Map<String, Object>? infos}) {
    debugPrint('STOP_PAGE_TRACK: $pageName');
  }

  @override
  trackCustomEvent(String eventName, {required Map<String, Object> infos}) {
    debugPrint('TRACK_CUSTOM_EVENT: $eventName, infos: $infos');
  }
}
