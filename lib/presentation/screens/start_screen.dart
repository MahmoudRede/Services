import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/presentation/screens/login_screen.dart';
import 'package:services/presentation/screens/services_screen.dart';
import 'package:services/presentation/screens/view_services.dart';
import 'package:services/presentation/widgets/defualtButton.dart';
import 'package:services/styles/color_manager/color_manager.dart';
import 'package:services/uitiles/local/cash_helper.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

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
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [

          Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                  onPressed: (){
                      CashHelper.saveData(key: 'uId',value: '1');
                      print(CashHelper.getData(key: 'uId'));
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                       LoginScreen()
                      ), (Route<dynamic> route) => false);
                    },
                  icon: const Icon(
                    Icons.login_outlined,color: Colors.white,
                  )
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .03,),

          Padding(
            padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
            child: Lottie.asset(
              'assets/images/chosse.json',
              height: MediaQuery.of(context).size.height*.37,
              width: MediaQuery.of(context).size.height*.37,
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height*.1,),

          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height*.04
            ),
            child: DefaultButton(
                buttonText:  AppLocalizations.of(context)!.translate('addProduct').toString(),
                color: ColorManager.primaryColor,
                color2: ColorManager.lightColor,
                onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return  const ServicesScreen();
                  }));

                }
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height*.07,),

          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height*.04
            ),
            child: DefaultButton(
                buttonText: AppLocalizations.of(context)!.translate('askProduct').toString(),
                color: ColorManager.lightColor,
                color2: ColorManager.primaryColor,
                onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return  const ViewServicesScreen();
                  }));

                }
            ),
          ),
        ],
      ),
    );
  }
}
