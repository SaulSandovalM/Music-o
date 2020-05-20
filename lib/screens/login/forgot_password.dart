import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:music_finder/util/auth.dart';
import 'package:music_finder/util/validator.dart';
import 'package:music_finder/widgets/loading.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              text: "Olvidaste algo? \n",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: 'Recupera tu contraseña',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 50.0,
                    height: 1.2,
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

    final forgotPasswordButton = Container(
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
              _forgotPassword(email: _email.text, context: context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('RECUPERAR CONTRASEÑA',
                  style: TextStyle(fontSize: 14.0, color: Colors.white)),
            ),
          )),
    );

    final signInLabel = FlatButton(
      padding: EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Iniciar Sesion',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      email,
                      SizedBox(height: 12.0),
                      forgotPasswordButton,
                      signInLabel
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _forgotPassword({String email, BuildContext context}) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        await Auth.forgotPasswordEmail(email);
        await _changeLoadingVisible();
        Flushbar(
          title: "Correo enviado",
          message:
          'Revisa tu correo y sigue las instrucciones para cambiar tu contraseña.',
          duration: Duration(seconds: 20),
        )..show(context);
      } catch (e) {
        _changeLoadingVisible();
        print("Error al recuperar contraseña: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Error al recuperar contraseña",
          message: exception,
          duration: Duration(seconds: 10),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}