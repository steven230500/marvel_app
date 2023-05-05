import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/modules/home/presentation/page/home.dart';
import 'package:marvel_app/modules/splash/presentation/bloc/bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<SplashBloc>()
        ..add(
          InitialEvent(),
        ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
      child: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset(
            'assets/images/marvel_logo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
