import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/presentation/screens/login_screen.dart';
import 'package:services/presentation/widgets/default_text_field.dart';
import 'package:services/presentation/widgets/toast.dart';
import 'package:services/styles/color_manager/color_manager.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var formKey = GlobalKey<FormState>();

  String ?code;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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

        if(state is UserRegisterSuccessState){

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
           LoginScreen()
          ), (Route<dynamic> route) => false);

        }

        if(state is UserRegisterErrorState){

          customToast(title:AppLocalizations.of(context)!.translate('registerToast').toString(), color: ColorManager.red);

        }


      },
      builder: (context,state){
        var cubit=ServicesCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.darkGrey,
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                        child: Lottie.asset(
                          'assets/images/login.json',
                          height: MediaQuery.of(context).size.height*.31,
                          width: MediaQuery.of(context).size.height*.3,
                        ),
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                      child: DefaultTextField(
                        hintText:AppLocalizations.of(context)!.translate('name').toString(),
                        controller: name,
                        isPass: false,
                        prefixIcon: Icons.person,
                        textInputType: TextInputType.text,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .025,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                      child: DefaultTextField(
                        hintText: AppLocalizations.of(context)!.translate('email').toString(),
                        controller: email,
                        isPass: false,
                        prefixIcon: Icons.person,
                        textInputType: TextInputType.text,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .025,),

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

                    SizedBox(height: MediaQuery.of(context).size.height * .025,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                      child: DefaultTextField(
                        hintText:AppLocalizations.of(context)!.translate('phoneNumber').toString(),
                        controller: phone,
                        prefixIcon: Icons.phone,
                        isPass: false,
                        textInputType: TextInputType.phone,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .025,),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .035),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(
                            Icons.flag,color: ColorManager.primaryColor,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            AppLocalizations.of(context)!.translate('chooseCountry').toString(),
                            style: GoogleFonts.almarai(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: ColorManager.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          CountryCodePicker(
                            showFlag: true,
                            dialogSize: size,
                            showFlagMain: true,
                            onInit: (countryCode){
                              code='${countryCode!}';
                              print(countryCode);
                            },
                            textStyle: GoogleFonts.cairo(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.primaryColor,
                            ),
                            boxDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: ColorManager.lightColor,
                                width: 2
                              )
                            ),
                            backgroundColor: ColorManager.white,
                            onChanged: print,
                            initialSelection: 'EG',
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * .04,
                    ),

                    state is SaveUserDataLoadingState|| state is UserRegisterLoadingState?
                    const Center(
                      child: CircularProgressIndicator(color: ColorManager.white,),
                    ):
                    Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height*.155,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.primaryColor,
                        onPressed: (){


                          if(formKey.currentState!.validate()){

                            cubit.userRegister(
                                email: email.text,
                                password: password.text,
                                name: name.text,
                                phone: phone.text,
                                countryCode:code??'+20'
                            );

                          }

                        },
                        child:Text(AppLocalizations.of(context)!.translate('registerTitle').toString(),
                          style: GoogleFonts.almarai(
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
                        Text(AppLocalizations.of(context)!.translate('messageLogin').toString(),
                          style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w300,
                            fontSize:MediaQuery.of(context).size.height*.022,
                            color: ColorManager.lightColor),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          width: size.height * .007,
                        ),

                        GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (_){

                              return  LoginScreen();

                            }));

                          },
                          child: Text(AppLocalizations.of(context)!.translate('login').toString(),
                            style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.022,
                              color: ColorManager.white
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * .04,
                    ),



                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}