import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/business_logic/localization_cubit/localization_cubit.dart';
import 'package:services/constants/constants.dart';
import 'package:services/presentation/screens/home_screen.dart';
import 'package:services/presentation/screens/register_screen.dart';
import 'package:services/presentation/screens/start_screen.dart';
import 'package:services/presentation/widgets/default_text_field.dart';
import 'package:services/presentation/widgets/toast.dart';
import 'package:services/styles/color_manager/color_manager.dart';
import 'package:services/uitiles/local/cash_helper.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPassword=false;
  late String phoneNumber;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ServicesCubit,ServicesStates>(
      listener: (context,state){

        if(state is UserLoginSuccessState){


            CashHelper.saveData(key: 'uId',value: state.uId);
            uId=CashHelper.getData(key: 'uId');

            ServicesCubit.get(context).getUser();

            Navigator.push(context, MaterialPageRoute(builder: (_){

              return  const StartScreen();

            }));
        }

        if(state is UserLoginErrorState){

          customToast(title: AppLocalizations.of(context)!.translate('loginToast').toString(), color: ColorManager.red);

        }



      },
      builder: (context,state){
        var cubit=ServicesCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.darkGrey,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: ColorManager.darkGrey
              ),
              actions: [

                GestureDetector(
                  onTap: (){

                    if(CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'){
                      LocalizationCubit.get(context).changeLanguage(code: 'ar');
                    }
                    else{
                      LocalizationCubit.get(context).changeLanguage(code: 'en');

                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('language').toString(),
                        style: GoogleFonts.almarai(
                            fontSize: MediaQuery.of(context).size.height*.02,
                            color: ColorManager.white,
                            fontWeight: FontWeight.w700
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.005,),

                      CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?
                      Container(
                        width: MediaQuery.of(context).size.height*.06,
                        height: MediaQuery.of(context).size.height*.0035,
                        color: ColorManager.lightColor,
                      ):Container(
                        width: MediaQuery.of(context).size.height*.03,
                        height: MediaQuery.of(context).size.height*.0035,
                        color: ColorManager.lightColor,
                      )
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height*.025,),
              ],
              backgroundColor: ColorManager.darkGrey,
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: ColorManager.darkGrey,
              ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                    child: Lottie.asset(
                      'assets/images/login.json',
                      height: MediaQuery.of(context).size.height*.32,
                      width: MediaQuery.of(context).size.height*.32,
                    ),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height * .01,),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                    child: DefaultTextField(
                      hintText:AppLocalizations.of(context)!.translate('email').toString(),
                      controller: email,
                      isPass: false,
                      prefixIcon: Icons.person,
                      textInputType: TextInputType.text,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * .035,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                    child: DefaultTextField(
                      hintText: AppLocalizations.of(context)!.translate('password').toString(),
                      controller: password,
                      prefixIcon: Icons.lock,
                      isPass: true,
                      textInputType: TextInputType.text,
                    ),
                  ),

                  SizedBox(
                    height: size.height * .025,
                  ),

                  state is UserLoginLoadingState|| state is GetUserLoadingState?
                  const Center(
                    child: CircularProgressIndicator(color: ColorManager.white,),
                  ):
                  Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height*.03),
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),

                      color: ColorManager.primaryColor,
                      onPressed: (){

                        if(formKey.currentState!.validate()){

                          cubit.userLogin(
                              email: email.text,
                              password: password.text
                          );

                        }


                      },
                      child:Text(AppLocalizations.of(context)!.translate('login').toString(),style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.height*.022,
                          color: ColorManager.white
                      ),),
                    ),
                  ),


                  SizedBox(
                    height: size.height * .03,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.translate('registerMessage').toString(),style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w300,
                          fontSize:MediaQuery.of(context).size.height*.025,
                          color: ColorManager.lightColor),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        width: size.height * .007,
                      ),

                      GestureDetector(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (_){

                            return const RegisterScreen();

                          }));

                        },
                        child: Text(AppLocalizations.of(context)!.translate('registerTitle').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height *.02),

                ],
              ),
            ),
          ),
        );

      },

    );
  }

}