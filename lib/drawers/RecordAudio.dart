import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/home_screen/cubit/record/record_cubit.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/recordings_list/cubit/files/files_cubit.dart';

class RecordAudioPage extends StatefulWidget
{
  final scaffoldkey;

  @override
  const RecordAudioPage({
    required this.scaffoldkey
  }) ;

  @override
  _RecordAudioPage createState() => _RecordAudioPage(scaffoldkey: scaffoldkey);
}
class _RecordAudioPage extends State<RecordAudioPage> 
{

  final scaffoldkey;

  @override
  _RecordAudioPage({
    required this.scaffoldkey
  }) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),

        /// [FilesCubit] is provided before material app because it should start loading all files when app is opens
        /// asynschronous method [getFiles] is called in constructor of [Files Cubit].
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(scaffoldkey: scaffoldkey,),
        },
      ),
    );
  }
}