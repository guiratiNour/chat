/*import 'package:chat/firstPage.dart';
import 'package:chat/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  late TextEditingController
      _emailcntrl; //pour récupérer la valeur de text field
  late TextEditingController _passwordcntrl;
  String _emailerror = "";
  String _passworderror = "";

  @override
  void initState() {
    super.initState();
    _emailcntrl = TextEditingController();
    _passwordcntrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailcntrl.dispose();
    _passwordcntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  50), //ajoute 50 pixels d'espacement horizontal autour de son widget enfant
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailcntrl,
                  onTap: () {
                    setState(() {
                      //cette fonction est obligatoire pour que cette écriture "This field cannot be empty" apparait au début avant d'écrire
                      if (_emailcntrl.text.isEmpty) {
                        _emailerror = "This field cannot be empty";
                      } else {
                        _emailerror = "";
                      }
                    });
                  },
                  onChanged: (value) {
                    //cette fonction est nécessaire pour que lorsqu'on commence à écrire dans le champs cette écriture "This field cannot be empty" disparait
                    setState(() {
                      if (_emailcntrl.text.isEmpty) {
                        _emailerror = "This field cannot be empty";
                      } else {
                        _emailerror = "";
                      }
                    });
                  },
                  decoration: InputDecoration(
                    errorText: _emailerror.isNotEmpty ? _emailerror : null,
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordcntrl,
                  obscureText: _isObscure,
                  onTap: () {
                    setState(() {
                      if (_passwordcntrl.text.length < 8) {
                        _passworderror =
                            "Password should be at least 8 characters";
                      } else {
                        _passworderror = "";
                      }
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      if (_passwordcntrl.text.length < 8) {
                        _passworderror =
                            "Password should be at least 8 characters";
                      } else {
                        _passworderror = "";
                      }
                    });
                  },
                  decoration: InputDecoration(
                    errorText:
                        _passworderror.isNotEmpty ? _passworderror : null,
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    height: 60,
                    onPressed: () {
                      setState(() {
                        if (_emailcntrl.text.isEmpty) {
                          _emailerror = "Email field cannot be empty";
                        }
                        if (_passwordcntrl.text.length < 8) {
                          _passworderror =
                              "Password should be at least 8 characters";
                        }
                      });
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MyCustomPage()),
                      );
                    },
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        " Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/