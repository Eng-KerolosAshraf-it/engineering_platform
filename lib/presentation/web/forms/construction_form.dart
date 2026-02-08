import 'package:flutter/material.dart';
import 'package:engineering_platform/shared/widgets/form_components.dart';
import 'package:engineering_platform/core/constants/colors.dart';
import 'package:engineering_platform/core/constants/translations.dart';
import 'package:engineering_platform/core/state/language_state.dart';
import 'package:engineering_platform/core/utils/responsive.dart';

class ConstructionForm extends StatefulWidget {
  const ConstructionForm({super.key});

  @override
  State<ConstructionForm> createState() => _ConstructionFormState();
}

class _ConstructionFormState extends State<ConstructionForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailedAddressController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _buildingAreaController = TextEditingController();
  final _floorsController = TextEditingController();
  final _unitsController = TextEditingController();
  final _notesController = TextEditingController();

  String constructionServiceType = 'Structural Execution Only';
  bool hasExistingDesign = false;
  bool isSiteAvailable = true;
  String projectType = 'Residential';
  String buildingType = 'Villa';
  bool isInsideCompound = false;
  String designPhase = 'New Design';
  String soilType = 'Clay';
  bool hasBasement = false;
  String facadeDirection = 'North';
  bool clientWantsSoilStudy = false;

  // Utilities
  bool utilityAll = false;
  bool utilitySewer = false;
  bool utilityWater = false;
  bool utilityElectricity = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _idNumberController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _detailedAddressController.dispose();
    _landAreaController.dispose();
    _buildingAreaController.dispose();
    _floorsController.dispose();
    _unitsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        final bool isMobile = Responsive.isMobile(context);

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 20 : 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppTranslations.get('const_form_title', lang),
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                FormSection(
                  title: AppTranslations.get('personal_info', lang),
                  children: [
                    FormRow(
                      children: [
                        Expanded(
                          child: AppFormField(
                            label: AppTranslations.get('first_name', lang),
                            icon: Icons.person_outline,
                            controller: _firstNameController,
                            validator: (v) => v!.isEmpty
                                ? AppTranslations.get('required_error', lang)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: AppFormField(
                            label: AppTranslations.get('middle_name', lang),
                            icon: Icons.person_outline,
                            controller: _middleNameController,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: AppFormField(
                            label: AppTranslations.get('last_name', lang),
                            icon: Icons.person_outline,
                            controller: _lastNameController,
                            validator: (v) => v!.isEmpty
                                ? AppTranslations.get('required_error', lang)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('id_number', lang),
                      icon: Icons.badge_outlined,
                      controller: _idNumberController,
                      validator: (v) => v!.isEmpty
                          ? AppTranslations.get('required_error', lang)
                          : null,
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('address', lang),
                      icon: Icons.home_outlined,
                      controller: _addressController,
                      validator: (v) => v!.isEmpty
                          ? AppTranslations.get('required_error', lang)
                          : null,
                    ),
                    const SizedBox(height: 24),
                    FormRow(
                      children: [
                        Expanded(
                          child: AppFormField(
                            label: AppTranslations.get('phone_number', lang),
                            icon: Icons.phone_outlined,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (v) => v!.isEmpty
                                ? AppTranslations.get('required_error', lang)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: AppFormField(
                            label: AppTranslations.get(
                              'alt_phone_number',
                              lang,
                            ),
                            icon: Icons.phone_android_outlined,
                            controller: _altPhoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('email', lang),
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.isEmpty
                          ? AppTranslations.get('required_error', lang)
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                FormSection(
                  title: AppTranslations.get('req_service_details', lang),
                  children: [
                    ServiceTypeButton(
                      label: AppTranslations.get('const_service', lang),
                      isSelected: true,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      AppTranslations.get('scope_const_service', lang),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      children: [
                        RadioOption(
                          label: AppTranslations.get('struct_exec_only', lang),
                          isSelected:
                              constructionServiceType ==
                              'Structural Execution Only',
                          onTap: () => setState(
                            () => constructionServiceType =
                                'Structural Execution Only',
                          ),
                        ),
                        RadioOption(
                          label: AppTranslations.get(
                            'full_turnkey_const',
                            lang,
                          ),
                          isSelected:
                              constructionServiceType == 'Full Construction',
                          onTap: () => setState(
                            () => constructionServiceType = 'Full Construction',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      AppTranslations.get('existing_arch_design', lang),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    FormRow(
                      children: [
                        RadioOption(
                          label: AppTranslations.get('yes', lang),
                          isSelected: hasExistingDesign,
                          onTap: () => setState(() => hasExistingDesign = true),
                        ),
                        const SizedBox(width: 24),
                        RadioOption(
                          label: AppTranslations.get('no', lang),
                          isSelected: !hasExistingDesign,
                          onTap: () =>
                              setState(() => hasExistingDesign = false),
                        ),
                      ],
                    ),
                    if (hasExistingDesign) ...[
                      const SizedBox(height: 24),
                      FileUploadPlaceholder(
                        label: AppTranslations.get('upload_arch_design', lang),
                      ),
                    ],
                    const SizedBox(height: 32),
                    Text(
                      AppTranslations.get('site_accessible', lang),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    FormRow(
                      children: [
                        RadioOption(
                          label: AppTranslations.get('yes', lang),
                          isSelected: isSiteAvailable,
                          onTap: () => setState(() => isSiteAvailable = true),
                        ),
                        const SizedBox(width: 24),
                        RadioOption(
                          label: AppTranslations.get('no', lang),
                          isSelected: !isSiteAvailable,
                          onTap: () => setState(() => isSiteAvailable = false),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                FormSection(
                  title: AppTranslations.get('project_type', lang),
                  children: [
                    Wrap(
                      spacing: 24,
                      runSpacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          AppTranslations.get('project_type', lang),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ServiceTypeButton(
                          label: AppTranslations.get('res_const', lang),
                          isSelected: projectType == 'Residential',
                          onTap: () =>
                              setState(() => projectType = 'Residential'),
                        ),
                        ServiceTypeButton(
                          label: AppTranslations.get('comm_const', lang),
                          isSelected: projectType == 'Commercial',
                          onTap: () =>
                              setState(() => projectType = 'Commercial'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      AppTranslations.get('building_type', lang),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children:
                          [
                                'villa',
                                'apt_building',
                                'office_building',
                                'factory',
                              ]
                              .map(
                                (key) => RadioOption(
                                  label: AppTranslations.get(key, lang),
                                  isSelected:
                                      buildingType ==
                                      AppTranslations.get(key, 'en'),
                                  onTap: () => setState(
                                    () => buildingType = AppTranslations.get(
                                      key,
                                      'en',
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 32),
                    AppFormField(
                      label: AppTranslations.get('project_location', lang),
                      icon: Icons.location_on_outlined,
                      controller: _locationController,
                      validator: (v) => v!.isEmpty
                          ? AppTranslations.get('required_error', lang)
                          : null,
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('detailed_address', lang),
                      isLarge: true,
                      icon: Icons.map_outlined,
                      controller: _detailedAddressController,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                FormSection(
                  title: AppTranslations.get('land_area', lang),
                  children: [
                    Text(
                      AppTranslations.get('soil_type', lang),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      children: ['clay', 'sandy', 'rocky', 'other']
                          .map(
                            (key) => RadioOption(
                              label: AppTranslations.get(key, lang),
                              isSelected:
                                  soilType == AppTranslations.get(key, 'en'),
                              onTap: () => setState(
                                () => soilType = AppTranslations.get(key, 'en'),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                    AppFormField(
                      label: AppTranslations.get('total_land_area', lang),
                      icon: Icons.square_foot_rounded,
                      controller: _landAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('actual_building_area', lang),
                      icon: Icons.home_work_outlined,
                      controller: _buildingAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    AppFormField(
                      label: AppTranslations.get('num_floors', lang),
                      icon: Icons.layers_outlined,
                      controller: _floorsController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                Center(
                  child: SizedBox(
                    height: 60,
                    width: isMobile ? double.infinity : 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Submit
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        AppTranslations.get('submit_request', lang),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      },
    );
  }
}
