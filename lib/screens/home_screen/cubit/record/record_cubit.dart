import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../../../constants/paths.dart';
import '../../../../constants/recorder_constants.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial());

  final Record _audioRecorder = Record();

  void startRecording() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;

    if (permissionsGranted) {
      Directory appFolder = Directory(Paths.recording);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        }

      final filepath = Paths.recording +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          RecorderConstants.fileExtension;

      await _audioRecorder.start(path: filepath);

      emit(RecordOn());
    }
  }

  void stopRecording() async {
    String? path = await _audioRecorder.stop();
    emit(RecordStopped());
    }

  Future<Amplitude> getAmplitude() async {
    final amplitude = await _audioRecorder.getAmplitude();
    return amplitude;
  }

  Stream<double> amplitudeStream() async* {
    while (true) {
      await Future.delayed(const Duration(
          milliseconds: RecorderConstants.amplitudeCaptureRateInMilliSeconds));
      final ap = await _audioRecorder.getAmplitude();
      yield ap.current;
    }
  }
}
