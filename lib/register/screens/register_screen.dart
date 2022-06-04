import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healing_travelling/login/screen/login_screen.dart';
import 'package:healing_travelling/register/domain/bloc/register_bloc.dart';
import 'package:healing_travelling/register/domain/models/register_model.dart';
import 'package:healing_travelling/register/domain/services/register_service.dart';
import 'package:healing_travelling/register/widget/custom_textfield_widget.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_button_widget.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:healing_travelling/widget/error_dialog_widget.dart';
import 'package:healing_travelling/widget/loading_dialog_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(RegisterService()),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isObscure = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                      text: 'DAFTAR',
                      fontWeight: FontWeight.w700,
                      fontSize: 31.0,
                    ),
                    SizedBox(height: 36,),
                    _subtitleWidget('Nama'),
                    SizedBox(height: 8,),
                    _textFieldNama(),
                    SizedBox(height: 24),
                    _subtitleWidget('Email'),
                    SizedBox(height: 8,),
                    _textFieldTelepon(),
                    SizedBox(height: 24),
                    _subtitleWidget('Kata Sandi'),
                    SizedBox(height: 8,),
                    _textFieldPassword(),
                    SizedBox(height: 24),
                    _subtitleWidget('Alamat'),
                    SizedBox(height: 8,),
                    _textFieldAlamat(),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _blocListenerRegister(context)
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
                              text: 'Sudah punya akun? ',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap= ()=> Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (_)=> LoginScreen())
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
        ),
      ),
    );
  }

  BlocListener<RegisterBloc, RegisterState> _blocListenerRegister(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async{
        if (state is RegisterSuccess) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'Daftar berhasil, silahakan login'
          );
        } else if (state is RegisterFailed) {
          Navigator.pop(context);
          await showDialog(
            context: context, 
            builder: (_)=> ErrorDialog(errorValue: state.errorValue)
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
          onPressed: () {
            context.read<RegisterBloc>().add(
              RegisterEventPost(
                register: Register(
                  nama: _nameController.text, 
                  password: _passwordController.text, 
                  email: _emailController.text, 
                  alamat: _alamatController.text, 
                )
              )
            );
          },
          text: 'Daftar',
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
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

  CustomTextFieldWidget _textFieldTelepon() {
    return CustomTextFieldWidget(
      hintText: 'Email',
      prefixIcon: Icons.mail,
      textInputType: TextInputType.emailAddress,
      controller: _emailController,
    );
  }

  CustomTextFieldWidget _textFieldAlamat() {
    return CustomTextFieldWidget(
      hintText: 'Alamat',
      prefixIcon: Icons.home,
      textInputType: TextInputType.text,
      controller: _alamatController,
    );
  }

  CustomTextFieldWidget _textFieldNama() {
    return CustomTextFieldWidget(
      hintText: 'Nama',
      prefixIcon: Icons.person,
      controller: _nameController,
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
}
