import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'auth_validator.dart';

enum AuthMode { Signup, Login }

class AuthBloc extends Object with AuthValidator {
  //
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Stream<bool> get passwordConfirmed => Observable.combineLatest2(
      password, _confirmPasswordController.stream, (p, cp) => p == cp);

  // sign up should only be valid when submit is valid (e.g. both email and password are valid)
  // AND password is confirmed
  Stream<bool> get signupValid => Observable.combineLatest2(
      submitValid, passwordConfirmed, (s, pc) => s && pc);

  // sink
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword =>
      _confirmPasswordController.sink.add;

  Future<bool> submit(AuthMode authMode) async {
    final validPassword = _passwordController.value;
    if (authMode == AuthMode.Login) {
      return validPassword == '123456'; // dummy security!
    }
    return true; // sign up is always allowed with valid email and confirmed password.
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    print('bloc disposed');
  }
}
