import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  final List<Widget> _pages = const [
    Center(child: Text("Home")),
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
      body: _pages[_selectedIndex],

      /// 🔹 FAB (Center Button)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// 🔹 Bottom Navigation
      bottomNavigationBar: BottomAppBar(
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