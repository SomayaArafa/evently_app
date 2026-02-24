import 'package:evenlyproject/ui/utils/app_assets.dart';
import 'package:evenlyproject/ui/utils/app_dialogs.dart';
import 'package:evenlyproject/ui/utils/app_routes.dart';
import 'package:evenlyproject/ui/utils/app_styles.dart';
import 'package:evenlyproject/ui/utils/constants.dart';
import 'package:evenlyproject/ui/widgets/evently_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../firebase_utils/firestore_utility.dart';
import '../../model/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.appLogo),
                  const SizedBox(height: 48),
                  const Text(
                    'Create your account',
                    style: AppTextStyles.blue24SemiBold,
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    controller: nameController,
                    hint: 'Enter your name',
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    validator: (text) {
                      if (text?.isEmpty == true) return "Please valid name";
                      return null;
                    },
                  ),
                  AppTextField(
                    hint: "Address",
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: addressController,
                    validator: (text) {
                      if (text?.isEmpty == true) return "Please valid address";
                      return null;
                    },
                  ),
                  AppTextField(
                    hint: "phone number",
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: phoneController,
                    validator: (text) {
                      if (text?.isEmpty == true || text!.length < 11)
                        return "Please valid phone number";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: 'Enter your email',
                    controller: emailController,
                    prefixIcon: SvgPicture.asset(AppAssets.icEmailSvg),
                    validator: (text) {
                      if (text?.isEmpty == true) return "Please valid email";
                      var isValid = RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(text!);
                      if(!isValid) return "this email is in invalid form";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: 'Enter your password',
                    controller: passController,
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.isEmpty == true)
                        return "Please enter valid password";
                      if (text.length < 6) {
                        return "Your password is weak";
                      }
                      return null;
                    },

                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    hint: 'confirm your password',
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.isEmpty == true)
                        return "Please enter valid password";
                      if (text != passController.text)
                        return "Password does not match";
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 48),
                  buildRegisterButton(),
                  const SizedBox(height: 48),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: AppTextStyles.grey14Regular,
                        ),
                        Text(
                          'login',
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
                    text: 'Signup with google',
                    onPress: () {},
                    backgroundColor: AppColors.white,
                    textStyle: AppTextStyles.blue18Medium,
                    icon: const Icon(Icons.g_mobiledata),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EventlyButton buildRegisterButton() => EventlyButton(
      text: 'Sign up',
      onPress: () async {
        if (!formKey.currentState!.validate()) return;

        try {
          showLoading(context);
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
          UserDM.currentUser = UserDM(
            id: credential.user!.uid,
            name: nameController.text,
            email: emailController.text,
            address: addressController.text,
            phoneNumber: phoneController.text,
          );

          createUserInFirestore(UserDM.currentUser!);
          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigation);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = '';
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists for that email.';
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
