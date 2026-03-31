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

  late final List<Widget> _pages = [
    Home(openDrawer: openDrawer),
    const Center(child: Text("Categories")),
    const Center(child: Text("Scanner")),
    const Center(child: Text("Buy Again")),
    const Center(child: Text("Track Order")),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

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
      key: _scaffoldKey,

      ///Drawer Navigation
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       const DrawerHeader(
      //         child: Text("My App", style: TextStyle(fontSize: 22)),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text("Dashboard"),
      //         onTap: () {
      //           setState(() => _selectedIndex = 0);
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text("Profile"),
      //         onTap: () {
      //           setState(() => _selectedIndex = 2);
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.logout),
      //         title: const Text("Logout"),
      //         onTap: () async {
      //           // 1️⃣ Sign out Firebase
      //           await FirebaseAuth.instance.signOut();
      //
      //           if (!context.mounted) return;
      //
      //           // 2️⃣ Navigate to Login screen
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(builder: (_) => const LoginScreen()),
      //             (route) => false,
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // 🔥 HEADER (PROFILE)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A8FFF), Color(0xFF00D4C5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Name + Email
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subrata Ghosh",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "subrata@email.com",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🔹 MENU ITEMS
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    _drawerItem(
                      icon: Icons.home,
                      title: "Dashboard",
                      onTap: () {
                        setState(() => _selectedIndex = 0);
                        Navigator.pop(context);
                      },
                    ),

                    _drawerItem(
                      icon: Icons.person,
                      title: "Profile",
                      onTap: () {
                        setState(() => _selectedIndex = 2);
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(),

                    _drawerItem(
                      icon: Icons.settings,
                      title: "Settings",
                      onTap: () {},
                    ),

                    _drawerItem(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // 🔻 LOGOUT BUTTON (BOTTOM)
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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

Widget _drawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.black87),
    title: Text(
      title,
      style: const TextStyle(fontSize: 14),
    ),
    onTap: onTap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    hoverColor: Colors.grey.shade100,
  );
}
