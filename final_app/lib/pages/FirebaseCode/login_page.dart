import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../compenents/my_button.dart';
import '../../compenents/squaretile.dart';
import '../../compenents/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  // LoginPage({super.key});
  const LoginPage({this.onTap, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black),
              color: Colors.white, // Set the background color to white
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }

  // Error message
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade700,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height:10,
                // ),
                //logo
                const Icon(
                  Icons.lock_person,
                  size: 120,
                  color: Colors.black,
                ),
                //welcome back
                const SizedBox(height: 20),
                Text(
                  "Welcome Back !",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //user textfield
                MyTextField(
                  controller: emailController,
                  hinText: "Email",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 20,
                ),
                // password
                MyTextField(
                  controller: passwordController,
                  hinText: "Password",
                  obscureText: !showPassword,
                  suffixIcon: GestureDetector(
                    onTap: togglePasswordVisibility,
                    child: Icon(
                      showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                //forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forget Password ?",
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                //sign in

                // const MyButton(),
                MyButton(
                  onTap: signUserIn,
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 20,
                ),
                // continue with
                //or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
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

                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "images/G.png"),
                    SizedBox(
                      width: 10,
                    ),
                    SquareTile(imagePath: "images/A.png"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
