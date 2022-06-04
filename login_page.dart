import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:record_waste_money/logout_page.dart';
import 'package:record_waste_money/money_list/money_list_page.dart';

import 'package:record_waste_money/logout_page.dart';

class LoginPage extends StatelessWidget {
  static final googleLogin = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン画面'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {

            GoogleSignInAccount? signinAccount = await GoogleSignIn().signIn();
            if (signinAccount == null) return;

            GoogleSignInAuthentication auth = await signinAccount.authentication;

            final OAuthCredential credential =
            GoogleAuthProvider.credential(
              idToken: auth.idToken,
              accessToken: auth.accessToken,
            );

            User? user =
                (await FirebaseAuth.instance.signInWithCredential(credential))
                    .user;

            if (user != null) {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LogoutPage(user);
                }),
              );
            }
          },
          child: Text(
            'login',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
