
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:services/presentation/screens/home_screen.dart';
import 'package:services/presentation/screens/login_screen.dart';
import 'package:services/presentation/screens/services_screen.dart';
import 'package:services/presentation/screens/start_screen.dart';
import 'package:services/styles/color_manager/color_manager.dart';
import 'package:services/uitiles/local/cash_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2),(){

      if(CashHelper.getData(key: 'uId')!=null && CashHelper.getData(key: 'uId')!='1'){
        print(CashHelper.getData(key: 'uId'));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const ServicesScreen()
        ), (Route<dynamic> route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const LoginScreen()
        ), (Route<dynamic> route) => false);
      }



    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: ColorManager.darkGrey,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [

             Lottie.asset(
               'assets/images/splash.json',
               height: MediaQuery.of(context).size.height*.4,
               width: MediaQuery.of(context).size.height*.32,
             ),

            Text(
              'دكانه',
              style: GoogleFonts.cairo(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                color: ColorManager.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,)          ],
        ),
      ),
    );
  }
}
