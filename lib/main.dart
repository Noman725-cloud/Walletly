import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(const WalletlyApp());
}

class WalletlyApp extends StatelessWidget {
  const WalletlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Walletly',
          // You can use the library anywhere in the app even in theme
          theme: AppTheme.darkTheme,
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
