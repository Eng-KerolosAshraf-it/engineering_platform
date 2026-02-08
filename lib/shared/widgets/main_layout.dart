import 'package:flutter/material.dart';
import 'package:engineering_platform/core/constants/colors.dart';
import 'package:engineering_platform/core/constants/translations.dart';
import 'package:engineering_platform/core/state/language_state.dart';
import 'package:engineering_platform/core/utils/responsive.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final bool isMobile = Responsive.isMobile(context);

        return Scaffold(
          key: _scaffoldKey,
          drawer: isMobile ? AppDrawer(lang: lang) : null,
          body: Column(
            children: [
              Header(scaffoldKey: _scaffoldKey),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [child, const Footer()]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String lang;
  const AppDrawer({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.bar_chart,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'EngiVerse',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _DrawerItem(
            title: AppTranslations.get('home', lang),
            icon: Icons.home_rounded,
            onTap: () {
              Navigator.pop(context);
              navigatorKey.currentState?.pushNamed('/');
            },
          ),
          _DrawerItem(
            title: AppTranslations.get('services', lang),
            icon: Icons.engineering_rounded,
            onTap: () {
              Navigator.pop(context);
              navigatorKey.currentState?.pushNamed('/civil-services');
            },
          ),
          _DrawerItem(
            title: AppTranslations.get('about', lang),
            icon: Icons.info_outline_rounded,
          ),
          _DrawerItem(
            title: AppTranslations.get('contact', lang),
            icon: Icons.contact_support_outlined,
          ),
          const Divider(),
          _DrawerItem(
            title: AppTranslations.get('login', lang),
            icon: Icons.login_rounded,
            onTap: () {
              Navigator.pop(context);
              navigatorKey.currentState?.pushNamed('/login');
            },
          ),
          _DrawerItem(
            title: AppTranslations.get('signup', lang),
            icon: Icons.person_add_rounded,
            onTap: () {
              Navigator.pop(context);
              navigatorKey.currentState?.pushNamed('/signup');
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _DrawerItem({required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap ?? () {},
    );
  }
}

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Header({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        final bool isMobile = Responsive.isMobile(context);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: 20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: AppColors.greyLight)),
          ),
          child: Row(
            children: [
              if (isMobile) ...[
                IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                ),
                const SizedBox(width: 8),
              ],
              InkWell(
                onTap: () => navigatorKey.currentState?.pushNamed('/'),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.bar_chart,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'EngiVerse',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!isMobile) ...[
                // Navigation Links
                NavItem(
                  title: AppTranslations.get('home', lang),
                  onTap: () => navigatorKey.currentState?.pushNamed('/'),
                ),
                NavItem(
                  title: AppTranslations.get('services', lang),
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/civil-services');
                  },
                ),
                NavItem(title: AppTranslations.get('about', lang)),
                NavItem(title: AppTranslations.get('contact', lang)),
                const SizedBox(width: 24),
              ],
              // Language Switcher (Visible on all)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _LangButton(
                      label: 'EN',
                      isActive: lang == 'en',
                      code: 'en',
                    ),
                    _LangButton(
                      label: 'AR',
                      isActive: lang == 'ar',
                      code: 'ar',
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 24),
                // Buttons
                ElevatedButton(
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.greyLight,
                  ),
                  child: Text(AppTranslations.get('signup', lang)),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/login');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.greyLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppTranslations.get('login', lang),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _LangButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final String code;

  const _LangButton({
    required this.label,
    required this.isActive,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        languageNotifier.value = code;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade800 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const NavItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 24 : 64,
            vertical: 32,
          ),
          color: AppColors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => navigatorKey.currentState?.pushNamed('/'),
                    child: Text(
                      AppTranslations.get('home', lang),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        navigatorKey.currentState?.pushNamed('/civil-services'),
                    child: Text(
                      AppTranslations.get('services', lang),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppTranslations.get('about', lang),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppTranslations.get('contact', lang),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                AppTranslations.get('copyright', lang),
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      },
    );
  }
}
