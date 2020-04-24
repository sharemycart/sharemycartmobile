import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharemycartmobile/services/auth_service.dart';
import 'package:sharemycartmobile/views/custom_button.dart';
import 'package:sharemycartmobile/views/home/home_page.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    bool loggedIn = user != null;

    if (loggedIn) {
      print(user.uid);
      return HomePage();
    } else {
      return AuthLoginPage();
    }
  }
}

class AuthLoginPage extends StatefulWidget {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {

  AuthService authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white.withOpacity(0.1), Colors.deepOrangeAccent.withOpacity(0.7)],
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image(image: AssetImage('assets/sharemycart.png'), height: 100, width: 100),
            ),
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Form(
                key: widget._formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2),
                      child: TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter your email address";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.email = value;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                      padding: EdgeInsets.all(2),
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0)
                          ),
                          hintText: "Password",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter your password";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.password = value;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    CustomButton(text: "Login", width: 300, onPressed: () {
                      if (widget._formKey.currentState.validate()) {
                        widget._formKey.currentState.save();
                        authService.signInWithEmailAndPassword(widget.email, widget.password);
                      }
                    }),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    MaterialButton(
                      child: Text("SignIn with Google"),
                      onPressed: () {
                        authService.signInWithGoogle();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

