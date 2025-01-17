import 'package:ai_chatbot/features/auth/forgetPassword/forget_password_screen.dart';
import 'package:ai_chatbot/services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/Profile/subScreens/edit_profile_screen.dart';
import 'features/admin/admin_home.dart';
import 'features/auth/Login/login_screen.dart';
import 'features/auth/SignUp/signup_screen.dart';
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
  var _alertShowing = false;
  var _index = 0;

  @override
  void initState() {
    super.initState();
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
        '/admin-home': (context) => const AdminHome(),
        '/edit-profile': (context) => const EditProfileScreen(),
      },
    );
  }
}
