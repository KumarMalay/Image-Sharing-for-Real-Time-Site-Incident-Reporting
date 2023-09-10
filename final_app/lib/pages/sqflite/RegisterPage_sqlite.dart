import 'package:final_app/pages/sqflite/HomePageSql.dart';
import 'package:final_app/pages/sqflite/LoginPage_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:final_app/compenents/textfield.dart';
import 'package:final_app/compenents/my_button.dart';
import 'package:final_app/compenents/squaretile.dart';
import 'DatabaseHelper.dart';
import 'HomePageNew.dart';

class RegisterPageSql extends StatefulWidget {
  final Function()? onTap;

  const RegisterPageSql({this.onTap, super.key});

  @override
  State<RegisterPageSql> createState() => _RegisterPageSqlState();
}

class _RegisterPageSqlState extends State<RegisterPageSql> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _databaseHelper.initializeDatabase();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  void signUserUp(BuildContext context) async {
    // Check if passwords match
    if (passwordController.text == confirmPasswordController.text) {
      // Check if email is empty
      if (emailController.text.isEmpty) {
        showErrorMessage(context, "Please enter email");
        return;
      }

      // Check if password is empty
      if (passwordController.text.isEmpty) {
        showErrorMessage(context, "Please enter password");
        return;
      }

      final existingUser = await _databaseHelper.getUser(emailController.text);
      if (existingUser != null) {
        showErrorMessage(context, "Email is already used.");
        return;
      }

      // Insert user into database
      await _databaseHelper.insertUser(
        User(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPageSql(),
        ),
      );
      showErrorMessage(context, "Successfully registered. You can now log in.");
    } else {
      showErrorMessage(context, "Passwords don't match!");
    }
  }

  // Error message
  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Colors.white, // Transparent border color
              width: 2.0, // Border width
            ),
          ),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
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
                  Icons.account_box_outlined,
                  size: 120,
                  color: Colors.white,
                ),
                //welcome back
                const SizedBox(height: 20),
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.white,
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
                  obscureText: !isPasswordVisible,
                  // Toggle obscureText based on state
                  suffixIcon: GestureDetector(
                    onTap: togglePasswordVisibility,
                    // Toggle password visibility on tap
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Confirm Password TextField with Show Password functionality
                MyTextField(
                  controller: confirmPasswordController,
                  hinText: "Confirm Password",
                  obscureText: !isConfirmPasswordVisible,
                  // Toggle obscureText based on state
                  suffixIcon: GestureDetector(
                    onTap: toggleConfirmPasswordVisibility,
                    // Toggle password visibility on tap
                    child: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //sign in

                // const MyButton(),
                MyButton(
                  onTap: () => signUserUp(context),
                  text: "Sign Up",
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
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
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
                  height: 35,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
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
