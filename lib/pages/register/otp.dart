import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import utilities
import '/utils/colors.dart';

class RegOtpPage extends StatefulWidget {
  const RegOtpPage({super.key});

  @override
  State<RegOtpPage> createState() => _RegOtpPageState();
}

class _RegOtpPageState extends State<RegOtpPage> {

  bool _onSubmit = false;
  bool _showClear = false;

  String? _errorInput;
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      setState(() {
        _showClear = _inputController.text.isNotEmpty 
          && _inputController.text.length >= 6;
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
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
                      "Enter your confirmation code",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: "GG Sans",
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                      Text(
                        "An SMS has been sent to +$phoneNumber.",
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
                    Stack(
                      children: [
                        TextField(
                          controller: _inputController,
                          readOnly: _onSubmit,
                          
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(6),
                          ],

                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColor.input,
                            errorText: _errorInput,
                            errorStyle: TextStyle(
                                color: ThemeColor.error,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: _errorInput == null
                                  ? BorderSide.none
                                  : BorderSide(color: ThemeColor.error),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 16, right: 48),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            if (_showClear)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                color: Colors.grey[600],
                                onPressed: () {
                                  _inputController.clear();
                                },
                              )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: !_showClear || _onSubmit
                      ? null
                      : () {
                          setState(() {
                            _onSubmit = true;
                            _errorInput = null;
                          });

                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              _errorInput =
                                  "Verification is not supported yet.";
                              _onSubmit = false;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColor.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        ThemeColor.primary.withOpacity(0.6),
                    disabledForegroundColor: Colors.white.withOpacity(0.6),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: _onSubmit
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Verify",
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
