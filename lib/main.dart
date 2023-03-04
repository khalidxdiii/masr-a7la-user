import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:masr_a7la/modules/login/login_screen.dart';
import 'package:masr_a7la/shared/bloc_observer.dart';
import 'firebase_options.dart';
import 'layout/user_layout_screen.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fb = FirebaseAuth.instance.currentUser;
  if (fb != null) {
    final bool? isAdmin = (await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get())["role"];

    runApp(MyApp(
      isAdmin: isAdmin ?? false,
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isAdmin = false}) : super(key: key);
  final bool? isAdmin;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseAuth.instance.currentUser;
    bool auth = false;
    late Widget goWidget;
    if (fb != null) {
      goWidget = isAdmin! ? const UserLayoutScreen() : const LoginScreen();
      auth = true;
    }
    return MaterialApp(
      title: 'مصر احلى',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Almarai',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.normal,
              ),
              headlineSmall: const TextStyle(
                fontSize: 26,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", ""),
        Locale('en'),
      ],
      locale: const Locale("ar", ""),

      // home: PageView(
      //   scrollDirection: Axis.horizontal,
      //   children: [Login_Screen(), QrScreen()],
      // ),
      home: auth ? goWidget : const LoginScreen(),
    );
  }
}
