import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'More.dart';
import 'MyTrip.dart';
import 'Account.dart';
import 'HomePage.dart';
import 'package:yatri_cabs/main.dart';
import 'package:google_fonts/google_fonts.dart';

class NavScreen extends ConsumerWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider); // Watch the active index
    final screenHeight = MediaQuery.of(context).size.height;

    // List of Screens
    final List<Widget> screens = [
      HomeScreen(),
      Mytrip(),
      Account(),
      More(),
    ];

    return Scaffold(
      body: screens[selectedIndex], // Render current screen
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/VectorIcon/Home.svg",height: screenHeight*0.025,
              color: selectedIndex == 0 ? Colors.black : Colors.white, // Invert color based on selection
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/VectorIcon/myTrip.svg",height: screenHeight*0.025,
              color: selectedIndex == 1 ? Colors.black : Colors.white, // Invert color based on selection
            ),
            label: 'My Trip',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/VectorIcon/Account.svg",height: screenHeight*0.025,
              color: selectedIndex == 2 ? Colors.black : Colors.white, // Invert color based on selection
            ),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/VectorIcon/more.svg",height: screenHeight*0.025,
              color: selectedIndex == 3 ? Colors.black : Colors.white, // Invert color based on selection
            ),
            label: 'More',
          ),
        ],
        currentIndex: selectedIndex, // Set the active index
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index; // Update index
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        selectedLabelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff38b000),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
