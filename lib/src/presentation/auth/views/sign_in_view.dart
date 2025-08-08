import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/config/constants/app_vectors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yolla/core/router/routes.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController _phoneController;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        leading: GoRouter.of(context).canPop()
            ? GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.only(left: 16.0),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGrayColor),
            ),
            child: const Icon(Icons.arrow_back),
          ),
        )
            : null,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Divider()),
                const SizedBox(width: 8,),
                Text(localizations.or),
                const SizedBox(width: 8,),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightGrayColor,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppVectors.googleIcon),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightGrayColor,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppVectors.facebookIcon),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            RichText(
              text: TextSpan(
                style: textTheme.bodyMedium,
                children: [
                  TextSpan(text: localizations.doNotHaveAccount, style: textTheme.bodyMedium),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: localizations.createAccount,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24,),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _validateAndProceed(localizations);
                },
                child: Text(localizations.sendCode),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.logIn,
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.fillTheForm,
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.grayColor,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                cursorColor: AppColors.primaryColor,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _AzerbaijaniPhoneFormatter(),
                ],
                onChanged: (value) {
                  // Clear error when user starts typing
                  if (_phoneError != null) {
                    setState(() {
                      _phoneError = null;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: localizations.phoneNumber,
                  prefixText: '+994',
                  errorText: _phoneError,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                localizations.forgotPassword,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndProceed(localizations) {
    final phoneDigits = _phoneController.text.replaceAll('-', '').trim();
    
    if (phoneDigits.isEmpty) {
      setState(() {
        _phoneError = localizations.phoneNumberRequired;
      });
      return;
    }
    
    if (phoneDigits.length < 9) {
      setState(() {
        _phoneError = localizations.phoneNumberIncomplete;
      });
      return;
    }
    
    // Phone number is valid, proceed to OTP
    final phone = '+994$phoneDigits';
    context.push(Routes.otpVerifyView, extra: phone);
  }
}

class _AzerbaijaniPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length && i < 9; i++) {
      if (i == 0) {
        buffer.write('-');
      } else if (i == 2 || i == 5 || i == 7) {
        buffer.write('-');
      }
      buffer.write(digitsOnly[i]);
    }

    final formattedValue = buffer.toString();

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
