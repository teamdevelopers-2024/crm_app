// lib/providers/bloc_providers.dart

import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/bloc/navigation/navigation.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeadBloc>(
          create: (context) => LeadBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        // BlocProvider<EmployeeBloc>(
        //   create: (context) => EmployeeBloc(),
        // ),
        // Add more BlocProviders here as needed
      ],
      child: child,
    );
  }
}
