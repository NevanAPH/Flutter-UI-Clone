import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import components
import '/components/button.dart';
import '/components/input.dart';

// Import utilities
import '/utils/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _menu = 0;
  bool _onSubmit = false;
  bool _showClear = false;

  String? _lastPhoneInput;
  String? _lastEmailInput;
  List<String> _selectedCountry = ["ID", "62"];

  String? _errorInput;
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      setState(() {
        _showClear = _inputController.text.isNotEmpty;

        if (_menu == 0) {
          _lastPhoneInput = _inputController.text;
        } else {
          _lastEmailInput = _inputController.text;
        }
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _goto(int num) {
    if (!_onSubmit) {
      setState(() {
        _menu = num;
        _errorInput = null;

        if (_menu == 0) {
          _inputController.text = _lastPhoneInput ?? "";
        } else {
          _inputController.text = _lastEmailInput ?? "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _selectedCountry =
          ModalRoute.of(context)!.settings.arguments as List<String>;
    }

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
                      "Enter phone or email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: "GG Sans",
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    Container(
                        decoration: BoxDecoration(
                          color: ThemeColor.input,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _menu == 0
                                        ? null
                                        : () {
                                            _goto(0);
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColor.input,
                                      disabledBackgroundColor:
                                          ThemeColor.primary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      minimumSize: const Size(0, 28),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      "Phone",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _menu == 1
                                        ? null
                                        : () {
                                            _goto(1);
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColor.input,
                                      disabledBackgroundColor:
                                          ThemeColor.primary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      minimumSize: const Size(0, 28),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _menu == 0 ? "Phone Number" : "Email",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    PrimaryInput(
                      controller: _inputController,
                      readOnly: _onSubmit,
                      inputFormatters: _menu != 0
                          ? []
                          : <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                      hint: _menu == 0 ? "Phone Number" : "Email",
                      errorText: _errorInput,
                      prefixIcon: _menu == 0
                          ? Container(
                              width: 88,
                              margin: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final result = await Navigator.of(context)
                                          .pushNamed('/countries');
                                      if (result != false) {
                                        setState(() {
                                          _selectedCountry =
                                              result as List<String>;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColor.input,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                      ),
                                      minimumSize: const Size(74, 44),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      "${_selectedCountry[0]} +${_selectedCountry[1]}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      width: 1,
                                      height: 44),
                                ],
                              ),
                            )
                          : null,
                      suffixIcon: _showClear
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              color: Colors.grey[600],
                              onPressed: () {
                                _inputController.clear();
                              },
                            )
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 24),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "View our Privacy Policy",
                        style: TextStyle(
                          color: ThemeColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: !_showClear || _onSubmit
                      ? null
                      : () {
                          setState(() {
                            _onSubmit = true;
                            _errorInput = null;
                          });

                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_menu == 0) {
                              if (_inputController.text.isEmpty) {
                                setState(() {
                                  _errorInput = "Phone number is required.";
                                  _onSubmit = false;
                                });
                              } else if (_inputController.text.length < 10) {
                                setState(() {
                                  _errorInput = "Phone number is too short.";
                                  _onSubmit = false;
                                });
                              } else {
                                Future.delayed(
                                    const Duration(milliseconds: 1300), () {
                                  setState(() {
                                    _onSubmit = false;
                                  });
                                  Navigator.of(context).pushNamed(
                                      '/register/otp',
                                      arguments: _selectedCountry[1] +
                                          _inputController.text);
                                });
                              }
                            } else {
                              if (_inputController.text.isEmpty) {
                                setState(() {
                                  _errorInput = "Email is required.";
                                  _onSubmit = false;
                                });
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(_inputController.text)) {
                                setState(() {
                                  _errorInput = "Email is invalid.";
                                  _onSubmit = false;
                                });
                              } else {
                                setState(() {
                                  _errorInput =
                                      "Email registration is not supported yet.";
                                  _onSubmit = false;
                                });
                                // Navigator.of(context).pushNamed(
                                //   '/register/otp',
                                //   arguments: _inputController.text
                                // );
                              }
                            }
                          });
                        },
                  loading: _onSubmit,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
