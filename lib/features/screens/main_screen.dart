import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_nia_me/features/screens/pages/home.dart';

import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    Center(child: Text("Categories")),
    Center(child: Text("Scanner")),
    Center(child: Text("Buy Again")),
    Center(child: Text("Track Order")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],

      ///Drawer Navigation
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("My App", style: TextStyle(fontSize: 22)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Dashboard"),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                // 1️⃣ Sign out Firebase
                await FirebaseAuth.instance.signOut();

                if (!context.mounted) return;

                // 2️⃣ Navigate to Login screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      /// 🔹 FAB (Center Button)
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            // color: const Color(0xFF1A8FFF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0x331A8FFF),
                blurRadius: 20,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x331A8FFF),
                blurRadius: 50,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipOval(
            child: SvgPicture.asset(
              'assets/icons/ic_market_place_bg.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 8,
      //   backgroundColor: Colors.transparent,
      //   shape: const CircleBorder(),
      //   splashColor: Colors.transparent,
      //   onPressed: () {
      //     setState(() {
      //       _selectedIndex = 2;
      //     });
      //   },
      //   child: ClipOval(
      //     child: SvgPicture.asset(
      //       'assets/icons/ic_market_place_wave.svg',
      //       width: 60,   // match your FAB size
      //       height: 60,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   // child: SvgPicture.asset(
      //   //   'assets/icons/ic_market_place_wave.svg',
      //   //   width: double.infinity,
      //   //   height: double.infinity,
      //   //   fit: BoxFit.cover,
      //   // ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// 🔹 Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                index: 0,
                selectedIndex: _selectedIndex,
                label: "Home",
                lineIcon: SvgPicture.asset(
                  'assets/icons/ic_home_line.svg',
                  width: 24,
                  height: 24,
                ),
                fillIcon: SvgPicture.asset(
                  'assets/icons/ic_home_fill.svg',
                  width: 24,
                  height: 24,
                  // colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                ),
                onTap: _onItemTapped,
              ),
              NavItem(
                index: 1,
                selectedIndex: _selectedIndex,
                label: "Categories",
                lineIcon: SvgPicture.asset(
                  'assets/icons/ic_categories_line.svg',
                  width: 24,
                  height: 24,
                ),
                fillIcon: SvgPicture.asset(
                  'assets/icons/ic_categories_fill.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: _onItemTapped,
              ),

              const SizedBox(width: 40), // Space for FAB

              NavItem(
                index: 3,
                selectedIndex: _selectedIndex,
                label: "Account",
                lineIcon: SvgPicture.asset(
                  'assets/icons/ic_user_line.svg',
                  width: 24,
                  height: 24,
                ),
                fillIcon: SvgPicture.asset(
                  'assets/icons/ic_user_fill.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: _onItemTapped,
              ),
              NavItem(
                index: 4,
                selectedIndex: _selectedIndex,
                label: "Cart",
                lineIcon: SvgPicture.asset(
                  'assets/icons/ic_basket_line.svg',
                  width: 24,
                  height: 24,
                ),
                fillIcon: SvgPicture.asset(
                  'assets/icons/ic_basket_fill.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔥 Custom Nav Item
class NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final Widget lineIcon;
  final Widget fillIcon;
  final Function(int) onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.lineIcon,
    required this.fillIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔥 Bounce Animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.9, end: isSelected ? 1.05 : 0.98),
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: isSelected ? fillIcon : lineIcon,
          ),

          const SizedBox(height: 4),

          /// 🔥 Text Animation
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: TextStyle(
              // fontFamily: AppFonts.primary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
