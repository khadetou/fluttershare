import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/create_account.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/build_authscreen.dart';
import 'package:fluttershare/widgets/build_unauthscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final timestamp = DateTime.now();

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
  User? currentUser;
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
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  //CREATE USER IN FIRESTORE
  createUserInFirestore() async {
    //1) Check if user exists in users collection database (according to their id)
    final GoogleSignInAccount? user = googleSignIn.currentUser;

    DocumentSnapshot<Map<String, dynamic>> doc =
        await usersRef.doc(user!.id).get();

    if (!doc.exists) {
      //2) If the user doesn't exist, then we want to take them to the create account page

      final username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateAccount()),
      );

      //3) Get username from create account, use it to make new user document in users collection
      usersRef.doc(user.id).set({
        'id': user.id,
        'username': username,
        'photoUrl': user.photoUrl,
        'email': user.email,
        'displayName': user.displayName,
        'bio': '',
        'timestamp': timestamp,
      });

      doc = await usersRef.doc(user.id).get();
    }

    currentUser = User.fromDocument(doc);
    logger.v(currentUser);
    logger.d(currentUser!.username);
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
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
            currentUser: currentUser,
          )
        : Buildunauthscreen(
            login: login,
          );
  }
}
