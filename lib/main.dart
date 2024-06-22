import 'package:ai_chatbot/features/auth/forgetPassword/forget_password_screen.dart';
import 'package:ai_chatbot/services/auth_repo.dart';
import 'package:ai_chatbot/testScreens/test_screen_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'bottom_nav_bar.dart';
import 'features/auth/Login/login_screen.dart';
import 'features/auth/SignUp/signup_screen.dart';
import 'features/chatbot/chatbot_screen.dart';
import 'features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBxijb1tnhA78VyWCP22TvgjGWP4-iQTfY',
      appId: '1:38603677344:web:f92be091817dbac33eb3c5',
      messagingSenderId: '38603677344',
      projectId: 'ai-chatbot-573aa',
    ),
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? authUser;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), screenRedirect);
  }

  void screenRedirect() async {
    // final deviceStorage = GetStorage();
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    authUser = user;
    // if (user != null) {
    //   if (user.emailVerified) {
    //     Navigator.pushNamed(context, '/home');
    //   } else {
    //     Navigator.pushNamed(context, '/home');
    //   }
    // } else {
    //   Navigator.pushNamed(context, '/home');
    // }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: authUser == null ? '/' : '/home',
      routes: {
        '/': (context) => LoginScreen(),
        '/signUp': (context) => SignupScreen(),
        '/forget-password': (context) => const ForgetPasswordScreen(),
        // '/nav-bar': (context) => BottomNavBarScreen(),
        '/home': (context) => const MyHomePage(),
        // '/quote': (context) => const MyHomePage(),
      },
    );
  }
}
