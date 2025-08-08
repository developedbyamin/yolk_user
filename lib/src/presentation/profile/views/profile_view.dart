import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/core/router/routes.dart';
import 'package:yolla/core/utils/blocs/localization/localization_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool pushNotifications = true;
  
  // User data - stored in SharedPreferences
  String username = "John Doe";
  String phoneNumber = "+994 50 123 45 67";
  final String? profileImageUrl = null; // Set to null to show placeholder
  
  // Text editing controllers
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'John Doe';
      phoneNumber = prefs.getString('phoneNumber') ?? '+994 50 123 45 67';
      pushNotifications = prefs.getBool('pushNotifications') ?? true;
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setBool('pushNotifications', pushNotifications);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = context.localizations;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          localizations.profile,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Handle edit profile
            },
            icon: const Icon(
              Icons.notifications_active_sharp,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            _buildProfilePictureSection(textTheme, localizations),
            const SizedBox(height: 32),
            
            // Personal Information Section
            _buildPersonalInfoSection(textTheme, localizations),
            const SizedBox(height: 24),
            
            // Preferences Section
            _buildPreferencesSection(textTheme, localizations),
            const SizedBox(height: 24),
            
            // Notifications Section
            _buildNotificationsSection(textTheme, localizations),
            const SizedBox(height: 24),
            
            // Logout Section
            _buildLogoutSection(textTheme, localizations),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection(TextTheme textTheme, localizations) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lightGrayColor,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: profileImageUrl != null
                      ? Image.network(
                          profileImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildProfilePlaceholder();
                          },
                        )
                      : _buildProfilePlaceholder(),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle profile picture edit
                    _showImagePicker();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.whiteColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: AppColors.whiteColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            username,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phoneNumber,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePlaceholder() {
    return Container(
      color: AppColors.lightGrayColor,
      child: const Icon(
        Icons.person,
        size: 60,
        color: AppColors.grayColor,
      ),
    );
  }



  Widget _buildPersonalInfoSection(TextTheme textTheme, localizations) {
    return Column(
      children: [
        _buildInfoTile(
          icon: Icons.person_outline,
          title: localizations.username,
          value: username,
          onTap: () {
            _showEditUsernameDialog();
          },
        ),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: Icons.phone_outlined,
          title: localizations.phoneNumber,
          value: phoneNumber,
          onTap: () {
            _showEditPhoneDialog();
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(TextTheme textTheme, localizations) {
    return _buildLanguageTile(textTheme, localizations);
  }

  Widget _buildNotificationsSection(TextTheme textTheme, localizations) {
    return _buildSwitchTile(
      title: localizations.pushNotifications,
      value: pushNotifications,
      onChanged: (value) {
        setState(() {
          pushNotifications = value;
        });
        _saveUserData(); // Save when changed
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        // Light gray circular container with icon
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGrayColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppColors.grayColor,
          ),
        ),
        const SizedBox(width: 16),
        // Title and value
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grayColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Change container
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            child: Text(
              context.localizations.change,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTile(TextTheme textTheme, localizations) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        final localizationCubit = context.read<LocalizationCubit>();
        return Row(
          children: [
            // Light gray circular container with icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.lightGrayColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.language,
                size: 24,
                color: AppColors.grayColor,
              ),
            ),
            const SizedBox(width: 16),
            // Title and value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.language,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.grayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localizationCubit.getCurrentLanguageName(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Change container
            GestureDetector(
              onTap: () {
                _showLanguageSelector(localizations, context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  localizations.change,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        // Light gray circular container with icon
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGrayColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_outlined,
            size: 24,
            color: AppColors.grayColor,
          ),
        ),
        const SizedBox(width: 16),
        // Title
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Switch
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
          activeTrackColor: AppColors.primaryColor.withOpacity(0.3),
          inactiveThumbColor: AppColors.grayColor,
          inactiveTrackColor: AppColors.mediumLightGradyColor,
        ),
      ],
    );
  }

  Widget _buildLogoutSection(TextTheme textTheme, localizations) {
    return Row(
      children: [
        // Light gray circular container with icon
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGrayColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.logout,
            size: 24,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        // Title
        Expanded(
          child: Text(
            localizations.logout,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Logout button
        GestureDetector(
          onTap: () {
            _showLogoutConfirmation(localizations);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
            ),
            child: Text(
              localizations.logout,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmation(localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            localizations.logoutConfirmation,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: Text(
            localizations.logoutDescription,
            style: const TextStyle(color: AppColors.blackColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                localizations.cancel,
                style: const TextStyle(color: AppColors.grayColor),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                await _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                localizations.logout,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      // Clear all stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      // Reset the app using Phoenix
      if (mounted) {
        Phoenix.rebirth(context);
        context.push(Routes.signInView);
      }
    } catch (e) {
      // Handle error if needed
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error during logout'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImagePicker() {
    final localizations = context.localizations;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                localizations.chooseProfilePicture,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    label: localizations.camera,
                    onTap: () {
                      Navigator.pop(context);
                      // Handle camera pick
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    label: localizations.gallery,
                    onTap: () {
                      Navigator.pop(context);
                      // Handle gallery pick
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(localizations, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                localizations.selectLanguage,
                style: Theme.of(modalContext).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildLanguageOption(
                localizations.english, 
                const Locale('en'), 
                modalContext,
                context,
              ),
              _buildLanguageOption(
                localizations.azerbaijani, 
                const Locale('az'), 
                modalContext,
                context,
              ),
              _buildLanguageOption(
                localizations.russian, 
                const Locale('ru'), 
                modalContext,
                context,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    String displayName, 
    Locale locale, 
    BuildContext modalContext, 
    BuildContext parentContext
  ) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, currentLocale) {
        final isSelected = currentLocale.languageCode == locale.languageCode;
        return GestureDetector(
          onTap: () {
            context.read<LocalizationCubit>().changeLocale(locale);
            Navigator.pop(modalContext);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightGrayColor,
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                  ? Border.all(color: AppColors.primaryColor, width: 1.5)
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayName,
                    style: Theme.of(modalContext).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditUsernameDialog() {
    final localizations = context.localizations;
    _usernameController.text = username;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            localizations.editUsername,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: localizations.username,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                localizations.cancel,
                style: const TextStyle(color: AppColors.grayColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newUsername = _usernameController.text.trim();
                if (newUsername.isNotEmpty) {
                  setState(() {
                    username = newUsername;
                  });
                  _saveUserData();
                  Navigator.pop(context);
                } else {
                  // Show error for empty username
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizations.usernameRequired),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                localizations.save,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditPhoneDialog() {
    final localizations = context.localizations;
    _phoneController.text = phoneNumber;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            localizations.editPhoneNumber,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: localizations.phoneNumber,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
              prefixText: '+',
            ),
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                localizations.cancel,
                style: const TextStyle(color: AppColors.grayColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newPhone = _phoneController.text.trim();
                if (newPhone.isNotEmpty && _isValidPhoneNumber(newPhone)) {
                  setState(() {
                    phoneNumber = newPhone;
                  });
                  _saveUserData();
                  Navigator.pop(context);
                } else {
                  // Show error for invalid phone number
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizations.phoneNumberRequired),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                localizations.save,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isValidPhoneNumber(String phone) {
    // Basic phone number validation - you can make this more sophisticated
    return phone.replaceAll(RegExp(r'[^\d]'), '').length >= 10;
  }
}