import 'package:flutter/material.dart';
import 'auth.dart';
import 'auth_provider.dart';

void main() =>
    runApp(AuthProvider(child: MaterialApp(title: '', home: Auth())));
