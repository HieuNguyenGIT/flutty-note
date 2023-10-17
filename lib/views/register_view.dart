import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;

import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //late : a keyword that say the variable may not have a value now but it will
  // innit and dispose, one create when a page rendered and when it leave
  // when u decare something to be initiate, u must also dispose of it
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            //keyboardtype allow u to set the phone keyboard to use @ setup
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Paswsword here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                if (mounted) {
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'weak password',
                    );
                  }
                } else if (e.code == 'email-already-in-use') {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'email already in use',
                    );
                  }
                } else if (e.code == 'invalid-email') {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'invalid email',
                    );
                  }
                } else {
                  if (mounted) {
                    await showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Registered, then login here !'))
        ],
      ),
    );
  }
}
