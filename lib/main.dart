import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/providers/user_provider.dart';
import 'package:instagram_clone/source/screens/authScreens/sign_in_screen.dart';
import 'package:instagram_clone/source/screens/responsive/mobile_layout.dart';
import 'package:instagram_clone/source/screens/responsive/responsive_screen.dart';
import 'package:instagram_clone/source/screens/responsive/web_layout.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCNB-abLfiL-uDF6bLwFsBscThpVDLRvtY",
        appId: "1:587149771947:web:5b097925b04513f82ee3ee",
        messagingSenderId: "587149771947",
        projectId: "instagram-clone-f31ee",
        storageBucket: "instagram-clone-f31ee.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobScreenLayout: MobileLayout(),
                  webScreenLayout: WebLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const SignInScreen();
          },
        ),
      ),
    );
  }
}
