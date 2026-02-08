import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/translations.dart';
import '../../../core/state/language_state.dart';
import '../../../core/constants/assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6366F1), // Indigo
                  Color(0xFFA855F7), // Purple
                  Color(0xFFEC4899), // Pink
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? 500 : 1000,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Flex(
                          direction: isMobile ? Axis.vertical : Axis.horizontal,
                          children: [
                            // Left Section - Branding (Purple)
                            Flexible(
                              flex: isMobile ? 0 : 1,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 60,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF7C3AED), // Deep Purple
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppTranslations.get('login_title', lang),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      AppTranslations.get(
                                        'login_subtitle',
                                        lang,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    // Circular Image Placeholder
                                    Container(
                                      width: 220,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                          width: 10,
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(AppAssets.logo),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right Section - Form
                            Flexible(
                              flex: isMobile ? 0 : 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 60,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppTranslations.get('login_btn', lang),
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      // Email Input
                                      TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppTranslations.get(
                                              'required_field',
                                              lang,
                                            );
                                          }
                                          if (!value.contains('@')) {
                                            return AppTranslations.get(
                                              'invalid_email',
                                              lang,
                                            );
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: AppTranslations.get(
                                            'email',
                                            lang,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                            color: Color(0xFF7C3AED),
                                          ),
                                          hintText: AppTranslations.get(
                                            'email_hint',
                                            lang,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF7C3AED),
                                                  width: 2,
                                                ),
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      // Password Input
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppTranslations.get(
                                              'required_field',
                                              lang,
                                            );
                                          }
                                          if (value.length < 6) {
                                            return AppTranslations.get(
                                              'short_password',
                                              lang,
                                            );
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: AppTranslations.get(
                                            'password',
                                            lang,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                            color: Color(0xFF7C3AED),
                                          ),
                                          hintText: AppTranslations.get(
                                            'password_hint',
                                            lang,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF7C3AED),
                                                  width: 2,
                                                ),
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      // Forgot Password & Remember Me
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: true,
                                                onChanged: (v) {},
                                                activeColor: const Color(
                                                  0xFF7C3AED,
                                                ),
                                              ),
                                              Text(
                                                AppTranslations.get(
                                                  'remember_me',
                                                  lang,
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              AppTranslations.get(
                                                'forgot_password',
                                                lang,
                                              ),
                                              style: const TextStyle(
                                                color: Color(0xFF7C3AED),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      // Log In Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Perform login logic here
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/',
                                                (route) => false,
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF5046E5,
                                            ), // Blueish Purple
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            AppTranslations.get(
                                              'login_btn',
                                              lang,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        AppTranslations.get(
                                          'continue_with',
                                          lang,
                                        ),
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Social Icons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _SocialButton(
                                            icon: Icons.g_mobiledata,
                                            label: 'Google',
                                            onPressed: () {},
                                          ),
                                          const SizedBox(width: 16),
                                          _SocialButton(
                                            icon: Icons.facebook,
                                            label: 'Facebook',
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      // Footer
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            AppTranslations.get(
                                              'no_account',
                                              lang,
                                            ),
                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/signup',
                                              );
                                            },
                                            child: Text(
                                              AppTranslations.get(
                                                'signup_btn',
                                                lang,
                                              ),
                                              style: const TextStyle(
                                                color: Color(0xFF7C3AED),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Back to Home
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pushNamed(context, '/'),
                                        child: Text(
                                          AppTranslations.get(
                                            'back_to_home',
                                            lang,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
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
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Row(
                    children: [
                      _LangToggle(
                        label: 'EN',
                        code: 'en',
                        isActive: lang == 'en',
                      ),
                      const SizedBox(width: 8),
                      _LangToggle(
                        label: 'AR',
                        code: 'ar',
                        isActive: lang == 'ar',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: icon == Icons.facebook ? const Color(0xFF1877F2) : Colors.red,
        ),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  final String label;
  final String code;
  final bool isActive;

  const _LangToggle({
    required this.label,
    required this.code,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => languageNotifier.value = code,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
