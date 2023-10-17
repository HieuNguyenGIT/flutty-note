import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttynotes/views/login_view.dart';
import 'package:fluttynotes/views/register_view.dart';
import 'package:fluttynotes/views/verify_email_view.dart';

import 'firebase_options.dart';

//hot reload allow state to be saved
//stateful : data can be changes as time gone by
//stateless: doesnt contain data this mutable

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
    },
  ));
}

// stl to create a statelesswidget
// scaffold : as its name suggest, basic structure
// widget: like a place holder, it can contain lots of thing
// usually texts
// press ctrl + . when highlight over widget to warp them with different stuff
// controller or text controller is how data is passed from one place to another

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // buildcontext to send contents to another
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // ?. to check for null and if it does set it to false
            if (user != null) {
              if (user.emailVerified) {
                print('email is verified');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const Text('Logged in i guess');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
