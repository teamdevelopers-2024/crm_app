import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motta/bloc/navigation/navigation.bloc.dart';
import 'package:motta/controller/screen_size_controller.dart';
import 'package:motta/models/nav_item_model.dart';
import 'package:motta/models/rive_model.dart';
import 'package:motta/utils/colors.dart';
import 'package:motta/views/screens/home/pages/leads/leads_page.dart';
import 'package:motta/views/screens/home/widgets/animated_bar.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int currentIndex = 0;

    // Initialize riveIconInputs with the same length as bottomNavItems
    List<SMIBool?> riveIconInputs = List.filled(bottomNavItems.length, null);

    // List of pages to switch between
    final List<Widget> pages = [
      LeadsPage(), // Replace with your actual Home Page widget
      const Center(
          child:
              Text('3D Stack Page')), // Replace with the 3D Stack Page widget
      const Center(
          child: Text('Profile Page')), // Replace with the Profile Page widget
    ];
    List<StateMachineController?> controllers = [];
    animateTheIcon(int index,NavigationBloc navigationBloc) {
      if (riveIconInputs[index] != null) {
        riveIconInputs[index]?.change(true);
        Future.delayed(Duration(seconds: 1), () {
          riveIconInputs[index]?.change(false);
        });
      }
      // Dispatch the navigation event to change the page
      navigationBloc.add(NavigateToPage(currentIndex: index));
    }

    void riveOnInit(
        {required Artboard artboard,
        required RiveModel riveIcon,
        required int index}) {
      StateMachineController? controller = StateMachineController.fromArtboard(
        artboard,
        riveIcon.stateMachineName,
      );
      if (controller != null) {
        artboard.addController(controller);
        controllers.add(controller);
        // Make sure the right index is updated with the SMIBool input
        riveIconInputs[index] = controller.findInput<bool>("active") as SMIBool;
      }
    }

  @override
  void dispose() {
    for(var controller in controllers){
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    NavigationBloc navigationBloc = context.read<NavigationBloc>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: CRMAppColorPallete.scaffoldBackgroundColor,
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationChanged) {
              currentIndex = state.currentIndex;
            }
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: Screen.getHeight(context: context) * 0.02),
                      Expanded(
                          child:
                              pages[currentIndex]), // Render the selected page
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20, // Adjust this to move the bar up or down
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: ClipRRect(
                    
                    borderRadius:
                        BorderRadius.circular(24), // Round the corners
                    child: BackdropFilter(
                      
                      filter: ImageFilter.blur(
                        
                          sigmaX: 8, sigmaY: 8), // Apply the blur effect
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors
                              .transparent, // Adjust opacity for a frosted glass effect
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                List.generate(bottomNavItems.length, (index) {
                              final riveIcon = bottomNavItems[index].rive;
                              return GestureDetector(
                                onTap: () {
                                  animateTheIcon(index,navigationBloc);
                                },
                                child: Column(
                                  children: [
                                    AnimatedBar(isActive: currentIndex == index,),
                                    SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Opacity(
                                        opacity: currentIndex == index ? 1 : 0.5,
                                        child: RiveAnimation.asset(
                                          riveIcon.src,
                                          artboard: riveIcon.artboard,
                                          onInit: (artboard) {
                                            riveOnInit(
                                              artboard: artboard,
                                              riveIcon: riveIcon,
                                              index: index,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Text(bottomNavItems[index].title,style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

