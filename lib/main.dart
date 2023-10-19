import 'package:flutter/material.dart';
import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/services/auth/auth_service.dart';
import 'package:fluttynotes/views/login_view.dart';
import 'package:fluttynotes/views/notes/new_note_view.dart';
import 'package:fluttynotes/views/notes/notes_view.dart';
import 'package:fluttynotes/views/register_view.dart';
import 'package:fluttynotes/views/verify_email_view.dart';
// show allow u to import specific features
// as dictcate how u call it but with show u can list scefific func
//import 'dart:developer' as devtools show log;
//import 'firebase_options.dart';

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
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      newNoteRoute: (context) => const NewNoteView(),
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
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            // ?. to check for null and if it does set it to false
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
