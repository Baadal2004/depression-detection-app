import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene_space_project/authentication/doctor_authentication/doctor_login/bloc/doctor_login_bloc.dart';
import 'package:serene_space_project/authentication/doctor_authentication/registration_screen/bloc/register_bloc_bloc.dart';
import 'package:serene_space_project/authentication/patient/login_screen/bloc/login_screen_bloc.dart';
import 'package:serene_space_project/authentication/patient/registration_screen/bloc/registration_page_bloc.dart';
import 'package:serene_space_project/hospital_doctor_screen/dochospital_create/bloc/bloc_bloc.dart';
import 'package:serene_space_project/other_screen/splash_screen.dart';
import 'package:serene_space_project/patient_screen/book_now_hos_screen/bloc/book_now_bloc.dart';
import 'package:serene_space_project/patient_screen/list_nearbyhos_doc/bloc/list_nearbyhos_bloc.dart';
import 'package:serene_space_project/patient_screen/pcod_prediction/input_condition_datas.dart/bloc/input_condition_bloc.dart';
import 'package:serene_space_project/screens/menstrual_track/input_cycle/bloc/input_cycle_bloc.dart';
import 'package:serene_space_project/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginScreenBloc()),
        BlocProvider(create: (context) => RegistrationPageBloc()),
        BlocProvider(create: (context) => DoctorLoginBloc()),
        BlocProvider(create: (context) => DocRegisterBlocBloc()),
         BlocProvider(create: (context) => BlocBloc()),
        BlocProvider(create: (context) => InputCycleBloc()),
        BlocProvider(create: (context) => InputConditionBloc()),
        BlocProvider(create: (context) => BookHosBloc()),
        BlocProvider(create: (context) => BlocBloc()),
       // BlocProvider(create: (context) =>  BookNowBloc(),),
         BlocProvider(create: (context) =>  ListNearbyhosBloc(),)
      
      //  BlocProvider(create: (context) => ListNearbyclincDocBloc()),
        
      ],
       child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serene Space',
        theme: SereneTheme.lightTheme,
        home: SplashScreen()
        //DoctorRegistrationView(),
       // DoctorLoginScreen(),
      // RoleSelectionScreen(),
     // ChatBotScreen(),
        //  const LoginScreen(),
      )
    );
  }
}
