import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/auth/bloc/auth_bloc.dart';
import 'package:healing_travelling/injection_container.dart';
import 'package:healing_travelling/login/presentation/pages/login_screen.dart';
import 'package:healing_travelling/navbar/screens/navbar_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl())..add(AuthEventCheckAuth()),
      child: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is AuthAuthenticated){
          return NavbarScreen();
        } else if (state is AuthUnauthenticated){
          return LoginScreen();
        } else {
          return Container();
        }
      },
    );
  }
}