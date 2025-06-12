import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/all_cubits.dart';
import '../../utils/utils.dart';
import '../screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConsultantHomeCubit(repository: apiHandler),
        ),
        BlocProvider(
          create: (context) => CallHistoryCubit(repository: apiHandler),
        ),
        BlocProvider(create: (context) => PayOutCubit(repository: apiHandler)),
      ],
      child: BottomNavbar(),
    );
  }
}
