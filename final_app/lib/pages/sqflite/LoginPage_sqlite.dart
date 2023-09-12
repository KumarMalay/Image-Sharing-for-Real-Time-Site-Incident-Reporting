import 'package:flutter/material.dart';
import '../../compenents/my_button.dart';
import '../../compenents/squaretile.dart';
import '../../compenents/textfield.dart';
import 'CustomBottomNavigation.dart';
import 'DatabaseHelper.dart';

class LoginPageSql extends StatefulWidget {
  final Function()? onTap;

  const LoginPageSql({this.onTap, Key? key}) : super(key: key);

  @override
  State<LoginPageSql> createState() => _LoginPageSqlState();
}

class _LoginPageSqlState extends State<LoginPageSql> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;

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
      showPassword = !showPassword;
    });
  }

  void signUserIn() async {
    // Check if email and password fields are not empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Do not sign in
      showErrorMessage(
          this.context, "Please enter all the required information.");
      return;
    }
    try {
      final user = await _databaseHelper.getUser(emailController.text);
      if (user != null && user.password == passwordController.text) {
        // User login successful
        // Navigate to the homepage
        Navigator.pushAndRemoveUntil(
            this.context,
            MaterialPageRoute(
              builder: (context) => CustomBottomNaviagtion(),
            ),
            (route) => false);
      } else {
        showErrorMessage(this.context, "Invalid Email or Password.");
      }
    } catch (e) {
      showErrorMessage(this.context, "Error logging in.");
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
                // Logo
                const Icon(
                  Icons.lock_person,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hinText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  hinText: "Password",
                  obscureText: !showPassword,
                  suffixIcon: GestureDetector(
                    onTap: togglePasswordVisibility,
                    child: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: signUserIn,
                  text: "Sign In",
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "images/G.png"),
                    SizedBox(
                      width: 10,
                    ),
                    SquareTile(imagePath: "images/A.png"),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
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
