import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_nia_me/features/screens/pages/home.dart';

import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int currentIndex = 0;

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
                setState(() => currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                setState(() => currentIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Logout"),
              onTap: () async {
                // 1️⃣ Disconnect Google (forces email chooser next time)
                // await GoogleSignIn().disconnect();

                // 2️⃣ Sign out Firebase
                await FirebaseAuth.instance.signOut();

                // 3️⃣ Clear ALL SharedPreferences
                //final prefs = await SharedPreferences.getInstance();
                // await prefs.clear();   // <-- clears full local storage

                // 4️⃣ Navigate to Login screen
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
        elevation: 8,
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(), // Ensures perfect circle
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: SvgPicture.asset(
          'assets/icons/ic_scanner.svg',
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// 🔹 Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        color: AppColors.pageBackgroundColor,
        surfaceTintColor: Colors.transparent,  // ← removes M3 overlay tint
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
                label: "NIA",
                lineIcon: Icons.home_outlined,
                fillIcon: Icons.home,
                onTap: _onItemTapped,
              ),
              NavItem(
                index: 1,
                selectedIndex: _selectedIndex,
                label: "Categories",
                lineIcon: Icons.grid_view_outlined,
                fillIcon: Icons.grid_view,
                onTap: _onItemTapped,
              ),

              const SizedBox(width: 40), // Space for FAB

              NavItem(
                index: 3,
                selectedIndex: _selectedIndex,
                label: "Buy Again",
                lineIcon: Icons.shopping_bag_outlined,
                fillIcon: Icons.shopping_bag,
                onTap: _onItemTapped,
              ),
              NavItem(
                index: 4,
                selectedIndex: _selectedIndex,
                label: "Track",
                lineIcon: Icons.local_shipping_outlined,
                fillIcon: Icons.local_shipping,
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
  final IconData lineIcon;
  final IconData fillIcon;
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
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔥 Bounce Animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0.9,
              end: isSelected ? 1.2 : 1.0,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Icon(
              isSelected ? fillIcon : lineIcon, // 🔥 ICON CHANGE HERE
              size: 26,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),

          const SizedBox(height: 4),

          /// 🔥 Text Animation
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 12,
              fontWeight:
              isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

