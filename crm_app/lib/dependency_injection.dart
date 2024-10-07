// lib/providers/bloc_providers.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motta/bloc/leads/leads.bloc.dart';
import 'package:motta/bloc/navigation/navigation.bloc.dart';

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
