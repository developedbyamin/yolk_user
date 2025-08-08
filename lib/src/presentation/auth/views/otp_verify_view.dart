import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/core/router/routes.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyView extends StatefulWidget {
  final String phoneNumber;
  const OtpVerifyView({super.key, required this.phoneNumber});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  Timer? _timer;
  int _totalSeconds = 119;
  bool _timerEnded = false;
  late TextEditingController _pinPutController;
  String pin = '';

  @override
  void initState() {
    super.initState();
    _pinPutController = TextEditingController();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _timerEnded = false;
      _totalSeconds = 119;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalSeconds > 0) {
        setState(() {
          _totalSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _timerEnded = true;
        });
      }
    });
  }

  String get timerText {
    final minutes = (_totalSeconds / 60).floor();
    final seconds = _totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinPutController.dispose();
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
            _timerEnded
                ? GestureDetector(
              onTap: () {
                startTimer();
              },
              child: RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(text: localizations.didNotReceiveCode, style: textTheme.bodyMedium),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: localizations.sendAgain,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Text(timerText, style: textTheme.bodyLarge),
            const SizedBox(height: 24,),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go(Routes.qrView);
                },
                child: Text(localizations.continueApp),
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
                localizations.confirmationOTP,
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.phoneOTP(widget.phoneNumber),
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.grayColor,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Pinput(
                  length: 4,
                  controller: _pinPutController,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 72,
                    height: 72,
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightGrayColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      pin = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}