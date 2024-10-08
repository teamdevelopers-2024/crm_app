// import 'package:crm_android/bloc/auth/auth.bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Bloc Events, States, and Bloc definition can be elsewhere in your project
// // import 'login_bloc.dart';

// class LoginPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _userIdController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     AuthBloc authBloc = context.read<AuthBloc>();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthSuccess) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           } else if (state is AuthFailure) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.error)));
//           }
//         },
//         child: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // User ID Field
//                     TextFormField(
//                       controller: _userIdController,
//                       decoration: const InputDecoration(
//                         labelText: 'User ID',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'User ID is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     // Password Field
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Password is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),

//                     // Login Button
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState?.validate() ?? false) {
//                           // Input is valid, proceed with login logic

//                           final userId = _userIdController.text
//                               .trim(); // Ensure there's no extra spaces
//                           final password = _passwordController.text;

//                           // Dispatch login event with the userId and password
//                           authBloc.add(
//                             LoginButtonPressed(
//                               userId: userId,
//                               password: password,
//                             ),
//                           );

//                           // Clear password from controller after dispatching the event to avoid keeping it in memory
//                           _passwordController.clear();
//                         }
//                       },
//                       child: state is AuthLoading
//                           ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : const Text('Login'),
//                     ),

//                     // Display loader if the state is loading
//                     if (state is AuthLoading) ...[
//                       const SizedBox(height: 16),
//                       const CircularProgressIndicator(),
//                     ],
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
