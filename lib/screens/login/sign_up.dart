import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:music_finder/models/user.dart';
import 'package:music_finder/util/auth.dart';
import 'package:music_finder/util/validator.dart';
import 'package:music_finder/widgets/loading.dart';

class SignUp extends StatefulWidget {
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

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
        height: MediaQuery.of(context).size.height * 0.4,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              text: "Eres Nuevo \n",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: 'Registrate',
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

    final firstName = Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextFormField(
          autofocus: false,
          textCapitalization: TextCapitalization.sentences,
          controller: _firstName,
          validator: Validator.validateName,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: Colors.white),
            labelText: 'Nombre',
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
          style: TextStyle(color: Colors.white),
        )
    );

    final lastName = Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        controller: _lastName,
        validator: Validator.validateName,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.white),
          labelText: 'Apellido',
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
        style: TextStyle(color: Colors.white),
      )
    );

    final email = Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: _email,
        validator: Validator.validateEmail,
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
        style: TextStyle(color: Colors.white),
      ),
    );

    final password = Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          controller: _password,
          validator: Validator.validatePassword,
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
          style: TextStyle(color: Colors.white),
        ));

    final signUpButton = Container(
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
              _emailSignUp(
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  email: _email.text,
                  password: _password.text,
                  context: context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('REGISTRATE',
                  style: TextStyle(fontSize: 14.0, color: Colors.white)),
            ),
          )),
    );

    final signInLabel = Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: FlatButton(
        child: Text.rich(
          TextSpan(
            text: 'Ya tienes cuenta, ',
            style: TextStyle(color: Colors.white70, fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                text: 'Inicia Sesión',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/signin');
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            children: <Widget>[
              logo,
              firstName,
              lastName,
              email,
              password,
              signUpButton,
              signInLabel
            ],
          ),
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

  void _emailSignUp({
    String firstName,
    String lastName,
    String email,
    String password,
    BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((uID) {
          Auth.addUserSettingsDB(new User(
            userId: uID,
            email: email,
            firstName: firstName,
            lastName: lastName,
          ));
        });
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Error al registrar: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Error al registrar",
          message: exception,
          duration: Duration(seconds: 5),
        )
          ..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}