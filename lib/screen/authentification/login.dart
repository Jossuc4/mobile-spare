import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oscapp/models/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _loginFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _loginFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _loginFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible =
          _loginFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    });
  }

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = _loginController.text;
    String password = _passwordController.text;

    if (login.isNotEmpty && password.isNotEmpty) {
      // Utiliser le provider pour enregistrer le login
      await Provider.of<LoginProvider>(context, listen: false)
          .saveLogin(login, password);
    }

    if (login.isNotEmpty && password.isNotEmpty) {
      await prefs.setString('login', login);
      await prefs.setString('password', password);

      Navigator.pushReplacementNamed(context, '/splash');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both login and password.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Spacer(),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 60,
                    maxWidth: 60,
                  ),
                  child: Image.asset(
                    'assets/Icons/Icone_2.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          // Apply the blur when the keyboard is visible
          Positioned(
            left: -110,
            top: -175,
            child: BackdropFilter(
              filter: _isKeyboardVisible
                  ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                width: 550,
                height: 550,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0CDE92),
                      Color(0xFF0CDE92),
                      Color(0xFF0CDE92),
                      Color(0xFF0BA56A),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 100,
            child: BackdropFilter(
              filter: _isKeyboardVisible
                  ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Center(
                child: _isKeyboardVisible
                    ? Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.12,
                        ),
                        textAlign: TextAlign.start,
                      )
                    : Text(
                        "Welcome\nBack !",
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.12,
                        ),
                        textAlign: TextAlign.start,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _loginController,
                    focusNode: _loginFocusNode,
                    decoration: const InputDecoration(
                      labelText: '  E-mail or Pseudo',
                      labelStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: !_passwordVisible,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () => _login(context),
                        child: Container(
                          height: 40,
                          width: 175,
                          decoration: BoxDecoration(
                            color: const Color(0xFF36C18B),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x00000000).withOpacity(0.1),
                                offset: const Offset(2, 4),
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dont have an account ?"),
                    Text(
                      " Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 90.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
