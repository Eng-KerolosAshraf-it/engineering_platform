import 'package:flutter/material.dart';
import 'package:engineering_platform/core/constants/colors.dart';
import 'package:engineering_platform/core/constants/translations.dart';
import 'package:engineering_platform/core/state/language_state.dart';
import 'package:engineering_platform/core/data/services_data.dart';
import 'package:engineering_platform/core/utils/responsive.dart';
import 'package:engineering_platform/presentation/web/forms/structural_design_form.dart';
import 'package:engineering_platform/presentation/web/forms/supervision_form.dart';
import 'package:engineering_platform/presentation/web/forms/construction_form.dart';

class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({super.key});

  void _showFormDialog(BuildContext context, String serviceId) {
    Widget form;
    switch (serviceId) {
      case 'struct':
        form = const StructuralDesignForm();
        break;
      case 'construction':
        form = const ConstructionForm();
        break;
      case 'supervision':
        form = const SupervisionForm();
        break;
      default:
        form = const Center(child: Text('Form not found'));
    }

    final bool isMobile = Responsive.isMobile(context);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(isMobile ? 16 : 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: MediaQuery.of(context).size.width * (isMobile ? 0.95 : 0.8),
          height: MediaQuery.of(context).size.height * 0.9,
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(child: form),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        final bool isMobile = Responsive.isMobile(context);
        final bool isTablet = Responsive.isTablet(context);

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.accent.withValues(alpha: 0.05), Colors.white],
            ),
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: isMobile ? 40 : 80,
          ),
          child: Column(
            crossAxisAlignment: lang == 'ar'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  AppTranslations.get('step_closer', lang),
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppTranslations.get('choose_service', lang),
                textAlign: lang == 'ar' ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppTranslations.get('select_specialty', lang),
                textAlign: lang == 'ar' ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 64),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: isMobile ? 1.0 : 0.75,
                ),
                itemCount: ServicesData.civilSubServices.length,
                itemBuilder: (context, index) {
                  final service = ServicesData.civilSubServices[index];
                  return SelectionCard(
                    title: AppTranslations.get(service['titleKey'], lang),
                    serviceId: service['id'],
                    onTap: () => _showFormDialog(context, service['id']),
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

class SelectionCard extends StatefulWidget {
  final String title;
  final String serviceId;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    required this.serviceId,
    required this.onTap,
  });

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, isHovered ? -15.0 : 0.0, 0.0),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: Responsive.isMobile(context) ? 250 : 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? AppColors.accent.withValues(alpha: 0.3)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
            ),
            child: Stack(
              children: [
                if (isHovered)
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isHovered
                              ? AppColors.accent
                              : AppColors.greyLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getIconForService(widget.serviceId),
                          size: 48,
                          color: isHovered ? Colors.white : AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: isHovered
                              ? AppColors.accent
                              : AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isHovered ? 1.0 : 0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppTranslations.get(
                                'start_now',
                                languageNotifier.value,
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: AppColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForService(String id) {
    switch (id) {
      case 'struct':
        return Icons.architecture_rounded;
      case 'construction':
        return Icons.foundation_rounded;
      case 'supervision':
        return Icons.assignment_turned_in_rounded;
      default:
        return Icons.engineering_rounded;
    }
  }
}
