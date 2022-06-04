import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healing_travelling/auth/screens/auth_screen.dart';
import 'package:healing_travelling/login/bloc/login_bloc.dart';
import 'package:healing_travelling/login/domain/services/login_service.dart';
import 'package:healing_travelling/register/screens/register_screen.dart';
import 'package:healing_travelling/register/widget/custom_textfield_widget.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_button_widget.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:healing_travelling/widget/loading_dialog_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginService()),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _telpController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 15,
                  offset: Offset(0, 4)
                )
              ]
            ),
            padding: EdgeInsets.fromLTRB(24, 24, 24, 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: 'MASUK',
                  fontWeight: FontWeight.w700,
                  fontSize: 31.0,
                ),
                SizedBox(height: 36,),
                _subtitleWidget('Email'),
                SizedBox(height: 8,),
                _textFieldEmail(),
                SizedBox(height: 24),
                _subtitleWidget('Kata Sandi'),
                SizedBox(height: 8,),
                _textFieldPassword(),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _blocListenerLoginBtn(context)
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14
                      ),
                      children: [
                        TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        TextSpan(
                          text: 'Daftar',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap= ()=> Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (_)=> RegisterScreen())
                          )
                        ),
                      ]
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align _subtitleWidget(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomTextWidget(
        text: title,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }

  CustomTextFieldWidget _textFieldPassword() {
    return CustomTextFieldWidget(
      hintText: 'Kata sandi',
      prefixIcon: Icons.lock,
      obscureText: isObscure ? true : false,
      suffixIcon:
          isObscure == true ? Icons.visibility_off : Icons.visibility,
      onTap: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      controller: _passwordController,
    );
  }

  CustomTextFieldWidget _textFieldEmail() {
    return CustomTextFieldWidget(
      hintText: 'Email',
      prefixIcon: Icons.mail,
      textInputType: TextInputType.phone,
      controller: _telpController,
    );
  }

  BlocListener<LoginBloc, LoginState> _blocListenerLoginBtn(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_)=> AuthScreen()
            ),
            (route) => false
          );
        } else if (state is LoginFailed) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'login gagal, ${state.errorValue}'
          );
        } else {
          showDialog(context: context, builder: (_) => LoadingDialog());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 25,
              offset: Offset(0, 4)
            )
          ]
        ),
        child: CustomButtonWidget(
          borderRadius: 16,
          onPressed: () =>
            context.read<LoginBloc>()
              ..add(LoginEventPost(
                  email: _telpController.text,
                  password: _passwordController.text
                )
              ),
          text: 'Masuk',
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
      ),
    );
  }
}
