import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'util.dart';

class UserAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FacebookLogin _facebookSignIn = new FacebookLogin();

  Future<String> createUser(
      BuildContext context, String username, String email, String pwd) async {
    FirebaseUser fuser = await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: pwd);
    UserUpdateInfo updateInfo = new UserUpdateInfo();
    if (fuser == null) return 'error';
    updateInfo.displayName = username;
    fuser.updateProfile(updateInfo);
    Util.uid = fuser.uid;
    Util.userName = fuser.displayName;
    Util.emailId = fuser.email;
    Util.profilePic = '';
    NavigationRouter.switchToHome(context);
    return "Account Created Successfully";
  }

  Future<FirebaseUser> googleSignInButton(BuildContext context) async {
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn().catchError((onError) {
      print("===============================================Error $onError");
    });
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        await _fireBaseAuth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    Util.userName = user.displayName;
    Util.emailId = user.email;
    Util.profilePic = user.photoUrl;
    Util.uid = user.uid;

    NavigationRouter.switchToHome(context);
    return user;
  }

  Future<Null> facebookLogin(BuildContext context) async {
    FacebookLoginResult result = await _facebookSignIn
        .logInWithReadPermissions(['email', 'public_profile']);
    //,publish_actions,manage_pages,publish_pages,user_status,user_videos,user_work_history

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken accessToken = result.accessToken;
        _fireBaseAuth
            .signInWithCredential(FacebookAuthProvider.getCredential(
                accessToken: result.accessToken.token))
            .then((signedInUser) {
          print(signedInUser);
          Util.uid = signedInUser.uid;
          Util.userName = signedInUser.displayName;
          Util.emailId = signedInUser.email;
          Util.profilePic = signedInUser.photoUrl;

          NavigationRouter.switchToHome(context);
        }).catchError((e) {
          print(e);
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        facebooklogOut();
        break;
      default:
    }
  }

  Future<Null> facebooklogOut() async {
    await _facebookSignIn.logOut();
    print('Logged out.');
  }

  Future<String> verifyUser(
      BuildContext context, String email, String pwd) async {
    FirebaseUser fuser = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: pwd);
    Util.userName = fuser.displayName;
    Util.emailId = fuser.email;
    Util.profilePic = '';
    Util.uid = fuser.uid;
    NavigationRouter.switchToHome(context);

    return "Login Successfull";
  }
}
