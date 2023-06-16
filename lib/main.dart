import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/business_logic/cubit/services_cubit.dart';
import 'package:services/business_logic/cubit/services_states.dart';
import 'package:services/business_logic/localization_cubit/app_localization.dart';
import 'package:services/business_logic/localization_cubit/localization_cubit.dart';
import 'package:services/business_logic/localization_cubit/localization_states.dart';
import 'package:services/presentation/screens/login_screen.dart';
import 'package:services/presentation/screens/splash_screen.dart';
import 'package:services/uitiles/local/cash_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CashHelper.init();



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ServicesCubit()..getProducts()..getUser()),
        BlocProvider(create: (BuildContext context) => LocalizationCubit()..fetchLocalization()),
      ],
      child: BlocConsumer<LocalizationCubit,LocalizationStates>(
          builder: (context,state){
            return   MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const LoginScreen(),
              localizationsDelegates:  const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,

              ],
              supportedLocales: const [
                 Locale("en",""),
                 Locale("ar",""),
              ],
              locale: LocalizationCubit.get(context).appLocal,
              localeResolutionCallback: (currentLang , supportLang){
                if(currentLang != null) {
                  for(Locale locale in supportLang){
                    if(locale.languageCode == currentLang.languageCode){
                      return currentLang;
                    }
                  }
                }
                return supportLang.first;
              },
            );
          },
          listener: (context,state){

          }
      ),
    );
  }
}

