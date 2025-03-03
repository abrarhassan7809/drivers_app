import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DriverApp(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Drivers, App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MySplashScreen(),
      ),
    )
  );
}

class DriverApp extends StatefulWidget {
  const DriverApp({super.key, this.child});
  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_DriverAppState>()!.restartApp();
  }

  @override
  State<DriverApp> createState() => _DriverAppState();
}

class _DriverAppState extends State<DriverApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!
    );
  }
}
