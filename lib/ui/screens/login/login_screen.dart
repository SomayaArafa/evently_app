import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../firebase_utils/firestore_utility.dart';
import '../../model/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/constants.dart';
import '../../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.appLogo),
                const SizedBox(height: 48),
                const Text(
                  'Login to your account',
                  style: AppTextStyles.blue24SemiBold,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  hint: 'Enter your email',
                  controller: emailController,
                  prefixIcon: SvgPicture.asset(AppAssets.icEmailSvg),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'Enter your password',
                  controller: passController,
                  suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                  prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                  isPassword: true,
                ),
                const SizedBox(height: 8),
                Text(
                  'Forget password?',
                  textAlign: TextAlign.end,
                  style: AppTextStyles.blue14SemiBold.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 48),
                buildLoginButton(),
                const SizedBox(height: 48),
                InkWell(
                  onTap: () {
                    Navigator.push(context, AppRoutes.register);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account? ',
                        style: AppTextStyles.grey14Regular,
                      ),
                      Text(
                        'sign up',
                        style: AppTextStyles.blue14SemiBold.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.blue14SemiBold,
                ),
                const SizedBox(height: 32),
                EventlyButton(
                  text: 'login with google',
                  onPress: () async {
                    try {
                      showLoading(context);

                      final userCredential = await signInWithGoogle();
                      if (userCredential == null ||
                          userCredential.user == null) {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                        showMessage(context, 'Login cancelled',
                            title: 'Error', posText: 'Ok');
                        return;
                      }
                      UserDM.currentUser = await getUserFromFirestore(
                        userCredential.user!.uid,
                        userCredential.user,
                      );

                      Navigator.pop(context);
                      Navigator.push(context, AppRoutes.navigation);
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context);
                      var message = 'login failed';
                      showMessage(context, message,
                          title: 'error', posText: 'ok');
                    } catch (e) {
                      showMessage(context, AppConstants.defaultErrorMessage,
                          title: 'error', posText: 'ok');
                    }
                  },
                  backgroundColor: AppColors.white,
                  textStyle: AppTextStyles.blue18Medium,
                  icon: const Icon(Icons.g_mobiledata),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  EventlyButton buildLoginButton() => EventlyButton(
      text: 'Login',
      onPress: () async {
        try {
          showLoading(context);
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
          UserDM.currentUser =
              await getUserFromFirestore(credential.user!.uid, credential.user);

          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigation);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = '';
          if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            message = 'Wrong password provided for that user.';
          } else {
            message = e.message ?? AppConstants.defaultErrorMessage;
          }
          showMessage(context, message, title: 'error', posText: 'ok');
        } catch (e) {
          showMessage(context, AppConstants.defaultErrorMessage,
              title: 'error', posText: 'ok');
        }
      });
}

Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
