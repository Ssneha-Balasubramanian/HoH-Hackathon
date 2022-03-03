
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../../constants/concave_decoration.dart';
import '../../constants/recorder_constants.dart';
import '../../widgets/HeaderWidget.dart';
import '../../widgets/NavigationBarWidget.dart';
import '../recordings_list/cubit/files/files_cubit.dart';
import 'cubit/record/record_cubit.dart';
import 'widgets/audio_visualizer.dart';
import 'widgets/mic.dart';

class HomeScreen extends StatefulWidget {
  final scaffoldkey;
  static const routeName = '/homescreen';

  HomeScreen({
    Key? key,
    required this.scaffoldkey
  }) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen(scaffoldkey: scaffoldkey,);
}

class _HomeScreen extends State<HomeScreen> {

  static const routeName = '/homescreen';
  final scaffoldkey;

  _HomeScreen({
    required this.scaffoldkey
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          if (state is RecordStopped || state is RecordInitial) {
            return SafeArea(
                child: Column(
              children: [
                HeaderWidget(),
                appTitle(),
                NeumorphicMic(
                  onTap: () {
                  context.read<RecordCubit>().startRecording();
                },
                ),
                const Spacer(),
                NavigationBarWidget(scaffoldkey: scaffoldkey,),

              ],
            ));
          } else if (state is RecordOn) {
            return SafeArea(
                child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                appTitle(),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    StreamBuilder<double>(
                        initialData: RecorderConstants.decibelLimit,
                        stream: context.read<RecordCubit>().amplitudeStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AudioVisualizer(amplitude: snapshot.data);
                          }
                          if (snapshot.hasError) {
                            return const Text(
                              'Visualizer failed to load',
                              style: TextStyle(color: AppColors.accentColor),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<RecordCubit>().stopRecording();

                    ///We need to refresh [FilesState] after recording is stopped
                    context.read<FilesCubit>().getFiles();
                  },
                  child: Container(
                    decoration: ConcaveDecoration(
                      shape: const CircleBorder(),
                      depression: 10,
                      colors: const [
                        AppColors.highlightColor,
                        AppColors.shadowColor,
                      ],
                    ),
                    child: const Icon(
                      Icons.stop,
                      color: AppColors.accentColor,
                      size: 50,
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          );
          } else {
            return const Center(
                child: Text(
              'An Error occured',
              style: TextStyle(color: AppColors.accentColor),
            ));
          }
        },
      ),
      );
  }

  Widget appTitle() {
    return const Text(
      'Press the microphone icon below to start recording...',
      style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 27,
          letterSpacing: 5,
          fontWeight: FontWeight.bold,
        fontFamily: 'PlayFairDisplay',
      ),
      textAlign: TextAlign.center,
    );
  }

  }

