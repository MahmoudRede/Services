import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/styles/color_manager/color_manager.dart';

class VerifiedScreen extends StatelessWidget {
  const VerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorManager.darkGrey,
        title: Text(AppLocalizations.of(context)!.translate('reviewPhase').toString(),style:GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ColorManager.white,
        ),),

      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(

            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.08,),
              Lottie.asset('assets/images/test.json',),
              Text(
                AppLocalizations.of(context)!.translate('reviewMessage').toString(),
                style: GoogleFonts.cairo(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
      ),
    );
  }
}
