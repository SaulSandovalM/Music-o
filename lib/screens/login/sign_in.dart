import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:music_finder/util/state_widget.dart';
import 'package:music_finder/util/auth.dart';
import 'package:music_finder/util/validator.dart';
import 'package:music_finder/widgets/loading.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final app = Hero(
      tag: 'hero',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              text: "Music'o \n",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: 'Entra',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 60.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  final email = Container(
    height: MediaQuery.of(context).size.height * 0.1,
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.white),
        labelText: 'Correo Electronico',
        hasFloatingPlaceholder: false,
        contentPadding: EdgeInsetsDirectional.only(bottom: 16.0),
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    )
  );

  final password = Container(
    height: MediaQuery.of(context).size.height * 0.1,
    child: TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
        labelText: 'Contraseña',
        hasFloatingPlaceholder: false,
        contentPadding: EdgeInsetsDirectional.only(bottom: 16.0),
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    )
  );

  final loginButton = Container(
    height: MediaQuery.of(context).size.height * 0.08,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        style: BorderStyle.solid,
        width: 2.0,
      ),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(0.0),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: RaisedButton(
        elevation: 0.0,
        color: Colors.transparent,
        padding: EdgeInsets.all(12),
        onPressed: () {
          _emailLogin(
            email: _email.text, password: _password.text, context: context);
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('INICIA SESION',
            style: TextStyle(fontSize: 14.0, color: Colors.white)),
        ),
      )),
  );

  final forgotSignUpLabel = Container(
    height: MediaQuery.of(context).size.height * 0.1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'REGISTRATE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
        Row(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
            )
          ],
        ),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: Colors.black,
    body: LoadingScreen(
      child: Center(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            children: <Widget>[
              app,
              email,
              password,
              loginButton,
              forgotSignUpLabel
            ],
          ),
        )
      ),
    inAsyncCall: _loadingVisible
    ),
  );
}

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/');
      } catch (e) {
        _changeLoadingVisible();
        print("Error de inicio de sesión: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Error de inicio de sesión",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
