import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapclone/pages/bloc/home_page_bloc.dart';
import 'package:snapclone/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 13,
      navigateAfterSeconds: BlocProvider(
        create: (_) => HomePageBloc(),
        lazy: false,
        child: HomePageView(),
      ),
      title: Text(
        "Face Masks",
        style: TextStyle(
            fontFamily: "Signatra",
            color: Colors.deepPurpleAccent,
            fontSize: 35),
      ),
      image: Image.asset("assets/images/icon.png"),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.blueAccent,
      loadingText: Text(
        "from Dineth Prabashwara",
        style: TextStyle(
            color: Colors.blueAccent, fontSize: 15, fontFamily: "Brand Bold"),
      ),
    );
  }
}
