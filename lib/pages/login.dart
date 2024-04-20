import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:email_validator/email_validator.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String _account;
  late String _password;
  late bool _isSignIn;
  bool _isObscured=true;

  @override 
  void initState() {
    super.initState();
    _account = '';
    _password = '';
    _isSignIn = true;
  }

  Widget _menuItem({required String title, isActive = false, int mode = 0}) {
    // mode:0(regular) / 1(sign in) / 2(register)
    return GestureDetector(
      onTap: (){
        if(mode==1){
          setState(() {
            _isSignIn = true;
          });
        }
        else if(mode==2){
          setState(() {
            _isSignIn = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 75),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.deepPurple : Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              isActive
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
      return MouseRegion(
        onEnter: (event){isActive=true;},
        onExit: (event){isActive=false;},
        child: Container(
          width: 90,
          height: 70,
          decoration: isActive
              ? BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 10,
                      blurRadius: 30,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade400),
                ),
          child: Center(
              child: Container(
            decoration: isActive
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 2,
                        blurRadius: 15,
                      )
                    ],
                  )
                : BoxDecoration(),
            child: Image.asset(
              '$image',
              width: 35,
            ),
          )),
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          // Menu
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _menuItem(title: 'Home'),
                    _menuItem(title: 'About us'),
                    _menuItem(title: 'Contact us'),
                    _menuItem(title: 'Help'),
                  ],
                ),
                Row(
                  children: [
                    _isSignIn? _menuItem(title: 'Sign In', isActive: true, mode: 1):_menuItem(title: 'Sign In', isActive: false, mode: 1),
                    _isSignIn? _menuItem(title: 'Register', isActive: false, mode: 2):_menuItem(title: 'Register', isActive: true, mode: 2),
                  ],
                ),
              ],
            ),
          ),
          // Body
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Image.asset(
                      'images/diet.png',
                      width: MediaQuery.of(context).size.width*0.08,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Sign in to\nDiet Tracker',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "If you don't have an account",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          const TextSpan(text: 'You can  '),
                          TextSpan(
                              text: 'Register here!',
                              style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              Image.asset(
                'images/illustration-1.png',
                width: MediaQuery.of(context).size.width*0.2,
              ),
              _isSignIn ? Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height/25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Form(
                    key: GlobalKey<FormState>(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // standard sign-in
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter email or Phone number',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator:(value) {
                            if (value!.isNotEmpty && !EmailValidator.validate(value)){
                              return '請輸入正確信箱';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _account = newValue!.trim();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon:IconButton(
                              onPressed: () => setState(() => _isObscured = !_isObscured),
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              )),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: const TextStyle(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return '請輸入密碼';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _password = newValue!.trim();
                          },
                        ),
                        const SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.shade100,
                                spreadRadius: 10,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              // TODO:
                              // submitLoginForm(context);
                              Navigator.pushNamed(context, '/home');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepPurple,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child:const SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(child: Text("Sign In"))),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // other sign-in ways 
                        Row(children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],
                              height: 50,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Or continue with"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey[400],
                              height: 50,
                            ),
                          ),
                        ]),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO
                            _loginWithButton(image: 'images/google.png'),
                            _loginWithButton(image: 'images/github.png', isActive: true),
                            _loginWithButton(image: 'images/facebook.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : SizedBox(width: MediaQuery.of(context).size.width*0.3),
            ],
          )
        ],
      ),
    );
  }
}