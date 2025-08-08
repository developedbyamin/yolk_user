// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get logIn => 'Daxil ol';

  @override
  String get fillTheForm =>
      'Hesabınıza daxil olmaq və alış-verişə başlamaq üçün formu doldurun!';

  @override
  String get phoneNumber => 'Telefon nömrəsi';

  @override
  String get forgotPassword => 'Şifrəni unutmusunuz?';

  @override
  String get doNotHaveAccount => 'Hesabınız yoxdur?';

  @override
  String get createAccount => 'Hesab yarat';

  @override
  String get sendCode => 'Kodu göndər';

  @override
  String get or => 'Və ya';

  @override
  String get confirmationOTP => 'OTP Təsdiqi';

  @override
  String phoneOTP(Object number) {
    return '$number nömrəsinə birdəfəlik şifrə göndərildi';
  }

  @override
  String get didNotReceiveCode => 'Kod gəlməyib?';

  @override
  String get sendAgain => 'Təkrar göndər';

  @override
  String get continueApp => 'Davam et';

  @override
  String get qr => 'QR';

  @override
  String get sale => 'Endirim';

  @override
  String get history => 'Tarixçə';

  @override
  String get profile => 'Hesab';

  @override
  String get username => 'İstifadəçi adı';

  @override
  String get language => 'Dil';

  @override
  String get notifications => 'Bildirişlər';

  @override
  String get editProfile => 'Profili redaktə et';

  @override
  String get settings => 'Tənzimləmələr';

  @override
  String get personalInformation => 'Şəxsi məlumatlar';

  @override
  String get preferences => 'Seçimlər';

  @override
  String get selectLanguage => 'Dil seçin';

  @override
  String get pushNotifications => 'Push bildirişləri';

  @override
  String get emailNotifications => 'E-mail bildirişləri';

  @override
  String get smsNotifications => 'SMS bildirişləri';

  @override
  String get english => 'İngiliscə';

  @override
  String get azerbaijani => 'Azərbaycanca';

  @override
  String get russian => 'Rusca';

  @override
  String get scanInstruction =>
      'QR kodu və ya barkodu skan etmək üçün çərçivə daxilində yerləşdirin';

  @override
  String get scanningDisabled =>
      'Skan deaktivdir - Davam etmək üçün məhsul siyahısını bağlayın';

  @override
  String get selectProducts => 'Məhsulları seçin';

  @override
  String get totalPrice => 'Ümumi qiymət:';

  @override
  String get addProduct => 'Məhsul əlavə et';

  @override
  String get checkout => 'Ödəniş';

  @override
  String get pleaseAddProducts => 'Ödənişdən əvvəl bəzi məhsullar əlavə edin';

  @override
  String get noProductsSelected => 'Heç bir məhsul seçilməyib';

  @override
  String get deliveryDetails => 'Çatdırılma təfərrüatları';

  @override
  String get selectDate => 'Tarix seçin';

  @override
  String get selectTime => 'Vaxt seçin';

  @override
  String get pay => 'Ödə';

  @override
  String get orderPlacedSuccessfully => 'Sifariş uğurla yerləşdirildi!';

  @override
  String get orderConfirmation => 'Sifariş təsdiqi';

  @override
  String orderConfirmationText(Object count) {
    return '$count məhsul üçün sifariş verməkdəsiniz.';
  }

  @override
  String get total => 'Cəmi:';

  @override
  String get cancel => 'Ləğv et';

  @override
  String get confirmOrder => 'Sifarişi təsdiqlə';

  @override
  String get logout => 'Çıxış';

  @override
  String get logoutConfirmation => 'Çıxış etmək istədiyinizdən əminsiniz?';

  @override
  String get logoutDescription =>
      'Hesabınızdan çıxacaqsınız və giriş ekranına qaytarılacaqsınız.';

  @override
  String get change => 'Dəyişdir';

  @override
  String get chooseProfilePicture => 'Profil şəkli seçin';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Qalereya';

  @override
  String get phoneNumberRequired => 'Düzgün telefon nömrəsi daxil edin';

  @override
  String get phoneNumberIncomplete =>
      'Zəhmət olmasa tam telefon nömrəsini daxil edin';

  @override
  String get pcs => 'ədəd';

  @override
  String get kg => 'kq';

  @override
  String get each => 'hər biri';

  @override
  String get totalAmount => 'cəmi';

  @override
  String get details => 'Təfərrüatlar';

  @override
  String get pending => 'Gözləyən';

  @override
  String get delivered => 'Çatdırılıb';

  @override
  String get editUsername => 'İstifadəçi adını redaktə et';

  @override
  String get editPhoneNumber => 'Telefon nömrəsini redaktə et';

  @override
  String get save => 'Saxla';

  @override
  String get usernameRequired => 'İstifadəçi adı tələb olunur';

  @override
  String get limitedTimeOnly => 'Yalnız məhdud müddət!';

  @override
  String get dontMissOut => 'Qaçırmayın!';

  @override
  String get saveOnFavorites => 'Sevimlilərinizə qənaət edin';

  @override
  String get megaSale => 'MEGA ENDİRİM';

  @override
  String get upToPercentOff => '70%-ə qədər ENDİRİM';

  @override
  String get shopNow => 'İndi alış-veriş edin';

  @override
  String get foodDrinks => 'Yemək və İçki';

  @override
  String get electronics => 'Elektronika';

  @override
  String get beauty => 'Gözəllik';

  @override
  String get home => 'Ev';

  @override
  String get flashSales => 'Sürətli Satışlar';

  @override
  String get popularDiscounts => 'Populyar Endirimlər';

  @override
  String get categoryDiscounts => 'Kateqoriya Endirimlər';

  @override
  String get nutella400g => 'Nutella 400q';

  @override
  String get cocaCola2L => 'Coca Cola 2L';

  @override
  String get oreoCookies => 'Oreo Peçenye';

  @override
  String get buy2Get1Free => '2 al 1 PULSUZ';

  @override
  String get onAllDairyProducts => 'Bütün süd məhsullarında';

  @override
  String get fiftyPercentOff => '50% ENDİRİM';

  @override
  String get weekendSpecialDeals => 'Həftəsonu xüsusi təkliflər';

  @override
  String get freeDelivery => 'Pulsuz Çatdırılma';

  @override
  String get ordersAbove25 => '25\$-dan yuxarı sifarişlər';

  @override
  String get groceries => 'Ərzaq məhsulları';

  @override
  String get personalCare => 'Şəxsi qayğı';

  @override
  String get household => 'Ev əşyaları';

  @override
  String get babyProducts => 'Uşaq məhsulları';

  @override
  String get items => 'məhsul';

  @override
  String get off => 'ENDİRİM';

  @override
  String get scanToAddProducts => 'Məhsul əlavə etmək üçün skan edin';
}
