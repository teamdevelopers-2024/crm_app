import 'dart:async';
import 'dart:ui'; // Required for ImageFilter.blur
import 'package:crm_android/bloc/navigation/navigation.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/models/nav_item_model.dart';
import 'package:crm_android/models/rive_model.dart';
import 'package:crm_android/services/leads.services.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/utils/images.dart';
import 'package:crm_android/views/screens/home/pages/leads/leads_page.dart';
import 'package:crm_android/views/screens/home/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // Initialize riveIconInputs with the same length as bottomNavItems
  List<rive.SMIBool?> riveIconInputs = List.filled(bottomNavItems.length, null);

  // List of pages to switch between
  final List<Widget> pages = [
    const LeadsPage(), // Replace with your actual Home Page widget
    const Center(
        child: Text('3D Stack Page')), // Replace with the 3D Stack Page widget
    const Center(
        child: Text('Profile Page')), // Replace with the Profile Page widget
  ];
  List<rive.StateMachineController?> controllers = [];
  animateTheIcon(int index, NavigationBloc navigationBloc) {
    if (riveIconInputs[index] != null) {
      riveIconInputs[index]?.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        riveIconInputs[index]?.change(false);
      });
    }
    // Dispatch the navigation event to change the page
    navigationBloc.add(NavigateToPage(currentIndex: index));
  }

  void riveOnInit(
      {required rive.Artboard artboard,
      required RiveModel riveIcon,
      required int index}) {
    rive.StateMachineController? controller =
        rive.StateMachineController.fromArtboard(
      artboard,
      riveIcon.stateMachineName,
    );
    if (controller != null) {
      artboard.addController(controller);
      controllers.add(controller);
      // Make sure the right index is updated with the SMIBool input
      riveIconInputs[index] =
          controller.findInput<bool>("active") as rive.SMIBool;
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavigationBloc navigationBloc = context.read<NavigationBloc>();
    LeadsServices leadsServices = LeadsServices();

    return SafeArea(
      child: Scaffold(
        backgroundColor: CRMAppColorPallete.scaffoldBackgroundColor,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () async{
              await leadsServices.getLeads();
            },
            child: SizedBox(
              width: Screen.getWidth(context: context) *
                  0.3, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              child: Image.asset(CRMImages.logo),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: Screen.getWidth(context: context) * 0.07),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add your close request logic here
                  // leadBloc.add(SendCloseRequest(lead.id)); // Assuming there's an event for this
                },
                icon: Image.asset(CRMImages.logOut),
                label: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Screen.getWidth(context: context) * 0.03),
                ),
                style: ElevatedButton.styleFrom(
                  overlayColor: CRMAppColorPallete.lightBlue,
                  fixedSize: Size(Screen.getWidth(context: context) * 0.23, 15),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 0,
                  side: const BorderSide(color: CRMAppColorPallete.lightBlue),
                  backgroundColor: CRMAppColorPallete.lightBlue
                      .withOpacity(0.15), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
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
                      Expanded(
                        child: pages[currentIndex],
                      ), // Render the selected page
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                List.generate(bottomNavItems.length, (index) {
                              final riveIcon = bottomNavItems[index].rive;
                              return GestureDetector(
                                onTap: () {
                                  animateTheIcon(index, navigationBloc);
                                },
                                child: Column(
                                  children: [
                                    AnimatedBar(
                                      isActive: currentIndex == index,
                                    ),
                                    SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Opacity(
                                        opacity:
                                            currentIndex == index ? 1 : 0.5,
                                        child: rive.RiveAnimation.asset(
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
