import 'dart:async';

class AuthValidator {

  static String userName(String username) {
    if(username.length < 4 || username.length > 20) return "Name must be between 4 and 20 characters";
    return null;
  }

  // static String email2(String email) {
  //   if (email.contains('@')) return null;
  //   return "Invalid email";
  // }

  // static String password2(String password) {
  //   if (password.length < 6 || password.length > 20) return "Password must be between 6 and 20 characters";
  //   return null;
  // }

  static String confirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return "Two passwords don't match";
    return null;
  }

  final validateUserName = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink) {
      if (username.length >= 4) sink.add(username);
      else sink.addError('Name is too short');
    }
  );


  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) sink.add(email);
      else sink.addError('Email is not valid');
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) sink.add(password);
      else sink.addError('Password must be at least 6 characters');
    }
  );
}

