import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yelody_app/blocs/auth/social_login_bloc.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

class FirebaseAuthBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  User? _user;
  final SocialLoginBloc _socialLoginBloc = SocialLoginBloc();
  // final AppleLoginBloc _appleLoginBloc = AppleLoginBloc();

  ///-------------------- Google Sign In -------------------- ///
  Future<void> signInWithGoogle(
      {required BuildContext context, required String socialType}) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      await _googleSignIn.signOut();

      GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
      final userAccount = await _googleSignInAccount?.authentication;

      if (_googleSignInAccount != null && userAccount != null) {
        await _googleSignIn.signOut();

        // ignore: use_build_context_synchronously
        _socialLoginMethod(
          context: context,
          // userFullName: _googleSignInAccount.displayName,
          socialToken: userAccount.accessToken,
          // userEmail: _googleSignInAccount.email,
          // socialType: socialType,
        );
      }
    } catch (error) {
      print("error is " + error.toString());
      AppDialogs.showToast(message: error.toString());
    }
  }

  ///-------------------- Facebook Sign In -------------------- ///
  // Future<void> signInWithFacebook(
  //     {required BuildContext context, required String socialType}) async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login(
  //       permissions: ['public_profile', 'email'],
  //     );
  //     if (result.status == LoginStatus.success) {
  //       Map<String, dynamic> facebookUserData =
  //           await FacebookAuth.instance.getUserData();

  //       await FacebookAuth.instance.logOut();

  //       if (facebookUserData != null) {
  //         _socialLoginMethod(
  //             context: context,
  //             userFullName: facebookUserData["name"],
  //             socialToken: facebookUserData["id"],
  //             userEmail: facebookUserData["email"],
  //             socialType: socialType);
  //       }
  //     } else if (result.status == LoginStatus.failed) {
  //       AppDialogs.showToast(message: result.message.toString());
  //       //print(result.message.toString());
  //     } else if (result.status == LoginStatus.cancelled) {
  //       AppDialogs.showToast(message: result.message.toString());
  //       //print(result.message.toString());
  //     }
  //   } catch (error) {
  //     // print(error.toString());
  //     AppDialogs.showToast(message: error.toString());
  //   }
  // }

  //-------------------- Apple Sign In -------------------- //

  Future<void> signInWithApple(
      {required BuildContext context, required String socialType}) async {
    // https://yelodydemo.firebaseapp.com/__/auth/handler
    String _givenName, _familyName, _userFullName;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential != null) {
        _givenName = credential.givenName ?? "";
        _familyName = credential.familyName ?? "";
        _userFullName = _givenName + " " + _familyName;

        // print('Apple Creds' + credential.identityToken.toString());
        // print('Apple Creds' + credential.givenName.toString());
        // print('Apple Creds' + credential.familyName.toString());
        // print('Apple Creds' + credential.email.toString());

        _socialLoginMethod(
          context: context,
          socialType: 'apple',
          // userFullName: _googleSignInAccount.displayName,
          socialToken: credential.userIdentifier,
          // userEmail: _googleSignInAccount.email,
          // socialType: socialType,
        );

        // _socialLoginMethod(
        //   context: context,
        //   // userFullName:
        //   //     _userFullName.trim().isNotEmpty ? _userFullName.trim() : null,
        //   socialToken: credential.userIdentifier,
        //   // userEmail: credential.email,
        //   // socialType: socialType
        // );
      }
    } catch (error) {
      //print(error.toString());
      AppDialogs.showToast(message: error.toString());
    }
  }

  ////////////////////////// Phone Sign In //////////////////////////////////
  // Future<void> signInWithPhone(
  //     {required BuildContext context,
  //     required String countryCode,
  //     required String phoneNumber,
  //     required VoidCallback setProgressBar,
  //     required VoidCallback cancelProgressBar}) async {
  //   try {
  //     setProgressBar();
  //     FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: countryCode + phoneNumber,
  //         timeout: Duration(seconds: 60),
  //         verificationCompleted: (AuthCredential authCredential) async {
  //           print("verification completed");
  //         },
  //         verificationFailed: (FirebaseAuthException authException) {
  //           if (authException.code == AppStrings.INVALID_PHONE_NUMBER) {
  //             cancelProgressBar();
  //             AppDialogs.showToast(
  //                 message: AppStrings.INVALID_PHONE_NUMBER_MESSAGE);
  //           } else {
  //             cancelProgressBar();
  //             AppDialogs.showToast(message: authException.message);
  //           }
  //           //print(authException.message);
  //         },
  //         codeSent: (String verificationId, int? forceResendingToken) {
  //           //log("Verification Id:${verificationId}");
  //           cancelProgressBar();

  //           AppNavigation.navigateTo(
  //               StaticData.navigatorKey.currentContext!,
  //               OtpVerificationScreen(
  //                   otpType: AppStrings.PHONE_OTP_TYPE,
  //                   countryCode: countryCode,
  //                   phoneNo: phoneNumber,
  //                   phoneVerificationId: verificationId));
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           log("Timeout Verification id:${verificationId.toString()}");
  //         });
  //   } catch (error) {
  //     print("error is" + error.toString());
  //     log("error");
  //     cancelProgressBar();
  //     AppDialogs.showToast(message: error.toString());
  //   }
  // }

  // //
  // Future<void> verifyPhoneCode(
  //     {required BuildContext context,
  //     String? countryCode,
  //     String? phoneNo,
  //     required String verificationId,
  //     required String verificationCode,
  //     required VoidCallback setProgressBar,
  //     required VoidCallback cancelProgressBar}) async {
  //   try {
  //     setProgressBar();
  //     AuthCredential _credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: verificationCode);

  //     _userCredential = await _firebaseAuth.signInWithCredential(_credential);

  //     _user = _userCredential?.user;
  //     setProgressBar();
  //     if (_user != null) {
  //       await _firebaseUserSignOut();

  //       // API Call Here
  //       _socialLoginMethod(
  //         context: context,
  //         phoneNo: phoneNo,
  //         countryCode: countryCode,
  //         socialToken: _user?.uid,
  //         socialType: AppStrings.PHONE_AUTH_TEXT,
  //       );
  //     }
  //   } catch (error) {
  //     AppDialogs.showToast(message: error.toString());
  //     setProgressBar();
  //   }
  // }

  //
  //
  //
  // Future<void> resendPhoneCode(
  //     {required BuildContext context,
  //     required String countryCode,
  //     required String phoneNumber,
  //     required ValueChanged<String?> getVerificationId,
  //     required VoidCallback setProgressBar,
  //     required VoidCallback cancelProgressBar}) async {
  //   setProgressBar();
  //   try {
  //     _firebaseAuth.verifyPhoneNumber(
  //         phoneNumber: countryCode + phoneNumber,
  //         timeout: Duration(seconds: 60),
  //         verificationCompleted: (AuthCredential authCredential) async {},
  //         verificationFailed: (FirebaseAuthException authException) {
  //           cancelProgressBar();
  //           AppDialogs.showToast(message: authException.message);
  //           //print(authException.message);
  //         },
  //         codeSent: (String verificationId, int? forceResendingToken) {
  //           cancelProgressBar();
  //           getVerificationId(verificationId);
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           log(verificationId.toString());
  //         });
  //   } catch (error) {
  //     cancelProgressBar();
  //     AppDialogs.showToast(message: error.toString());
  //   }
  // }

  ///-------------------- Sign Out -------------------- ///
  Future<void> _firebaseUserSignOut() async {
    await _firebaseAuth.signOut();
  }

  void _socialLoginMethod({
    required BuildContext context,
    String? socialToken,
    String? socialType,
  }) {
    _socialLoginBloc.socialloginBlocMethod(
        context: context,
        isApple: socialType == 'apple',
        accessToken: socialToken ?? "",
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        });
  }
}
