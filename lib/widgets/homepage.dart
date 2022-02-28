import 'package:logger/logger.dart';
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
  //Variables
  bool isAuth = false;
  Logger logger = Logger(
    printer: PrettyPrinter(),
  );
  late PageController _pageController;
  int _pageIndex = 0;

//Initialize state
  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    //Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      logger.e("Error signing in: $err");
    });
    //Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      logger.e("Error signing in: $err");
    });
  }

//HANDLE SIGN IN
  handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      logger.d("User signed in: $account");
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  //Dispose controller
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

//PAGE CHANGE
  onPageChanged(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

//LOGIN
  login() {
    googleSignIn.signIn();
  }

//LOGOUT
  logout() {
    googleSignIn.signOut();
  }

// BOTTOM NAVIGATION BAR ACTIONS
  onTap(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return isAuth
        ? BuildAuthScreen(
            logout: logout,
            pageController: _pageController,
            onPageChanged: onPageChanged,
            pageIndex: _pageIndex,
            onTap: onTap,
          )
        : Buildunauthscreen(
            login: login,
          );
  }
}
