import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/widgets/NavigationBarWidget.dart';

import '../../../constants/app_colors.dart';
import '../../../controller/audio_player_controller.dart';
import '../../../main.dart';
import '../../../models/recording_group.dart';
import '../cubit/files/files_cubit.dart';
import 'widgets/playing_icons.dart';

class RecordingsListScreen extends StatefulWidget {
  static const routeName = '/recordingsList';
  final scaffoldkey;

  const RecordingsListScreen({
    required this.scaffoldkey
  });

  @override
  _RecordingsListScreenState createState() => _RecordingsListScreenState(scaffoldkey: scaffoldkey);
}

class _RecordingsListScreenState extends State<RecordingsListScreen> {

  final scaffoldkey;

  _RecordingsListScreenState({
    required this.scaffoldkey
  });

  final AudioPlayerController controller = AudioPlayerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: AppColors.mainColor,
      body: BlocBuilder<FilesCubit, FilesState>(
        builder: (context, state) {
          if (state is FilesLoaded) {
            String _durationString(Duration duration) {
              String twoDigits(int n) => n.toString().padLeft(2, "0");
              String twoDigitMinutes =
              twoDigits(duration.inMinutes.remainder(60));
              String twoDigitSeconds =
              twoDigits(duration.inSeconds.remainder(60));
              return "$twoDigitMinutes:$twoDigitSeconds";
            }

            Widget buildGroup(RecordingGroup rGroup) {
              final currentTime = DateTime.now();

              final today = DateTime.utc(
                  currentTime.year, currentTime.month, currentTime.day);

              String title = 'Recordings - ';
              int diffrence = rGroup.date.difference(today).inDays;

              if (diffrence == -1) {
                title += 'Yesterday';
              } else if (diffrence == 0) {
                title += 'Today';
              } else {
                title += getDateString(rGroup.date);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child : Image.asset(
                      'assets/arrow.png',
                      height: 40,
                      color: Colors.black,
                      alignment: Alignment.topLeft,
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const AppPage()));
                    },
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.highlightColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 5,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  ...rGroup.recordings
                      .map((groupRecording) => Dismissible(
                    background: Container(color: AppColors.shadowColor),
                    onDismissed: (direction) async {
                      controller.stop();
                      final recording = state.recordings.firstWhere(
                              (element) => element == groupRecording);
                      await recording.file.delete();
                      context
                          .read<FilesCubit>()
                          .removeRecording(recording);
                    },
                    key: Key(groupRecording.fileDuration.toString()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        selectedTileColor: Colors.green,
                        title: Text(
                          dateTimeToTimeString(groupRecording.dateTime),
                          style: const TextStyle(
                            color: AppColors.accentColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 5,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                        trailing: Text(
                          _durationString(groupRecording.fileDuration),
                          style: const TextStyle(
                            color: AppColors.accentColor,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                        onTap: () async {
                          await controller.stop();
                          await controller.setPath(
                              filePath: groupRecording.file.path);
                          await controller.play();
                          await controller.stop();
                        },
                      ),

                    ),
                  )
                  )
                      .toList(),
                ],


              );
            }

            if (state.sortedRecordings.isNotEmpty) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: state.sortedRecordings
                          .map((RecordingGroup recordingGroup) {
                        if (recordingGroup.recordings.isNotEmpty) {
                          return buildGroup(recordingGroup);
                        } else {
                          return const SizedBox();
                        }
                      }).toList(),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'You have not recorded any notes',
                  style: TextStyle(color: AppColors.accentColor, fontFamily: 'PlayfairDisplay', ),
                ),
              );
            }
          } else if (state is FilesLoading) {
            return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.accentColor,
                ));
          } else if (state is FilesPermisionNotGranted) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  const Text('You need to allow storage permission to view recordings'),
                  ElevatedButton(
                    onPressed: () async {
                      bool permanentlyDenied =
                      await Permission.storage.isPermanentlyDenied;

                      if (permanentlyDenied) {
                        await openAppSettings();
                      } else {
                        await Permission.storage.request();
                      }
                      await context.read<FilesCubit>().getFiles();
                    },
                    child: const Text('Allow Permission'),
                  ),
                  const Spacer(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBarWidget(scaffoldkey: scaffoldkey,),
    );
  }

  String getDateString(DateTime dateTime) {
    String day = dateTime.day.toString();
    String month = '';
    switch (dateTime.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
    }

    return '$day $month';
  }

  String dateTimeToTimeString(DateTime dateTime) {
    bool isPM = false;
    int hour = dateTime.hour;
    int min = dateTime.minute;

    if (hour > 12) {
      isPM = true;
      hour -= 12;
    }

    return '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')} ${isPM ? 'pm' : 'am'}';
  }

  Widget playingIndicator() {
    const double borderRadius = 40;
    return GestureDetector(
      onTap: () {
        controller.stop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        decoration: const BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                // blurRadius: 20,
                offset: Offset(0, -5),
                blurRadius: 10,
                color: Colors.black26,
              ),
            ]),
        child: StreamBuilder<PlayerState>(
          stream: controller.playerState,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.playing) {
                return PlayingIcon();
              } else {
                return PlayingIcon.idle();
              }
            } else {
              return const Text('Stopped');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
