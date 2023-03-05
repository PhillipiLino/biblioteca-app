import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/trackers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackersHelper extends ITrackersHelper {
  final TrackersManager? _toolsManager;

  TrackersHelper(this._toolsManager);

  @override
  Widget trackedPrimaryButton({
    required String btnId,
    required String btnTitle,
    required VoidCallback? onPress,
    Map<String, Object>? infosToTrack,
  }) {
    final action = onPress == null
        ? null
        : () {
            debugPrint('TRACK_BUTTON_CLICK: $btnId');
            _toolsManager?.trackButtonClick(btnId, infos: infosToTrack ?? {});
            onPress.call();
          };

    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
      key: Key(btnId),
      child: Text(
        btnTitle,
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
    );
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
