import 'dart:async';
import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'home.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  AuthMode _authMode = AuthMode.Login;
  bool get _isLoginMode => _authMode == AuthMode.Login;
  Future<bool> _authFuture;

  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            emailField(bloc),
            passwordField(bloc),
            confirmPasswordField(bloc),
            loginOrSignupButton(bloc),
            Divider(
              color: Colors.grey[600],
              height: 8.0,
            ),
            FlatButton(
              child: Text(
                  "${_isLoginMode ? 'New User? SIGN UP' : 'Already Have An Account? LOG IN'}"),
              onPressed: swithAuthMode,
            ),
          ],
        ),
      ),
    );
  }

  void swithAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  Widget confirmPasswordField(AuthBloc bloc) {
    return _isLoginMode
        ? Container()
        : StreamBuilder(
            stream: bloc.passwordConfirmed,
            builder: (context, snapshot) {
              return TextField(
                obscureText: true,
                maxLength: 20,
                onChanged: bloc.changeConfirmPassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'enter the same password to confirm',
                  errorText: //snapshot.error,
                      snapshot.hasData && !snapshot.data
                          ? "Two passwords don't match"
                          : null,
                ),
              );
            },
          );
  }

  Widget emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
          decoration: InputDecoration(
              hintText: 'Email',
              //labelText: 'Email',
              errorText: snapshot.error,
              prefixIcon: Icon(Icons.email)),
        );
      },
    );
  }

  Widget passwordField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (_, snapshot) {
        return TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            //labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            errorText: snapshot.error,
            hintText: 'Password',
          ),
        );
      },
    );
  }

  Widget loginOrSignupButton(AuthBloc bloc) {
    return StreamBuilder(
        stream: _isLoginMode ? bloc.submitValid : bloc.signupValid,
        initialData:  false,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
            child: FutureBuilder(
              initialData: false,
              future: _authFuture,
              builder: (_, AsyncSnapshot<bool> snap) {
                if (snap.connectionState != ConnectionState.none &&
                    snap.connectionState != ConnectionState.done)
                  return Center(child: CircularProgressIndicator());
                print('authMode: $_authMode, ${snapshot.data}');            
                return RaisedButton(
                  onPressed: snapshot.hasError || !snapshot.hasData || !snapshot.data
                      ? null
                      : () => onSubmitPressed(bloc),
                  color: Colors.blue,
                  child: Text('${_isLoginMode ? 'LOG IN' : 'SIGN UP'}'),
                );
              },
            ),
          );
        });
  }

  Future<dynamic> onSubmitPressed(AuthBloc bloc) async {
    setState(() {
      _authFuture = bloc.submit(_authMode);
    });
    var response = await _authFuture;

    if (response) {
      return await Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      return showDialog(
          context: context,
          builder: (context1) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('invalid log in'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context1).pop();
                  },
                ),
              ],
            );
          });
    }
  }
}
