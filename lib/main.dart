import 'package:auth_signin_signup_firebase/screens/home_screen.dart';
import 'package:auth_signin_signup_firebase/screens/signin_screen.dart';
import 'package:auth_signin_signup_firebase/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:auth_signin_signup_firebase/provider/auth_provider.dart'
    as authProvider;
import 'package:auth_signin_signup_firebase/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => authProvider.AuthProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomeScreen();
                } else {
                  return const WelcomeScreen();
                }
              },
            ))
        // home: const WelcomeScreen()),
        );
  }
}

// untuk melihat apakah ada perubahan pada firebase auth ini
