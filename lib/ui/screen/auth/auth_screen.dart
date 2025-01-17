import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws_hieuvm_ecommerce_flutter/common/app_image.dart';
import 'package:nws_hieuvm_ecommerce_flutter/ui/screen/auth/auth_cubit.dart';
import 'package:nws_hieuvm_ecommerce_flutter/ui/widget/button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: const LoginOrSignUpScreenBody(),
    );
  }
}

class LoginOrSignUpScreenBody extends StatefulWidget {
  const LoginOrSignUpScreenBody({super.key});

  @override
  State<LoginOrSignUpScreenBody> createState() =>
      _LoginOrSignUpScreenBodyState();
}

class _LoginOrSignUpScreenBodyState extends State<LoginOrSignUpScreenBody> {
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: const Image(
              image: AssetImage(AppImages.imgStartLogin),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
          ),
          const Center(
            child: Image(
              image: AssetImage(AppImages.icLogoWhite),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        authCubit.navSignIn(context);
                      },
                      child: const Button(
                        textButton: 'Sign In',
                        colorButton: 0xFFFFFFFF,
                        colorText: 0xff000000,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        authCubit.navSignUp(context);
                      },
                      child: const BorderButton(textButton: 'Sign up'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
