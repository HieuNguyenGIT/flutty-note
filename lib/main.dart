import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/views/login_view.dart';
import 'package:fluttynotes/views/register_view.dart';
import 'package:fluttynotes/views/verify_email_view.dart';
// show allow u to import specific features
// as dictcate how u call it but with show u can list scefific func
import 'dart:developer' as devtools show log;
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
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
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

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main ui'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              // log by default only take string value so sometime u may have to convert to string using tostring()
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  devtools.log(shouldLogout.toString());
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    if (mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                    }
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                //child is what user see
                // value is what dev see
                PopupMenuItem(value: MenuAction.logout, child: Text('logout')),
              ];
            },
          )
        ],
      ),
      body: const Text('hello worlds !'),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('sign out'),
          content: const Text('are you sure u want to sign out'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Logout'))
          ],
        );
      }).then((value) => value ?? false);
}
