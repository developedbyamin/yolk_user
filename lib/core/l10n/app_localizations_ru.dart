// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get logIn => 'Войти';

  @override
  String get fillTheForm =>
      'Заполните форму, чтобы войти в аккаунт и начать покупки!';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get doNotHaveAccount => 'Нет аккаунта?';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get sendCode => 'Отправить код';

  @override
  String get or => 'Или';

  @override
  String get confirmationOTP => 'Подтверждение OTP';

  @override
  String phoneOTP(Object number) {
    return 'Одноразовый пароль отправлен на номер $number';
  }

  @override
  String get didNotReceiveCode => 'Не получили код?';

  @override
  String get sendAgain => 'Отправить снова';

  @override
  String get continueApp => 'Продолжить';

  @override
  String get qr => 'QR';

  @override
  String get sale => 'Discount';

  @override
  String get history => 'История';

  @override
  String get profile => 'Профиль';

  @override
  String get username => 'Имя пользователя';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Уведомления';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get settings => 'Настройки';

  @override
  String get personalInformation => 'Личная информация';

  @override
  String get preferences => 'Предпочтения';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get pushNotifications => 'Push уведомления';

  @override
  String get emailNotifications => 'Email уведомления';

  @override
  String get smsNotifications => 'SMS уведомления';

  @override
  String get english => 'Английский';

  @override
  String get azerbaijani => 'Азербайджанский';

  @override
  String get russian => 'Русский';

  @override
  String get scanInstruction =>
      'Расположите QR-код или штрихкод в рамке для сканирования';

  @override
  String get scanningDisabled =>
      'Сканирование отключено - Закройте список товаров для продолжения';

  @override
  String get selectProducts => 'Выберите товары';

  @override
  String get totalPrice => 'Общая стоимость:';

  @override
  String get addProduct => 'Добавить товар';

  @override
  String get checkout => 'Оформить заказ';

  @override
  String get pleaseAddProducts =>
      'Пожалуйста, добавьте товары перед оформлением заказа';

  @override
  String get noProductsSelected => 'Товары не выбраны';

  @override
  String get deliveryDetails => 'Детали доставки';

  @override
  String get selectDate => 'Выберите дату';

  @override
  String get selectTime => 'Выберите время';

  @override
  String get pay => 'Оплатить';

  @override
  String get orderPlacedSuccessfully => 'Заказ успешно размещен!';

  @override
  String get orderConfirmation => 'Подтверждение заказа';

  @override
  String orderConfirmationText(Object count) {
    return 'Вы собираетесь разместить заказ на $count товаров.';
  }

  @override
  String get total => 'Итого:';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirmOrder => 'Подтвердить заказ';

  @override
  String get logout => 'Выйти';

  @override
  String get logoutConfirmation => 'Вы уверены, что хотите выйти?';

  @override
  String get logoutDescription =>
      'Вы выйдете из аккаунта и вернетесь на экран входа.';

  @override
  String get change => 'Изменить';

  @override
  String get chooseProfilePicture => 'Выберите фото профиля';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get phoneNumberRequired => 'Введите действительный номер телефона';

  @override
  String get phoneNumberIncomplete =>
      'Пожалуйста, введите полный номер телефона';

  @override
  String get pcs => 'шт';

  @override
  String get kg => 'кг';

  @override
  String get each => 'за шт';

  @override
  String get totalAmount => 'итого';

  @override
  String get details => 'Подробности';

  @override
  String get pending => 'В ожидании';

  @override
  String get delivered => 'Доставлено';

  @override
  String get editUsername => 'Редактировать имя пользователя';

  @override
  String get editPhoneNumber => 'Редактировать номер телефона';

  @override
  String get save => 'Сохранить';

  @override
  String get usernameRequired => 'Имя пользователя обязательно';

  @override
  String get limitedTimeOnly => 'Только ограниченное время!';

  @override
  String get dontMissOut => 'Не пропустите!';

  @override
  String get saveOnFavorites => 'Скидки на любимое';

  @override
  String get megaSale => 'МЕГА РАСПРОДАЖА';

  @override
  String get upToPercentOff => 'Скидки до 70%';

  @override
  String get shopNow => 'Покупать сейчас';

  @override
  String get foodDrinks => 'Еда и Напитки';

  @override
  String get electronics => 'Электроника';

  @override
  String get beauty => 'Красота';

  @override
  String get home => 'Дом';

  @override
  String get flashSales => 'Молниеносные Скидки';

  @override
  String get popularDiscounts => 'Популярные Скидки';

  @override
  String get categoryDiscounts => 'Скидки по Категориям';

  @override
  String get nutella400g => 'Nutella 400г';

  @override
  String get cocaCola2L => 'Coca Cola 2Л';

  @override
  String get oreoCookies => 'Печенье Oreo';

  @override
  String get buy2Get1Free => 'Купи 2 Получи 1 БЕСПЛАТНО';

  @override
  String get onAllDairyProducts => 'На все молочные продукты';

  @override
  String get fiftyPercentOff => '50% СКИДКА';

  @override
  String get weekendSpecialDeals => 'Специальные предложения выходных';

  @override
  String get freeDelivery => 'Бесплатная Доставка';

  @override
  String get ordersAbove25 => 'При заказе от \$25';

  @override
  String get groceries => 'Продукты';

  @override
  String get personalCare => 'Личная Гигиена';

  @override
  String get household => 'Хозяйственные Товары';

  @override
  String get babyProducts => 'Детские Товары';

  @override
  String get items => 'товаров';

  @override
  String get off => 'СКИДКА';

  @override
  String get scanToAddProducts => 'Сканируйте, чтобы добавить товары';

  @override
  String get item => 'товар';

  @override
  String get quantity => 'Кол';

  @override
  String get addToCart => 'Добавить в корзину';

  @override
  String get itemsAddedToCart => 'товаров добавлено в корзину';

  @override
  String get removeFromCart => 'Удалить из корзины';

  @override
  String get removeFromCartConfirmation =>
      'Вы уверены, что хотите удалить этот заказ из корзины?';

  @override
  String get orderRemovedFromCart => 'Заказ удалён из корзины';

  @override
  String get remove => 'Удалить';

  @override
  String get deliveryTimeRange => 'Диапазон времени доставки';

  @override
  String get fromDate => 'С';

  @override
  String get toDate => 'До';

  @override
  String get selectStartDate => 'Выберите дату начала';

  @override
  String get selectEndDate => 'Выберите дату окончания';

  @override
  String get selectStartTime => 'Выберите время начала';

  @override
  String get selectEndTime => 'Выберите время окончания';

  @override
  String get deliveryWindow => 'Окно доставки';

  @override
  String get between => 'между';

  @override
  String get and => 'и';

  @override
  String get youCanDeliverBetween =>
      'Вы можете доставить мой заказ между этими датами';
}
