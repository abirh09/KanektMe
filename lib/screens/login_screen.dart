import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanektme/widgets/snackbar.dart';
import 'package:kanektme/services/auth_service.dart';
import 'package:kanektme/utils/validators.dart';
import 'package:kanektme/widgets/custom_loader.dart';
import 'package:kanektme/widgets/custom_textbox.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Consumer<AuthService>(
        builder: (context, authService, _) {
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextbox(controller: _emailController, hintText: "Enter Email", needValidation: true, errorMessage: "Please enter correct email", fieldTitle: "Email", validatorClass: ValidatorClass().validateEmail,),
                CustomTextbox(controller: _passwordController, hintText: "Enter Password", needValidation: true, errorMessage: "Please enter correct password", fieldTitle: "Password", validatorClass: ValidatorClass().validatePassword,obscure: true,),
                authService.isLoading?CustomLoader():Row(
                  children: [
                    Expanded(child: CustomButton(onTap: () async {
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        await authService.signInWithEmailAndPassword(email:_emailController.text, password:_passwordController.text,);
                        if (authService.errorMessage != null) {
                          showSnackBar(context: context, title: authService.errorMessage.toString(),failureMessage: true);
                        } else if (authService.user != null) {

                          showSnackBar(context: context, title: "Successful Login", failureMessage: false);
                        }
                      }
                    }, label: "Login")),
                    Expanded(child: CustomButton(onTap: () async {
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        await authService.signUpWithEmailAndPassword(email:_emailController.text,password: _passwordController.text,);
                        if (authService.errorMessage != null) {
                          showSnackBar(context: context, title: authService.errorMessage.toString(), failureMessage: true);
                        } else if (authService.user != null) {
                          showSnackBar(context: context, title: "Successful Signup", failureMessage: false);
                        }
                      }
                    }, label: "Sign up")),
                  ],
                ),
              ],
            ),
          ),
        );},
      ),
    ),);
  }
}
