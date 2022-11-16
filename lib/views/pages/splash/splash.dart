import 'dart:async';

import 'package:ceiba/providers/users_provider.dart';
import 'package:ceiba/services/data_user.dart';
import 'package:ceiba/views/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();
  }

  initData() async {
    await context.read<UsersProvider>().getUser();

    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFF014A51),
            body: Center(
              child: Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF014A51),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(79.5, 78.0)),
                  image: const DecorationImage(
                    image: AssetImage("assets/image/logo.png"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: const Offset(0, 3.0),
                      blurRadius: 69.0,
                    ),
                  ],
                ),
              ),
            )));
  }
}
