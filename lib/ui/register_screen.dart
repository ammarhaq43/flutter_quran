import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran/constants/constants.dart';
import 'package:get/get.dart';
import '../widgets/decoration_widget.dart';

// RegisterController is now defined
class RegisterController extends GetxController {
  var isLoading = false.obs;
  var formKey = GlobalKey<FormState>();

  // Controllers for the TextFormFields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String name = '';
  String email = '';
  String password = '';

  // Validation methods
  String? validName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? validEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Registration function
  void registration() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      formKey.currentState!.save();

      // You can add your registration logic here
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        Get.snackbar("Success", "Registered Successfully",
            snackPosition: SnackPosition.BOTTOM);
      });
    }
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Instantiating the RegisterController
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _registerController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
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
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          right: 30,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _registerController.nameController,
                              onSaved: (value) {
                                _registerController.name = value!;
                              },
                              validator: (value) {
                                return _registerController.validName(value!);
                              },
                              decoration: DecorationWidget(
                                context,
                                "User Name",
                                Icons.person,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              controller: _registerController.emailController,
                              onSaved: (value) {
                                _registerController.email = value!;
                              },
                              validator: (value) {
                                return _registerController.validEmail(value!);
                              },
                              decoration: DecorationWidget(
                                context,
                                "Email",
                                Icons.email,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: _registerController.passwordController,
                              onSaved: (value) {
                                _registerController.password = value!;
                              },
                              validator: (value) {
                                return _registerController.validPassword(value!);
                              },
                              decoration: DecorationWidget(
                                context,
                                "Password",
                                Icons.vpn_key,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Constants.kPrimary,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 10,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'CormorantGaramond',
                                ),
                              ),
                              child: Obx(() {
                                return _registerController.isLoading.value
                                    ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : Text('Register');
                              }),
                              onPressed: () {
                                _registerController.registration();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ? '),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Constants.kPrimary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
