import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/Components_Ui/button.dart';
import 'package:medi_connect/Components_Ui/square_tile.dart';
import 'package:medi_connect/Components_Ui/text_field.dart';
import 'package:medi_connect/models/user_model.dart';
import 'package:medi_connect/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  bool _loading = false;

  // Password Controller
  final passwordController = TextEditingController();

  // Confirm Password Controller
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign user up method
  void signUpUser() async {
    // show loading circle

    // try creating the user
    try {
      // check if password is confirmed
      _loading = true;
      if (passwordController.text == confirmPasswordController.text) {
        UserModel user = UserModel(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        await AuthServices.registerUser(user);
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: emailController.text,
        //   password: passwordController.text,
        // );
      } else {
        // show the error message, passwords do not match.
        _loading = false;
        showErrorMessage("Passwords don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 153, 81, 76),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 254, 254),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // logo icon
                // const Icon(
                //   Icons.lock,
                //   size: 100,
                // ),

                // image logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Image.asset(
                    'lib/img/mechanical-logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),

                const SizedBox(height: 10),

                // Please Create an account
                const Text(
                  'Create your account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 114, 114, 114),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // login button
                _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : MyButton(
                        text: "Register",
                        onTap: signUpUser,
                      ),

                const SizedBox(height: 50),

                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Google and Apple login buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/img/google-logo.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/img/apple-logo.png'),
                  ],
                ),

                const SizedBox(height: 50),

                // Not a registered User? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
