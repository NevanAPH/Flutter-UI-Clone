import 'package:flutter/material.dart';

// Import components
import '/components/button.dart';
import '/components/input.dart';

// Import utilities
import '/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _onSubmit = false;
  bool _showClear = false;
  bool _showPass = false;

  String? _errorUser;
  String? _errorPass;

  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.addListener(() {
      setState(() {
        _showClear = _userController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/backgrounds/login.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
              color: ThemeColor.background,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome back!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: "GG Sans",
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We're so excited to see you again!",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Information",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      PrimaryInput(
                        controller: _userController,
                        readOnly: _onSubmit,
                        hint: "Email or Phone Number",
                        suffixIcon: _showClear
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                color: Colors.grey[600],
                                onPressed: () {
                                  _userController.clear();
                                },
                              )
                            : null,
                        errorText: _errorUser,
                      ),
                      const SizedBox(height: 8),
                      PrimaryInput(
                        controller: _passController,
                        readOnly: _onSubmit,
                        obscureText: !_showPass,
                        hint: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPass ? Icons.visibility_off : Icons.visibility,
                          ),
                          color: Colors.grey[600],
                          onPressed: () {
                            setState(() {
                              _showPass = !_showPass;
                            });
                          },
                        ),
                        errorText: _errorPass,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _onSubmit = true;
                            _errorUser = null;
                            _errorPass = null;
                          });

                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_userController.text.isEmpty) {
                              setState(() {
                                _errorUser = _userController.text.isEmpty
                                    ? "This field is required"
                                    : null;
                                _onSubmit = false;
                              });
                              return;
                            }

                            Future.delayed(const Duration(milliseconds: 1500),
                                () {
                              setState(() {
                                final isPhone = RegExp(r"^\d{10,12}$")
                                    .hasMatch(_userController.text);
                                _errorUser =
                                    "${isPhone ? "Email" : "Phone number"} does not exist.";
                                _onSubmit = false;
                              });
                            });
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(0, 24),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: const Size(0, 24),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Use a password manager?",
                          style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: _onSubmit
                          ? null
                          : () {
                              setState(() {
                                _onSubmit = true;
                                _errorUser = null;
                                _errorPass = null;
                              });
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                if (_userController.text.isEmpty ||
                                    _passController.text.isEmpty) {
                                  setState(() {
                                    _errorUser = _userController.text.isEmpty
                                        ? "This field is required"
                                        : null;
                                    _errorPass = _passController.text.isEmpty
                                        ? "This field is required"
                                        : null;
                                    _onSubmit = false;
                                  });
                                  return;
                                }

                                Future.delayed(
                                    const Duration(milliseconds: 2200), () {
                                  setState(() {
                                    _errorUser =
                                        "Login or password is invalid.";
                                    _errorPass =
                                        "Login or password is invalid.";
                                    _onSubmit = false;
                                  });
                                });
                              });
                            },
                      loading: _onSubmit,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in with passkey",
                      style: TextStyle(
                        color: ThemeColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
