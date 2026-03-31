import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_nia_me/core/theme/app_colors.dart';

import '../../../core/repository/offerBanner_repository.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_text_style.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ─────────────────────────── THEME ───────────────────────────
class NIAColors {
  static const teal = Color(0xFF00B8A9);
  static const tealLight = Color(0xFFE0F7F5);
  static const navy = Color(0xFF1B2D4F);
  static const bg = Color(0xFFF6F7FB);
  static const white = Colors.white;
  static const textDark = Color(0xFF1A2138);
  static const textGrey = Color(0xFF8A91A0);
  static const textLight = Color(0xFFB0B7C3);
  static const red = Color(0xFFFF5252);
  static const amber = Color(0xFFFFB300);
  static const purple = Color(0xFF7C5CBF);
}

class Home extends StatefulWidget {
  final VoidCallback openDrawer; // ✅ add this
  const Home({super.key, required this.openDrawer});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bannerPage = 0;
  bool _chatOpen = true;
  final PageController _bannerCtrl = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _bannerCtrl.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NIAColors.bg,
      body: Stack(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                _TopAppBar(openDrawer: widget.openDrawer),
                _CategoryTabBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _HeroBannerSection(
                          controller: _bannerCtrl,
                          currentPage: _bannerPage,
                          onPageChanged: (p) => setState(() => _bannerPage = p),
                        ),
                        const SizedBox(height: 4),
                        _DiscoverAirSection(),
                        const SizedBox(height: 8),
                        _DiscoverHydrationSection(),
                        const SizedBox(height: 8),
                        _FirstShoppingSpreeSection(),
                        const SizedBox(height: 8),
                        _ElectronicsLifestyleSection(),
                        const SizedBox(height: 8),
                        _ValueSelectionSection(),
                        const SizedBox(height: 8),
                        _PromoCardsSection(),
                        const SizedBox(height: 8),
                        _NIACareSection(),
                        const SizedBox(height: 8),
                        _FooterSection(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0, left: 0, right: 0,
          //   child: _BottomNav(
          //     currentIndex: _navIndex,
          //     onTap: (i) => setState(() => _navIndex = i),
          //   ),
          // ),
          if (_chatOpen)
            Positioned(
              bottom: 155,
              right: 14,
              child: _ChatBubble(
                onClose: () => setState(() => _chatOpen = false),
              ),
            ),
        ],
      ),
    );
  }
}



// ─────────────────────────── TOP APP BAR ───────────────────────────
class _TopAppBar extends StatelessWidget {
  final VoidCallback openDrawer;

  const _TopAppBar({required this.openDrawer});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackgroundColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 6,
        left: 14,
        right: 14,
        bottom: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.pageBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Top Row (Location + NIA Plus)
                  Row(
                    children: [
                      //language box
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/ic_language.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Location Box
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.business, size: 18),
                              const SizedBox(width: 8),

                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "OFFICE: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "Jumeirah Bay Tower, Plot No X2 - Dubai", // 👈 dynamic text
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const Icon(Icons.keyboard_arrow_down, size: 18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      // NIA Plus Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/icons/ic_nia_plus.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "NIA Plus",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// 🔹 Search Row (Menu + Search Bar)
                  Row(
                    children: [
                      // Menu Icon
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                            color: AppColors.textGreyColor,
                          ),
                          onPressed: openDrawer,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Search Box
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  'assets/icons/ic_search.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Search",
                                style: AppTextStyles.inputText.copyWith(
                                  color: AppColors.textGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── CATEGORY TAB BAR ───────────────────────────
class _CategoryTabBar extends StatefulWidget {
  @override
  State<_CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<_CategoryTabBar> {
  int _selected = 0;

  final List<Map<String, String>> _tabs = [
    {"label": "All", "icon": "assets/icons/ic_tab_all@4x.png"},
    {"label": "Blenders", "icon": "assets/icons/ic_tab_blenders@4x.png"},
    {"label": "Microwaves", "icon": "assets/icons/ic_tab_microwaves@4x.png"},
    {
      "label": "Multifunction Ovens",
      "icon": "assets/icons/ic_tab_ovens@4x.png",
    },
    {"label": "Washers", "icon": "assets/icons/ic_tab_washers@4x.png"},
    {"label": "Kettles", "icon": "assets/icons/ic_tab_kettles@4x.png"},
    {
      "label": "Refrigerators",
      "icon": "assets/icons/ic_tab_refrigerators@4x.png",
    },
    {"label": "Washer/Dryers", "icon": "assets/icons/ic_tab_dryers@4x.png"},
    {"label": "Stand Mixers", "icon": "assets/icons/ic_tab_mixers@4x.png"},
    {
      "label": "Air Conditioners",
      "icon": "assets/icons/ic_tab_airconditioners@4x.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pageBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E3EA), // light grey line
            width: 1,
          ),
        ),
      ),
      height: 70, // increase height for icon + text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _tabs.length,
        itemBuilder: (_, i) {
          final sel = i == _selected;

          return GestureDetector(
            onTap: () => setState(() => _selected = i),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 80),
            child: Container(
              margin: const EdgeInsets.only(right: 10), // ✅ moved outside
              child: CustomPaint(
                painter: _TabIndicatorPainter(
                  isSelected: sel,
                  color: AppColors.primaryColor,
                ),
                child: Container(
                  // margin removed from here
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // ✅ center, not end
                    children: [
                      Image.asset(_tabs[i]["icon"]!, height: 30, width: 30),
                      const SizedBox(height: 6),
                      Text(
                        _tabs[i]["label"]!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                          color: sel
                              ? AppColors.primaryColor
                              : AppColors.textGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
              ),
          );
        },
      ),
    );
  }
}

class _TabIndicatorPainter extends CustomPainter {
  final bool isSelected;
  final Color color;
  const _TabIndicatorPainter({required this.isSelected, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (!isSelected) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Rounded top rectangle at the bottom
    final rect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, size.height - 4, size.width, 4),
      topLeft: const Radius.circular(4),
      topRight: const Radius.circular(4),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(_TabIndicatorPainter old) => old.isSelected != isSelected;
}

// ─────────────────────────── HERO BANNER ───────────────────────────
class _BannerData {
  final String title, subtitle;
  final List<Color> gradient;
  final Color accentColor;
  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.accentColor,
  });
}

class _HeroBannerSection extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  static const _banners = [
    _BannerData(
      title: 'Breathe Easy.\nLive Better.',
      subtitle: 'Discover Orée Air Purifiers,\nCoolers, Fans & More.',
      gradient: [Color(0xFFD8F5F1), Color(0xFFA2E8E1), Color(0xFF6DD4CA)],
      accentColor: NIAColors.teal,
    ),
    _BannerData(
      title: 'Smart Living\nStarts Here.',
      subtitle: 'Upgrade your home with\ntop-brand electronics.',
      gradient: [Color(0xFFECEEFF), Color(0xFFD0D5FF), Color(0xFFA8B0FF)],
      accentColor: NIAColors.purple,
    ),
    _BannerData(
      title: 'Stay Cool\nAll Season.',
      subtitle: 'Split ACs, Portable Coolers\n& Tower Fans.',
      gradient: [Color(0xFFFFF8E1), Color(0xFFFFECB3), Color(0xFFFFCC80)],
      accentColor: NIAColors.amber,
    ),
  ];

  const _HeroBannerSection({
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NIAColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 168,
            child: PageView.builder(
              controller: controller,
              onPageChanged: onPageChanged,
              itemCount: _banners.length,
              itemBuilder: (_, i) => _BannerCard(data: _banners[i]),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (i) {
              final active = i == currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: active ? NIAColors.teal : const Color(0xFFCDD2DA),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final _BannerData data;
  const _BannerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: data.accentColor.withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -28,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data.accentColor.withOpacity(0.13),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data.accentColor.withOpacity(0.10),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 0,
            top: 0,
            child: Center(
              child: Icon(
                Icons.air_rounded,
                size: 95,
                color: data.accentColor.withOpacity(0.28),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: NIAColors.textDark,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data.subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF5A6478),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: data.accentColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: data.accentColor.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// ─────────────────────────── SECTION HEADER ───────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title, subtitle;
  final bool showSeeAll;
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: NIAColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: NIAColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          if (showSeeAll)
            const Text(
              'See All »',
              style: TextStyle(
                fontSize: 12,
                color: NIAColors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────── PRODUCT CARD ───────────────────────────
class _ProductCard extends StatefulWidget {
  final String badge, name, price;
  final String? oldPrice;
  final Color badgeColor;
  final IconData icon;
  const _ProductCard({
    required this.badge,
    required this.name,
    required this.price,
    this.oldPrice,
    this.badgeColor = NIAColors.red,
    this.icon = Icons.ac_unit_rounded,
  });
  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _fav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      NIAColors.tealLight.withOpacity(0.6),
                      const Color(0xFFF0F2F5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    size: 50,
                    color: NIAColors.teal.withOpacity(0.55),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: widget.badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: GestureDetector(
                  onTap: () => setState(() => _fav = !_fav),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      _fav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 15,
                      color: _fav ? NIAColors.red : NIAColors.textGrey,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: NIAColors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 11,
                    color: NIAColors.textDark,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: NIAColors.textDark,
                      ),
                    ),
                    if (widget.oldPrice != null) ...[
                      const SizedBox(width: 5),
                      Text(
                        widget.oldPrice!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: NIAColors.textLight,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _seeAllButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Center(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: NIAColors.teal, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 9),
        ),
        child: const Text(
          'See All »',
          style: TextStyle(
            color: NIAColors.teal,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────── DISCOVER AIR ───────────────────────────
class _DiscoverAirSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: NIAColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Discover Air',
            subtitle: 'Suitable solutions for every home',
          ),
          // Banner
          Container(
            height: 185,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF10303E),
                  Color(0xFF0B6060),
                  Color(0xFF00A896),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: NIAColors.teal.withOpacity(0.28),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -35,
                  bottom: -35,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 18,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Icon(
                      Icons.wind_power_rounded,
                      size: 105,
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                ),
                // Chat overlay bubble
                Positioned(
                  bottom: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We're Online!",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: NIAColors.textDark,
                          ),
                        ),
                        Text(
                          'How may I help you?',
                          style: TextStyle(
                            fontSize: 10,
                            color: NIAColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  right: 14,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [NIAColors.teal, Color(0xFF00D4C2)],
                      ),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 205,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              scrollDirection: Axis.horizontal,
              children: const [
                _ProductCard(
                  badge: '10% OFF',
                  name: 'Gree 2.0 Ton Split Air Conditioner...',
                  price: '৳3,599.00',
                  oldPrice: '৳4,799.00',
                  badgeColor: NIAColors.red,
                ),
                _ProductCard(
                  badge: 'NEW',
                  name: 'Gree 2.0 Ton Split Air Conditioner...',
                  price: '৳3,599.00',
                  badgeColor: NIAColors.teal,
                  icon: Icons.thermostat_rounded,
                ),
                _ProductCard(
                  badge: '5% OFF',
                  name: 'Gree 1.5 Ton Split Air Conditioner...',
                  price: '৳2,899.00',
                  oldPrice: '৳3,299.00',
                  badgeColor: NIAColors.amber,
                  icon: Icons.device_thermostat_rounded,
                ),
              ],
            ),
          ),
          _seeAllButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// ─────────────────────────── DISCOVER HYDRATION ───────────────────────────
class _DiscoverHydrationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: NIAColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Discover healthy hydration',
            subtitle: 'Suitable solutions for every home',
          ),
          Container(
            height: 185,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0D3B5E),
                  Color(0xFF1B6B8A),
                  Color(0xFF3BA8C8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B6B8A).withOpacity(0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -28,
                  bottom: -28,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Icon(
                      Icons.water_drop_rounded,
                      size: 100,
                      color: Colors.white.withOpacity(0.17),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pure. Fresh.\nHealthy.',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Water purifiers, dispensers\n& hydration solutions.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.78),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Explore',
                          style: TextStyle(
                            color: Color(0xFF0D3B5E),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 205,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              scrollDirection: Axis.horizontal,
              children: const [
                _ProductCard(
                  badge: '15% OFF',
                  name: 'Gree 2.0 Ton Split Conditioner Pro...',
                  price: '৳3,599.00',
                  oldPrice: '৳4,199.00',
                  badgeColor: NIAColors.red,
                  icon: Icons.water_rounded,
                ),
                _ProductCard(
                  badge: 'NEW',
                  name: 'Gree Water Purifier Pro Max...',
                  price: '৳3,599.00',
                  badgeColor: NIAColors.teal,
                  icon: Icons.water_drop_rounded,
                ),
                _ProductCard(
                  badge: '8% OFF',
                  name: 'Smart Water Dispenser 20L...',
                  price: '৳2,499.00',
                  oldPrice: '৳2,799.00',
                  badgeColor: NIAColors.amber,
                  icon: Icons.local_drink_rounded,
                ),
              ],
            ),
          ),
          _seeAllButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// ─────────────────────────── FIRST SHOPPING SPREE ───────────────────────────
class _FirstShoppingSpreeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A1F3F), Color(0xFF143566), Color(0xFF1A4D99)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A1F3F).withOpacity(0.4),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -35,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            left: -25,
            bottom: -25,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: NIAColors.teal.withOpacity(0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: NIAColors.teal,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'FIRST ORDER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'YOUR FIRST TIME SHOPPING SPREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Get an extra 10% off your first order when you sign up & simply use the code "NIAPROTO" at checkout!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                // Coupon
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white.withOpacity(0.07),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.discount_outlined,
                        color: NIAColors.teal,
                        size: 15,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'NIAPROTO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: NIAColors.teal,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'COPY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // 3 Deal cards
                Row(
                  children: [
                    _DealCard(
                      label: 'Deal Zone',
                      disc: 'Up to 25%',
                      icon: Icons.local_fire_department_rounded,
                      gradColors: [
                        const Color(0xFFFF6B35),
                        const Color(0xFFFF9C5B),
                      ],
                    ),
                    const SizedBox(width: 8),
                    _DealCard(
                      label: 'Win To Buy',
                      disc: 'Win & Save',
                      icon: Icons.emoji_events_rounded,
                      gradColors: [
                        const Color(0xFFFFB300),
                        const Color(0xFFFFD54F),
                      ],
                    ),
                    const SizedBox(width: 8),
                    _DealCard(
                      label: 'Flash Offers',
                      disc: 'Today Only',
                      icon: Icons.bolt_rounded,
                      gradColors: [NIAColors.teal, const Color(0xFF00D8C5)],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  final String label, disc;
  final IconData icon;
  final List<Color> gradColors;
  const _DealCard({
    required this.label,
    required this.disc,
    required this.icon,
    required this.gradColors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.07),
          border: Border.all(color: Colors.white.withOpacity(0.11)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradColors),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 16),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradColors),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                disc,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── ELECTRONICS LIFESTYLE ───────────────────────────
class _ElectronicsLifestyleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rooms = [
      {
        'name': 'Living Room',
        'c1': const Color(0xFF1E3A5F),
        'c2': const Color(0xFF2E5A8E),
        'icon': Icons.weekend_rounded,
      },
      {
        'name': 'Laundry Room',
        'c1': const Color(0xFF1A4A3A),
        'c2': const Color(0xFF2A7A5E),
        'icon': Icons.local_laundry_service_rounded,
      },
      {
        'name': 'Kitchen',
        'c1': const Color(0xFF4A2218),
        'c2': const Color(0xFF8B4513),
        'icon': Icons.kitchen_rounded,
      },
      {
        'name': 'Office',
        'c1': const Color(0xFF1E2A4A),
        'c2': const Color(0xFF2E3F7A),
        'icon': Icons.computer_rounded,
      },
    ];
    return Container(
      color: NIAColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            title: 'Electronics that blend\nwith your lifestyle.',
            subtitle: 'Select your room. Power your life.',
            showSeeAll: false,
          ),
          SizedBox(
            height: 118,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              scrollDirection: Axis.horizontal,
              itemCount: rooms.length,
              itemBuilder: (_, i) {
                final r = rooms[i];
                return Container(
                  width: 138,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [r['c1'] as Color, r['c2'] as Color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (r['c1'] as Color).withOpacity(0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -14,
                        top: -14,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.07),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Icon(
                          r['icon'] as IconData,
                          size: 32,
                          color: Colors.white.withOpacity(0.22),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Text(
                          r['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

// ─────────────────────────── VALUE & SELECTION ───────────────────────────
class _ValueSelectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brands = [
      {
        'name': 'DAEWOO',
        'c1': const Color(0xFF003087),
        'c2': const Color(0xFF0050B3),
      },
      {
        'name': 'AEG',
        'c1': const Color(0xFF990000),
        'c2': const Color(0xFFCC0000),
      },
      {
        'name': 'BLACK+\nDECKER',
        'c1': const Color(0xFF1A1A1A),
        'c2': const Color(0xFF404040),
      },
      {
        'name': 'SLIDER',
        'c1': const Color(0xFF1B5E20),
        'c2': const Color(0xFF2E7D32),
      },
    ];
    return Container(
      color: NIAColors.white,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Value & Selection',
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w800,
              color: NIAColors.textDark,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Explore top-brand appliances from brands you know and new ones to love.',
            style: TextStyle(
              fontSize: 11.5,
              color: NIAColors.textGrey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: brands.map((b) {
              return Container(
                width: 74,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [b['c1'] as Color, b['c2'] as Color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (b['c1'] as Color).withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    b['name'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── PROMO CARDS ───────────────────────────
class _PromoCardsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFD6F5F1), Color(0xFFBCEEE9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: NIAColors.teal.withOpacity(0.14),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [NIAColors.teal, Color(0xFF00D4C2)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.local_offer_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Save an extra 20%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: NIAColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'on select brands – Just use the code at checkout!',
                    style: TextStyle(
                      fontSize: 10,
                      color: NIAColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFEAEDFF), Color(0xFFD8DCFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: NIAColors.purple.withOpacity(0.14),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [NIAColors.purple, Color(0xFF9B7CDB)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.local_shipping_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Track your\nOrder',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: NIAColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Stay updated on your delivery anytime.',
                    style: TextStyle(
                      fontSize: 10,
                      color: NIAColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── NIA CARE SECTION ───────────────────────────
class _NIACareSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFD8F5F0), Color(0xFFEEFAF8), Color(0xFFC8EFE9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: NIAColors.teal.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Concentric circles decoration
          SizedBox(
            height: 52,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: List.generate(5, (i) {
                final colors = [
                  const Color(0xFF00B8A9),
                  const Color(0xFF33C9BC),
                  const Color(0xFF66DACF),
                  const Color(0xFF99EBE2),
                  const Color(0xFFCCF5F1),
                ];
                final size = 55.0 - i * 8;
                return Positioned(
                  left: i * 14.0,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colors[i], width: 1.8),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'At NIA, we care',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: NIAColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your wellbeing is at the heart of everything we do',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: NIAColors.textGrey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _CareIcon(
                icon: Icons.eco_rounded,
                label: 'Eco Safe',
                color: Color(0xFF2E7D32),
              ),
              _CareIcon(
                icon: Icons.verified_user_rounded,
                label: 'Certified',
                color: NIAColors.teal,
              ),
              _CareIcon(
                icon: Icons.support_agent_rounded,
                label: '24/7 Support',
                color: NIAColors.purple,
              ),
              _CareIcon(
                icon: Icons.workspace_premium_rounded,
                label: 'Premium',
                color: NIAColors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CareIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CareIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: NIAColors.textGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── FOOTER ───────────────────────────
class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Fast Delivery',
        'desc': 'Reach from quick and reliable delivery exactly at your door.',
        'color': NIAColors.teal,
      },
      {
        'icon': Icons.price_check_rounded,
        'title': 'Price match guarantee',
        'desc': "Found a lower price? We'll match it! Shop confidently.",
        'color': NIAColors.purple,
      },
      {
        'icon': Icons.discount_outlined,
        'title': 'Exclusive Deals',
        'desc': 'Take advantage of special discounts on top appliance brands.',
        'color': NIAColors.amber,
      },
      {
        'icon': Icons.security_rounded,
        'title': 'Safety and Quality',
        'desc': 'We adhere to the highest safety and quality standards.',
        'color': const Color(0xFF2E7D32),
      },
    ];
    return Container(
      color: NIAColors.white,
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFE8EAF0))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [NIAColors.teal, Color(0xFF00D4C2)],
                  ).createShader(r),
                  child: const Text(
                    'NIA',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFFE8EAF0))),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
            children: items.map((item) {
              final color = item['color'] as Color;
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.08), color.withOpacity(0.04)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: color.withOpacity(0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: NIAColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Expanded(
                      child: Text(
                        item['desc'] as String,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: NIAColors.textGrey,
                          height: 1.35,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── CHAT BUBBLE ───────────────────────────
class _ChatBubble extends StatelessWidget {
  final VoidCallback onClose;
  const _ChatBubble({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.13),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("We're Online!", style: AppTextStyles.hintPassText),
                  Text('How may I help you?', style: AppTextStyles.subHeading),
                ],
              ),
            ),

            // 👉 Triangle Tail
            Positioned(
              right: -10,
              top: 8,
              child: CustomPaint(
                size: const Size(18, 38),
                painter: _TrianglePainter(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onClose,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8EAF0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 13,
                  color: NIAColors.textGrey,
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Container(
            //   width: 48,
            //   height: 48,
            //   decoration: BoxDecoration(
            //     color: AppColors.primaryColor,
            //     shape: BoxShape.circle,
            //     // gradient: const LinearGradient(colors: [NIAColors.teal, Color(0xFF00D8C5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            //     boxShadow: [
            //       BoxShadow(
            //         color: AppColors.whiteColor,
            //         blurRadius: 12,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            //   child: Center(
            //     child: SvgPicture.asset(
            //       'assets/icons/ic_chat.svg',
            //       width: 22,
            //       height: 22,
            //       colorFilter: const ColorFilter.mode(
            //         Colors.white, // optional: make icon white
            //         BlendMode.srcIn,
            //       ),
            //     ),
            //   ),
            //   // const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 22),
            // ),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const ChatScreen(),
              //     ),
              //   );
              // },
              onTap: () {
                ChatOverlay.show(context);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.whiteColor,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_chat.svg',
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();

    // canvas.drawShadow(path, Colors.black.withOpacity(0.13), 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class ChatOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => const _ChatOverlayWidget(),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _ChatOverlayWidget extends StatefulWidget {
  const _ChatOverlayWidget();

  @override
  State<_ChatOverlayWidget> createState() => _ChatOverlayWidgetState();
}

class _ChatOverlayWidgetState extends State<_ChatOverlayWidget> {
  final TextEditingController controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  Future<String> getAIResponse(String message) async {
    const apiKey = "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"; // 🔴 replace this

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "user", "content": message}
        ]
      }),
    );

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          height: 420,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            children: [
              // 🔵 Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "NIA Chat",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => ChatOverlay.hide(),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // 💬 Messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];

                    return Align(
                      alignment: msg["role"] == "user"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: msg["role"] == "user"
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg["text"] ?? "",
                          style: TextStyle(
                            color: msg["role"] == "user"
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ✏️ Input
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: "Type message...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),

                    // 🚀 Send Button
                    IconButton(
                      icon: isLoading
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Icon(Icons.send),
                      onPressed: isLoading
                          ? null
                          : () async {
                        final userMessage = controller.text.trim();
                        if (userMessage.isEmpty) return;

                        setState(() {
                          messages.add({
                            "role": "user",
                            "text": userMessage
                          });
                          isLoading = true;
                        });

                        controller.clear();

                        try {
                          final aiReply =
                          await getAIResponse(userMessage);

                          setState(() {
                            messages.add({
                              "role": "ai",
                              "text": aiReply
                            });
                          });
                        } catch (e) {
                          setState(() {
                            messages.add({
                              "role": "ai",
                              "text": "Error: $e"
                            });
                          });
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
