import 'package:flutter/material.dart';
import 'auth_bloc.dart';

export 'auth_bloc.dart';

class AuthProvider extends InheritedWidget {
  final bloc;

  AuthProvider({Key key, Widget child}) :
    bloc = AuthBloc(), super(key:key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthBloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider).bloc;

}