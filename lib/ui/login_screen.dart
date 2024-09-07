import 'package:flutter/material.dart';
import 'package:flutter_quran/constants/constants.dart';
import 'package:flutter_quran/ui/main_screen.dart';
import 'package:get/get.dart';

import '../widgets/decoration_widget.dart';

class LoginController extends GetxController {
  // Controllers for the email and password fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Variables to store the email and password
  var email = ''.obs;
  var password = ''.obs;

  // For loading state
  var isLoading = false.obs;

  // Email validation
  String? validEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  // Password validation
  String? validPassword(String value) {
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  // Login method (you can replace it with actual login logic)
  void login(BuildContext context) {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isLoading.value = true;

      // Simulate a login process with a delay
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;

        // Redirect to MainScreen on successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
    } else {
      Get.snackbar("Error", "Please fill all the fields",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                            color: Constants.kPrimary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                            )),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 90,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 40,
                          right: 30,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 38, left: 8, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            // The validator receives the text that the user has entered.
                            controller: _loginController.emailController,
                            onSaved: (value) {
                              _loginController.email.value = value!;
                            },
                            validator: (value) {
                              return _loginController.validEmail(value!);
                            },
                            decoration: DecorationWidget(
                              context,
                              "Enter Email",
                              Icons.email,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextFormField(
                            obscureText: true,
                            controller: _loginController.passwordController,
                            onSaved: (value) {
                              _loginController.password.value = value!;
                            },
                            validator: (value) {
                              return _loginController.validPassword(value!);
                            },
                            decoration: DecorationWidget(
                                context, "Enter Password", Icons.vpn_key),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 40,
                          child: TextButton(
                              onPressed: () {
                                //Get.toNamed('/forgetPassword');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Constants.kPrimary),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                              },
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor: Constants.kPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "CormorantGaramond"),
                                  ),
                                  onPressed: () {
                                    _loginController.login(context);  // Passing context to login method
                                  },
                                  child: FittedBox(
                                    child: Obx(() => _loginController
                                        .isLoading.value
                                        ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                        : Text('Login', style: TextStyle(color: Colors.white),)),
                                  )),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?'),
                            TextButton(
                                onPressed: () {
                                  Get.offNamed('/register');
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Constants.kPrimary),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
