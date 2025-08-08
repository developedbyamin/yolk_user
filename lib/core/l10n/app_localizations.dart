import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @logIn.
  ///
  /// In az, this message translates to:
  /// **'Daxil ol'**
  String get logIn;

  /// No description provided for @fillTheForm.
  ///
  /// In az, this message translates to:
  /// **'Hesabınıza daxil olmaq və alış-verişə başlamaq üçün formu doldurun!'**
  String get fillTheForm;

  /// No description provided for @phoneNumber.
  ///
  /// In az, this message translates to:
  /// **'Telefon nömrəsi'**
  String get phoneNumber;

  /// No description provided for @forgotPassword.
  ///
  /// In az, this message translates to:
  /// **'Şifrəni unutmusunuz?'**
  String get forgotPassword;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In az, this message translates to:
  /// **'Hesabınız yoxdur?'**
  String get doNotHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In az, this message translates to:
  /// **'Hesab yarat'**
  String get createAccount;

  /// No description provided for @sendCode.
  ///
  /// In az, this message translates to:
  /// **'Kodu göndər'**
  String get sendCode;

  /// No description provided for @or.
  ///
  /// In az, this message translates to:
  /// **'Və ya'**
  String get or;

  /// No description provided for @confirmationOTP.
  ///
  /// In az, this message translates to:
  /// **'OTP Təsdiqi'**
  String get confirmationOTP;

  /// No description provided for @phoneOTP.
  ///
  /// In az, this message translates to:
  /// **'{number} nömrəsinə birdəfəlik şifrə göndərildi'**
  String phoneOTP(Object number);

  /// No description provided for @didNotReceiveCode.
  ///
  /// In az, this message translates to:
  /// **'Kod gəlməyib?'**
  String get didNotReceiveCode;

  /// No description provided for @sendAgain.
  ///
  /// In az, this message translates to:
  /// **'Təkrar göndər'**
  String get sendAgain;

  /// No description provided for @continueApp.
  ///
  /// In az, this message translates to:
  /// **'Davam et'**
  String get continueApp;

  /// No description provided for @qr.
  ///
  /// In az, this message translates to:
  /// **'QR'**
  String get qr;

  /// No description provided for @sale.
  ///
  /// In az, this message translates to:
  /// **'Endirim'**
  String get sale;

  /// No description provided for @history.
  ///
  /// In az, this message translates to:
  /// **'Tarixçə'**
  String get history;

  /// No description provided for @profile.
  ///
  /// In az, this message translates to:
  /// **'Hesab'**
  String get profile;

  /// No description provided for @username.
  ///
  /// In az, this message translates to:
  /// **'İstifadəçi adı'**
  String get username;

  /// No description provided for @language.
  ///
  /// In az, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In az, this message translates to:
  /// **'Bildirişlər'**
  String get notifications;

  /// No description provided for @editProfile.
  ///
  /// In az, this message translates to:
  /// **'Profili redaktə et'**
  String get editProfile;

  /// No description provided for @settings.
  ///
  /// In az, this message translates to:
  /// **'Tənzimləmələr'**
  String get settings;

  /// No description provided for @personalInformation.
  ///
  /// In az, this message translates to:
  /// **'Şəxsi məlumatlar'**
  String get personalInformation;

  /// No description provided for @preferences.
  ///
  /// In az, this message translates to:
  /// **'Seçimlər'**
  String get preferences;

  /// No description provided for @selectLanguage.
  ///
  /// In az, this message translates to:
  /// **'Dil seçin'**
  String get selectLanguage;

  /// No description provided for @pushNotifications.
  ///
  /// In az, this message translates to:
  /// **'Push bildirişləri'**
  String get pushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In az, this message translates to:
  /// **'E-mail bildirişləri'**
  String get emailNotifications;

  /// No description provided for @smsNotifications.
  ///
  /// In az, this message translates to:
  /// **'SMS bildirişləri'**
  String get smsNotifications;

  /// No description provided for @english.
  ///
  /// In az, this message translates to:
  /// **'İngiliscə'**
  String get english;

  /// No description provided for @azerbaijani.
  ///
  /// In az, this message translates to:
  /// **'Azərbaycanca'**
  String get azerbaijani;

  /// No description provided for @russian.
  ///
  /// In az, this message translates to:
  /// **'Rusca'**
  String get russian;

  /// No description provided for @scanInstruction.
  ///
  /// In az, this message translates to:
  /// **'QR kodu və ya barkodu skan etmək üçün çərçivə daxilində yerləşdirin'**
  String get scanInstruction;

  /// No description provided for @scanningDisabled.
  ///
  /// In az, this message translates to:
  /// **'Skan deaktivdir - Davam etmək üçün məhsul siyahısını bağlayın'**
  String get scanningDisabled;

  /// No description provided for @selectProducts.
  ///
  /// In az, this message translates to:
  /// **'Məhsulları seçin'**
  String get selectProducts;

  /// No description provided for @totalPrice.
  ///
  /// In az, this message translates to:
  /// **'Ümumi qiymət:'**
  String get totalPrice;

  /// No description provided for @addProduct.
  ///
  /// In az, this message translates to:
  /// **'Məhsul əlavə et'**
  String get addProduct;

  /// No description provided for @checkout.
  ///
  /// In az, this message translates to:
  /// **'Ödəniş'**
  String get checkout;

  /// No description provided for @pleaseAddProducts.
  ///
  /// In az, this message translates to:
  /// **'Ödənişdən əvvəl bəzi məhsullar əlavə edin'**
  String get pleaseAddProducts;

  /// No description provided for @noProductsSelected.
  ///
  /// In az, this message translates to:
  /// **'Heç bir məhsul seçilməyib'**
  String get noProductsSelected;

  /// No description provided for @deliveryDetails.
  ///
  /// In az, this message translates to:
  /// **'Çatdırılma təfərrüatları'**
  String get deliveryDetails;

  /// No description provided for @selectDate.
  ///
  /// In az, this message translates to:
  /// **'Tarix seçin'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In az, this message translates to:
  /// **'Vaxt seçin'**
  String get selectTime;

  /// No description provided for @pay.
  ///
  /// In az, this message translates to:
  /// **'Ödə'**
  String get pay;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In az, this message translates to:
  /// **'Sifariş uğurla yerləşdirildi!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @orderConfirmation.
  ///
  /// In az, this message translates to:
  /// **'Sifariş təsdiqi'**
  String get orderConfirmation;

  /// No description provided for @orderConfirmationText.
  ///
  /// In az, this message translates to:
  /// **'{count} məhsul üçün sifariş verməkdəsiniz.'**
  String orderConfirmationText(Object count);

  /// No description provided for @total.
  ///
  /// In az, this message translates to:
  /// **'Cəmi:'**
  String get total;

  /// No description provided for @cancel.
  ///
  /// In az, this message translates to:
  /// **'Ləğv et'**
  String get cancel;

  /// No description provided for @confirmOrder.
  ///
  /// In az, this message translates to:
  /// **'Sifarişi təsdiqlə'**
  String get confirmOrder;

  /// No description provided for @logout.
  ///
  /// In az, this message translates to:
  /// **'Çıxış'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In az, this message translates to:
  /// **'Çıxış etmək istədiyinizdən əminsiniz?'**
  String get logoutConfirmation;

  /// No description provided for @logoutDescription.
  ///
  /// In az, this message translates to:
  /// **'Hesabınızdan çıxacaqsınız və giriş ekranına qaytarılacaqsınız.'**
  String get logoutDescription;

  /// No description provided for @change.
  ///
  /// In az, this message translates to:
  /// **'Dəyişdir'**
  String get change;

  /// No description provided for @chooseProfilePicture.
  ///
  /// In az, this message translates to:
  /// **'Profil şəkli seçin'**
  String get chooseProfilePicture;

  /// No description provided for @camera.
  ///
  /// In az, this message translates to:
  /// **'Kamera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In az, this message translates to:
  /// **'Qalereya'**
  String get gallery;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In az, this message translates to:
  /// **'Düzgün telefon nömrəsi daxil edin'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberIncomplete.
  ///
  /// In az, this message translates to:
  /// **'Zəhmət olmasa tam telefon nömrəsini daxil edin'**
  String get phoneNumberIncomplete;

  /// No description provided for @pcs.
  ///
  /// In az, this message translates to:
  /// **'ədəd'**
  String get pcs;

  /// No description provided for @kg.
  ///
  /// In az, this message translates to:
  /// **'kq'**
  String get kg;

  /// No description provided for @each.
  ///
  /// In az, this message translates to:
  /// **'hər biri'**
  String get each;

  /// No description provided for @totalAmount.
  ///
  /// In az, this message translates to:
  /// **'cəmi'**
  String get totalAmount;

  /// No description provided for @details.
  ///
  /// In az, this message translates to:
  /// **'Təfərrüatlar'**
  String get details;

  /// No description provided for @pending.
  ///
  /// In az, this message translates to:
  /// **'Gözləyən'**
  String get pending;

  /// No description provided for @delivered.
  ///
  /// In az, this message translates to:
  /// **'Çatdırılıb'**
  String get delivered;

  /// No description provided for @editUsername.
  ///
  /// In az, this message translates to:
  /// **'İstifadəçi adını redaktə et'**
  String get editUsername;

  /// No description provided for @editPhoneNumber.
  ///
  /// In az, this message translates to:
  /// **'Telefon nömrəsini redaktə et'**
  String get editPhoneNumber;

  /// No description provided for @save.
  ///
  /// In az, this message translates to:
  /// **'Saxla'**
  String get save;

  /// No description provided for @usernameRequired.
  ///
  /// In az, this message translates to:
  /// **'İstifadəçi adı tələb olunur'**
  String get usernameRequired;

  /// No description provided for @limitedTimeOnly.
  ///
  /// In az, this message translates to:
  /// **'Yalnız məhdud müddət!'**
  String get limitedTimeOnly;

  /// No description provided for @dontMissOut.
  ///
  /// In az, this message translates to:
  /// **'Qaçırmayın!'**
  String get dontMissOut;

  /// No description provided for @saveOnFavorites.
  ///
  /// In az, this message translates to:
  /// **'Sevimlilərinizə qənaət edin'**
  String get saveOnFavorites;

  /// No description provided for @megaSale.
  ///
  /// In az, this message translates to:
  /// **'MEGA ENDİRİM'**
  String get megaSale;

  /// No description provided for @upToPercentOff.
  ///
  /// In az, this message translates to:
  /// **'70%-ə qədər ENDİRİM'**
  String get upToPercentOff;

  /// No description provided for @shopNow.
  ///
  /// In az, this message translates to:
  /// **'İndi alış-veriş edin'**
  String get shopNow;

  /// No description provided for @foodDrinks.
  ///
  /// In az, this message translates to:
  /// **'Yemək və İçki'**
  String get foodDrinks;

  /// No description provided for @electronics.
  ///
  /// In az, this message translates to:
  /// **'Elektronika'**
  String get electronics;

  /// No description provided for @beauty.
  ///
  /// In az, this message translates to:
  /// **'Gözəllik'**
  String get beauty;

  /// No description provided for @home.
  ///
  /// In az, this message translates to:
  /// **'Ev'**
  String get home;

  /// No description provided for @flashSales.
  ///
  /// In az, this message translates to:
  /// **'Sürətli Satışlar'**
  String get flashSales;

  /// No description provided for @popularDiscounts.
  ///
  /// In az, this message translates to:
  /// **'Populyar Endirimlər'**
  String get popularDiscounts;

  /// No description provided for @categoryDiscounts.
  ///
  /// In az, this message translates to:
  /// **'Kateqoriya Endirimlər'**
  String get categoryDiscounts;

  /// No description provided for @nutella400g.
  ///
  /// In az, this message translates to:
  /// **'Nutella 400q'**
  String get nutella400g;

  /// No description provided for @cocaCola2L.
  ///
  /// In az, this message translates to:
  /// **'Coca Cola 2L'**
  String get cocaCola2L;

  /// No description provided for @oreoCookies.
  ///
  /// In az, this message translates to:
  /// **'Oreo Peçenye'**
  String get oreoCookies;

  /// No description provided for @buy2Get1Free.
  ///
  /// In az, this message translates to:
  /// **'2 al 1 PULSUZ'**
  String get buy2Get1Free;

  /// No description provided for @onAllDairyProducts.
  ///
  /// In az, this message translates to:
  /// **'Bütün süd məhsullarında'**
  String get onAllDairyProducts;

  /// No description provided for @fiftyPercentOff.
  ///
  /// In az, this message translates to:
  /// **'50% ENDİRİM'**
  String get fiftyPercentOff;

  /// No description provided for @weekendSpecialDeals.
  ///
  /// In az, this message translates to:
  /// **'Həftəsonu xüsusi təkliflər'**
  String get weekendSpecialDeals;

  /// No description provided for @freeDelivery.
  ///
  /// In az, this message translates to:
  /// **'Pulsuz Çatdırılma'**
  String get freeDelivery;

  /// No description provided for @ordersAbove25.
  ///
  /// In az, this message translates to:
  /// **'25\$-dan yuxarı sifarişlər'**
  String get ordersAbove25;

  /// No description provided for @groceries.
  ///
  /// In az, this message translates to:
  /// **'Ərzaq məhsulları'**
  String get groceries;

  /// No description provided for @personalCare.
  ///
  /// In az, this message translates to:
  /// **'Şəxsi qayğı'**
  String get personalCare;

  /// No description provided for @household.
  ///
  /// In az, this message translates to:
  /// **'Ev əşyaları'**
  String get household;

  /// No description provided for @babyProducts.
  ///
  /// In az, this message translates to:
  /// **'Uşaq məhsulları'**
  String get babyProducts;

  /// No description provided for @items.
  ///
  /// In az, this message translates to:
  /// **'məhsul'**
  String get items;

  /// No description provided for @off.
  ///
  /// In az, this message translates to:
  /// **'ENDİRİM'**
  String get off;

  /// No description provided for @scanToAddProducts.
  ///
  /// In az, this message translates to:
  /// **'Məhsul əlavə etmək üçün skan edin'**
  String get scanToAddProducts;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['az', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az':
      return AppLocalizationsAz();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
