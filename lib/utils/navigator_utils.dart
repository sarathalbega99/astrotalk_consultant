import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/api_handler.dart';
import '../cubit/all_cubits.dart';
import '../utils/utils.dart';
import '../views/screens.dart';

ApiHandler? apiHandler = ApiHandler();

class AppNavigator {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AuthCubit(repository: apiHandler),
                child: const LoginScreen(),
              ),
        );
      case AppRoutes.verifyOtp:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AuthCubit(repository: apiHandler),
                child: VerifyOtpScreen(data: args),
              ),
        );
   
      case AppRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case AppRoutes.navBar:
        return MaterialPageRoute(builder: (context) => BottomNavbar());
     
      // case AppRoutes.initiateCallScreen:
      //   Map<String, dynamic> args =
      //       routeSettings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => InitiateCallScreen(data: args),
      //   );
      case AppRoutes.consultantHome:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => ConsultantHomeCubit(repository: apiHandler),
                child: const ConsultantHome(),
              ),
        );
      case AppRoutes.callLogsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => CallHistoryCubit(repository: apiHandler),
                child: const CallLogsScreen(),
              ),
        );
      case AppRoutes.notificationScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => NotificationCubit(repository: apiHandler),
                child: const NotificationScreen(),
              ),
        );
      case AppRoutes.payoutsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => PayOutCubit(repository: apiHandler),
                child: const PayoutsScreen(),
              ),
        );

      default:
        null;
    }
    return null;
  }
}

// named route navigation
navigateTo(context, routeName) => Navigator.pushNamed(context, routeName);

navigateAndReplace(context, routeName) =>
    Navigator.pushReplacementNamed(context, routeName);

navigateWithData(context, routeName, arg) =>
    Navigator.pushNamed(context, routeName, arguments: arg);

navigateAndReplaceWithData(context, routeName, arg) =>
    Navigator.pushReplacementNamed(context, routeName, arguments: arg);

navigateUntil(context, routeName) =>
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);

navigateUntilData(context, routeName, arg) => Navigator.pushNamedAndRemoveUntil(
  context,
  routeName,
  arguments: arg,
  (route) => false,
);

navigateToBack(context) => Navigator.pop(context);

navigateToBackWithResult(context, text) => Navigator.pop(context, text);
