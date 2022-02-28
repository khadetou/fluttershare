import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/build_authscreen.dart';
import 'package:fluttershare/widgets/build_unauthscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    //Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);

      // setState(() {
      //   isAuth = account != null;
      // });
    }, onError: (err) {
      print("Error signing in: $err");
    });
    //Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print("Error signing in: $err");
    });
  }

  handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      print("User signed in: $account");
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return isAuth
        ? BuildAuthScreen(
            logout: logout,
          )
        : Buildunauthscreen(
            login: login,
          );
  }
}
