import 'dart:async';

// a dummy validator
class AuthValidator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@'))
      sink.add(email);
    else
      sink.addError('Email is not valid');
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6)
      sink.add(password);
    else
      sink.addError('Password must be at least 6 characters');
  });
}
