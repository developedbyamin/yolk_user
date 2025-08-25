// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get logIn => 'Log in';

  @override
  String get fillTheForm =>
      'Fill the form to log in your account and start shopping!';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get doNotHaveAccount => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create account';

  @override
  String get sendCode => 'Send code';

  @override
  String get or => 'Or';

  @override
  String get confirmationOTP => 'Confirmation OTP';

  @override
  String phoneOTP(Object number) {
    return 'A one-time password has been sent to the number $number';
  }

  @override
  String get didNotReceiveCode => 'Didn\'t receive code?';

  @override
  String get sendAgain => 'Send again';

  @override
  String get continueApp => 'Continue';

  @override
  String get qr => 'QR';

  @override
  String get sale => 'Discount';

  @override
  String get history => 'History';

  @override
  String get profile => 'Profile';

  @override
  String get username => 'Username';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get settings => 'Settings';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get preferences => 'Preferences';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get smsNotifications => 'SMS Notifications';

  @override
  String get english => 'English';

  @override
  String get azerbaijani => 'Azerbaijani';

  @override
  String get russian => 'Russian';

  @override
  String get scanInstruction =>
      'Position the QR code or barcode within the frame to scan';

  @override
  String get scanningDisabled =>
      'Scanning disabled - Close product list to continue';

  @override
  String get selectProducts => 'Select Products';

  @override
  String get totalPrice => 'Total Price:';

  @override
  String get addProduct => 'Add Product';

  @override
  String get checkout => 'Checkout';

  @override
  String get pleaseAddProducts => 'Please add some products before checkout';

  @override
  String get noProductsSelected => 'No products selected';

  @override
  String get deliveryDetails => 'Delivery Details';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get pay => 'Pay';

  @override
  String get orderPlacedSuccessfully => 'Order placed successfully!';

  @override
  String get orderConfirmation => 'Order Confirmation';

  @override
  String orderConfirmationText(Object count) {
    return 'You are about to place an order for $count products.';
  }

  @override
  String get total => 'Total:';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get logoutDescription =>
      'You will be signed out and returned to the login screen.';

  @override
  String get change => 'Change';

  @override
  String get chooseProfilePicture => 'Choose Profile Picture';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get phoneNumberRequired => 'Please enter a valid phone number';

  @override
  String get phoneNumberIncomplete => 'Please enter a complete phone number';

  @override
  String get pcs => 'pcs';

  @override
  String get kg => 'kg';

  @override
  String get each => 'each';

  @override
  String get totalAmount => 'total';

  @override
  String get details => 'Details';

  @override
  String get pending => 'Pending';

  @override
  String get delivered => 'Delivered';

  @override
  String get editUsername => 'Edit Username';

  @override
  String get editPhoneNumber => 'Edit Phone Number';

  @override
  String get save => 'Save';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get limitedTimeOnly => 'Limited time only!';

  @override
  String get dontMissOut => 'Don\'t miss out!';

  @override
  String get saveOnFavorites => 'Save on your favorites';

  @override
  String get megaSale => 'MEGA SALE';

  @override
  String get upToPercentOff => 'Up to 70% OFF';

  @override
  String get shopNow => 'Shop Now';

  @override
  String get foodDrinks => 'Food & Drinks';

  @override
  String get electronics => 'Electronics';

  @override
  String get beauty => 'Beauty';

  @override
  String get home => 'Home';

  @override
  String get flashSales => 'Flash Sales';

  @override
  String get popularDiscounts => 'Popular Discounts';

  @override
  String get categoryDiscounts => 'Category Discounts';

  @override
  String get nutella400g => 'Nutella 400g';

  @override
  String get cocaCola2L => 'Coca Cola 2L';

  @override
  String get oreoCookies => 'Oreo Cookies';

  @override
  String get buy2Get1Free => 'Buy 2 Get 1 FREE';

  @override
  String get onAllDairyProducts => 'On all dairy products';

  @override
  String get fiftyPercentOff => '50% OFF';

  @override
  String get weekendSpecialDeals => 'Weekend special deals';

  @override
  String get freeDelivery => 'Free Delivery';

  @override
  String get ordersAbove25 => 'Orders above \$25';

  @override
  String get groceries => 'Groceries';

  @override
  String get personalCare => 'Personal Care';

  @override
  String get household => 'Household';

  @override
  String get babyProducts => 'Baby Products';

  @override
  String get items => 'items';

  @override
  String get off => 'OFF';

  @override
  String get scanToAddProducts => 'Scan to add products';

  @override
  String get item => 'item';

  @override
  String get quantity => 'Qty';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get itemsAddedToCart => 'items added to cart';

  @override
  String get removeFromCart => 'Remove from Cart';

  @override
  String get removeFromCartConfirmation =>
      'Are you sure you want to remove this order from your cart?';

  @override
  String get orderRemovedFromCart => 'Order removed from cart';

  @override
  String get remove => 'Remove';

  @override
  String get deliveryTimeRange => 'Delivery Time Range';

  @override
  String get fromDate => 'From';

  @override
  String get toDate => 'To';

  @override
  String get selectStartDate => 'Select Start Date';

  @override
  String get selectEndDate => 'Select End Date';

  @override
  String get selectStartTime => 'Select Start Time';

  @override
  String get selectEndTime => 'Select End Time';

  @override
  String get deliveryWindow => 'Delivery Window';

  @override
  String get between => 'between';

  @override
  String get and => 'and';

  @override
  String get youCanDeliverBetween =>
      'You can deliver my order between these dates';
}
