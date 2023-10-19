import 'package:flutter/material.dart';
import 'package:fluttynotes/constants/routes.dart';
import 'package:fluttynotes/enum/menu_action.dart';
import 'dart:developer' as devtools show log;

import 'package:fluttynotes/services/auth/auth_service.dart';

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
                    await AuthService.firebase().logOut();
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
