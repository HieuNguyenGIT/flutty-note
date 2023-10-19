import 'package:flutter/material.dart';

import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/services/auth/auth_exceptions.dart';
import 'package:fluttynotes/services/auth/auth_service.dart';
import 'package:fluttynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            //keyboardtype allow u to set the phone keyboard to use @ setup
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                //devtools.log(userCredential.toString());
                // use comma , to better formatting
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // user's email is verified
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  }
                } else {
                  // user's email is NOT verified
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                }
                //pushnamedandremoveuntil basically remove the previous page essentially and place a new one
                // u should try to catch a specific error
                //err type
                //devtools.log(e.runtimeType);
                //err type name
                // as of 17/10/2023 it would seem all kind of wrong input are called invalid credential
              } on UserNotFoundAuthException {
                if (mounted) {
                  await showErrorDialog(
                    context,
                    'User not found',
                  );
                }
              } on WrongPasswordAuthException {
                if (mounted) {
                  await showErrorDialog(
                    context,
                    'Wrong credentials',
                  );
                }
              } on GenericAuthException {
                if (mounted) {
                  await showErrorDialog(
                    context,
                    'Authentication error',
                  );
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Register here if not registered'))
        ],
      ),
    );
  }
}
