import 'package:bookshop/image/Images.dart';
import 'package:bookshop/services/AuthService.dart';
import 'package:bookshop/views/ExchangeRatesScreen.dart';
import 'package:bookshop/views/SignupScreen.dart';
import 'package:bookshop/widgets/CustomButtom.dart';
import 'package:bookshop/widgets/CustomHeader.dart';
import 'package:bookshop/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool showPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: 'Login',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              ImagesPath.loginImage,
              width: 150,
              height: 150,
            ),
            Column(
              children: [
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  obscureText: false,
                  labelStyle: TextStyle(fontSize: 18),
                  hintStyle: TextStyle(fontSize: 16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.grey[200],
                  borderColor: Colors.grey[400],
                  borderRadius: 10,
                  borderWidth: 1,
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  focusBorderColor: Colors.pink,
                  focusLabelColor: Colors.pink,
                  focusBorderWidth: 2,
                  prefixIcon: Icon(Icons.mail, color: Colors.grey[600]),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: showPassword,
                  labelStyle: TextStyle(fontSize: 18),
                  hintStyle: TextStyle(fontSize: 16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.grey[200],
                  borderColor: Colors.grey[400],
                  borderRadius: 10,
                  borderWidth: 1,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  focusBorderColor: Colors.pink,
                  focusLabelColor: Colors.pink,
                  focusBorderWidth: 2,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[600]),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  onEditingComplete: () {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signupscreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.pink,
                          decorationColor: Colors.pink,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 1,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                CustomButton(
                  text: 'Login',
                  textStyle: TextStyle(fontSize: 18),
                  color: Colors.pink,
                  focusColor: Colors.white,
                  disabledColor: Colors.grey[300],
                  splashColor: Colors.grey[400],
                  elevation: 4,
                  borderRadius: 10,
                  fullWidth: true,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please enter email and password')),
                      );
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }

                    final user =
                        await _authService.signInWithEmail(email, password);

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExchangeRatesScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to login')),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  loading: isLoading,
                  disabled: false,
                )
              ],
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}
