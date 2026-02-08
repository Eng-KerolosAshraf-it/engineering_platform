import 'package:flutter/material.dart';
import 'package:engineering_platform/core/constants/colors.dart';
import 'package:engineering_platform/core/constants/translations.dart';
import 'package:engineering_platform/core/state/language_state.dart';
import 'package:engineering_platform/core/constants/assets.dart';
import 'package:engineering_platform/core/data/services_data.dart';
import 'package:engineering_platform/core/utils/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _servicesKey = GlobalKey();

  void _scrollToServices() {
    final context = _servicesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return Column(
          children: [
            HeroSection(onGetStarted: _scrollToServices),
            ServicesSection(key: _servicesKey),
          ],
        );
      },
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onGetStarted;
  const HeroSection({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade50.withValues(alpha: 0.5),
                Colors.white,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 24 : 64,
            vertical: Responsive.isMobile(context) ? 40 : 60,
          ),
          child: Flex(
            direction: Responsive.isMobile(context)
                ? Axis.vertical
                : Axis.horizontal,
            textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            children: [
              // Hero Text
              Expanded(
                flex: Responsive.isMobile(context) ? 0 : 1,
                child: Column(
                  crossAxisAlignment: lang == 'ar'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        lang == 'ar'
                            ? 'مرحباً بك في مستقبل الهندسة'
                            : 'Welcome to the Future of Engineering',
                        style: TextStyle(
                          color: Colors.deepPurple.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppTranslations.get('hero_title', lang),
                      textAlign: lang == 'ar'
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 40 : 64,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppTranslations.get('hero_subtitle', lang),
                      textAlign: lang == 'ar'
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 16 : 20,
                        height: 1.5,
                        color: AppColors.textSecondary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      height: 56,
                      width: Responsive.isMobile(context)
                          ? double.infinity
                          : null,
                      child: ElevatedButton(
                        onPressed: onGetStarted,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          backgroundColor: const Color(
                            0xFF7C3AED,
                          ), // Deep Purple
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.deepPurple.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppTranslations.get('get_started', lang),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (Responsive.isMobile(context))
                const SizedBox(height: 64)
              else
                const SizedBox(width: 64),
              // Hero Image Asset
              Expanded(
                flex: Responsive.isMobile(context) ? 0 : 1,
                child: Container(
                  height: Responsive.isMobile(context) ? 300 : 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.logo),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        final bool isMobile = Responsive.isMobile(context);
        final bool isTablet = Responsive.isTablet(context);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: isMobile ? 40 : 60,
          ),
          child: Column(
            crossAxisAlignment: lang == 'ar'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.get('our_services', lang),
                style: TextStyle(
                  fontSize: isMobile ? 32 : 40,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
                  crossAxisSpacing: 32,
                  mainAxisSpacing: isMobile ? 32 : 48,
                  childAspectRatio: isMobile ? 0.95 : 0.85,
                ),
                itemCount: ServicesData.mainServices.length,
                itemBuilder: (context, index) {
                  final service = ServicesData.mainServices[index];
                  return ServiceCard(
                    title: AppTranslations.get(service.titleKey, lang),
                    desc: AppTranslations.get(service.descKey, lang),
                    imagePath: service.imagePath,
                    onTap: () => Navigator.pushNamed(context, service.route),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String title;
  final String desc;
  final String imagePath;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.desc,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              0,
              isHovered ? -10.0 : 0.0,
              0.0,
            ),
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: lang == 'ar'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: Colors.deepPurple.withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ]
                          : [],
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.deepPurple.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.all(16),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    textAlign: lang == 'ar' ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isHovered
                          ? const Color(0xFF7C3AED)
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.desc,
                    textAlign: lang == 'ar' ? TextAlign.right : TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
