import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['kk', 'ru'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? kkText = '',
    String? ruText = '',
  }) =>
      [kkText, ruText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // sign_in
  {
    'feu0q8jz': {
      'kk': 'Қош келдіңіз!',
      'ru': 'Добро пожаловать!',
    },
    'fy4ypvd5': {
      'kk': 'Төменге электронды поштаңызды және құпия сөзді жазыңыз',
      'ru': 'Введите свой адрес электронной почты и пароль ниже',
    },
    'pjfy0syk': {
      'kk': 'Электронды почтаңыз',
      'ru': 'Ваш электронный адрес',
    },
    'iamkiafu': {
      'kk': 'tonykok@gmail.com',
      'ru': 'tonykok@gmail.com',
    },
    'kushptlh': {
      'kk': 'Құпия сөз',
      'ru': 'Пароль',
    },
    '7786cg5h': {
      'kk': 'qwerty123',
      'ru': 'qwerty123',
    },
    'rqhm0e2m': {
      'kk': 'Кіру',
      'ru': 'Войти',
    },
    'kg1vr128': {
      'kk': 'Төмендегі сервистер арқылы кіре аласыз',
      'ru': 'Вы можете войти через следующие сервисы',
    },
    'vqveft7s': {
      'kk': 'Google',
      'ru': 'Google',
    },
    'vp7j1qmi': {
      'kk': 'Телефон номер',
      'ru': 'Номер телефона',
    },
    'nq8ib58f': {
      'kk': 'Аккаунт әлі жоқ па?',
      'ru': 'У вас еще нет учетной записи?',
    },
    'scu5ktih': {
      'kk': 'Тіркелу',
      'ru': 'Постановка на учет',
    },
    'lmk6t47n': {
      'kk': 'Құпия сөзді ұмыттыңыз ба?',
      'ru': '',
    },
    'w10royt5': {
      'kk': 'Home',
      'ru': 'Дом',
    },
  },
  // sign_up
  {
    'x3eqpbvc': {
      'kk': 'Тіркелу',
      'ru': 'Постановка на учет',
    },
    'ea5li4nx': {
      'kk': 'Төменге электронды поштаңыз бен құпия сөзді жазып тіркеліңіз!',
      'ru':
          'Введите свой адрес электронной почты и пароль ниже и зарегистрируйтесь!',
    },
    'sqfupas2': {
      'kk': 'Электронды почтаңыз',
      'ru': 'Ваш электронный адрес',
    },
    'ud5jf81l': {
      'kk': 'user_name@gmail.com',
      'ru': 'tonykok@gmail.com',
    },
    'v7tttoia': {
      'kk': 'Құпия сөз',
      'ru': 'Пароль',
    },
    'lisq2dyd': {
      'kk': 'qwerty123',
      'ru': 'qwerty123',
    },
    'sbq2y6ud': {
      'kk': 'Құпия сөзді қайталаңыз',
      'ru': 'Повторите пароль',
    },
    'tatpcsvg': {
      'kk': 'qwerty123',
      'ru': 'qwerty123',
    },
    'wjfad40b': {
      'kk': 'Тіркелу',
      'ru': 'Вход',
    },
    '2djg56ya': {
      'kk': 'Басқа сервистерді қолданып көріңіз',
      'ru': 'Попробуйте другие сервисы',
    },
    'i1jw27sj': {
      'kk': 'Google',
      'ru': 'Google',
    },
    'jkpvft7m': {
      'kk': 'Телефон номер',
      'ru': 'Номер телефона',
    },
    'lzi8duym': {
      'kk': 'Сізде аккаунт бар ма?',
      'ru': 'У тебя есть аккаунт?',
    },
    'tgz8bjvv': {
      'kk': 'Кіру',
      'ru': 'Вход',
    },
    'kyo7eh5v': {
      'kk': 'Home',
      'ru': 'Дом',
    },
  },
  // homePage
  {
    'a0rqmru7': {
      'kk': 'Төмен бағада крипто сатып алыңыз',
      'ru': 'Покупайте криптовалюту по низким ценам',
    },
    'ymhjc0c9': {
      'kk':
          'Бар болғаны 0.9% төлеу арқылы, қауіпсіз крипто теңгерімге ие болу!',
      'ru': 'Получите безопасный криптовалютный баланс, заплатив всего 0,9%!',
    },
    'hgx0dwk3': {
      'kk': '1 ETH=',
      'ru': '1 ЭТИН =',
    },
    'iltlwck1': {
      'kk': '0.23%',
      'ru': '0,23%',
    },
    'pb1fel0s': {
      'kk': 'Жіберу',
      'ru': 'Отправить',
    },
    '6n4vbj0g': {
      'kk': 'Сатып алу',
      'ru': 'Купить',
    },
    'rlzkwjww': {
      'kk': '\$ TOKENS',
      'ru': '\$ ТОКЕНЫ',
    },
    'gd30428q': {
      'kk': 'TOKEN',
      'ru': 'ТОКЕН',
    },
    'cibrrgtu': {
      'kk': 'PRICE',
      'ru': 'ЦЕНА',
    },
    'nsjnt3zm': {
      'kk': '24H',
      'ru': '24 часа',
    },
    'ggvvfpm1': {
      'kk': 'BANLANCE',
      'ru': 'БАЛАНС',
    },
    '6w51nuhz': {
      'kk': 'SWAP',
      'ru': 'МЕНЯТЬ',
    },
    'xddbk92n': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'jmk58797': {
      'kk': 'Active',
      'ru': 'Активный',
    },
    'sff4wj9q': {
      'kk': 'Custom Name',
      'ru': 'Пользовательское имя',
    },
    'nfc0yjjy': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'nzy7wcxd': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'f2mlrab1': {
      'kk': 'Active',
      'ru': 'Активный',
    },
    '0pw56sd2': {
      'kk': 'Custom Name',
      'ru': 'Пользовательское имя',
    },
    'fkqexkt3': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'm72omgj2': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'vr4472x2': {
      'kk': 'Active',
      'ru': 'Активный',
    },
    'qv97raft': {
      'kk': 'Custom Name',
      'ru': 'Пользовательское имя',
    },
    'f11zdhp2': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'xgfw05te': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    '7nc0ztli': {
      'kk': 'Active',
      'ru': 'Активный',
    },
    '9re668m8': {
      'kk': 'Custom Name',
      'ru': 'Пользовательское имя',
    },
    'p3hj2s7n': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'dinwvbmh': {
      'kk': 'user@domainname.com',
      'ru': 'пользователь@имя_домена.com',
    },
    'ogpkixds': {
      'kk': 'Active',
      'ru': 'Активный',
    },
    'bqr2t184': {
      'kk': '•',
      'ru': '•',
    },
  },
  // createProfile
  {
    'b46gafpy': {
      'kk': 'Профильді өңдеу',
      'ru': 'Редактировать профиль',
    },
    'grbr3a0e': {
      'kk': 'Есіміңіз',
      'ru': 'Ваше имя',
    },
    'om1z6sjl': {
      'kk': 'Телефон нөміріңіз',
      'ru': 'Ваш номер телефона',
    },
    'xknsjbr0': {
      'kk': '',
      'ru': 'Астана',
    },
    'qsxeclvi': {
      'kk': 'Астана',
      'ru': 'Астана',
    },
    'krfsjf92': {
      'kk': 'Алматы',
      'ru': 'Алматы',
    },
    'oiu27v53': {
      'kk': 'Шымкент',
      'ru': 'Шымкент',
    },
    'i8o8gpay': {
      'kk': 'Қызылорда',
      'ru': 'Кызылорда',
    },
    'gqfgkx6y': {
      'kk': 'Талдықорған',
      'ru': 'Талдыкорган',
    },
    'gk99dqv9': {
      'kk': 'Ақтөбе',
      'ru': 'Актобе',
    },
    'xw7tt7gm': {
      'kk': 'Атырау',
      'ru': 'Атырау',
    },
    'ojsngzx5': {
      'kk': 'Семей',
      'ru': 'Семей',
    },
    'j3u8o3o5': {
      'kk': 'Өскемен',
      'ru': 'Устькемен',
    },
    '2rlwpsvn': {
      'kk': 'Ақтау',
      'ru': 'Оправдывать',
    },
    'w04t4e9u': {
      'kk': 'Тараз',
      'ru': 'Тараз',
    },
    'lmn57re5': {
      'kk': 'Қарағанды',
      'ru': 'Караганда',
    },
    'bhcup5lt': {
      'kk': 'Қостанай',
      'ru': 'Костанай',
    },
    'divj6djj': {
      'kk': 'Түркістан',
      'ru': 'Туркестан',
    },
    'rmfudmpp': {
      'kk': 'Павлодар',
      'ru': 'Павлодар',
    },
    'b9a1wce8': {
      'kk': 'Петропавл',
      'ru': 'Петропавловск',
    },
    'kmf7ifnf': {
      'kk': 'Жезқазған',
      'ru': 'Жезказган',
    },
    'ihpk9ilo': {
      'kk': 'Орал',
      'ru': 'Урал',
    },
    '3hp9h7df': {
      'kk': 'Көкшетау',
      'ru': 'Кокшетау',
    },
    'ldz5cksi': {
      'kk': 'Қалаңыз',
      'ru': 'Пожалуйста',
    },
    'mia9m561': {
      'kk': 'Қосымша',
      'ru': 'добавить',
    },
    'y3lhonpx': {
      'kk': 'Сақтау',
      'ru': 'Сохранять',
    },
    'nqfkuk5b': {
      'kk': 'Жеке аккаунт құру',
      'ru': 'Персональный аккаунт',
    },
  },
  // forgotPassword
  {
    '3ngoq363': {
      'kk': 'Құпия сөзді қалпына келтіру',
      'ru': 'Восстановление пароля',
    },
    '1dc515u2': {
      'kk': 'Құпия сөзді ұмыттым',
      'ru': 'Я забыл свой пароль',
    },
    '5z5sgyhz': {
      'kk':
          'Құпия сөзді қалпына келтіру үшін тіркелген электронды поштаңызды төменге енгізіңіз. Одан кейін енгізілген поштаға біз қалпына келтіру сілтемесін жібереміз! Сол сілтемеге өтіп қайтадан қалпына келтіре аласыз',
      'ru':
          'Введите зарегистрированный адрес электронной почты ниже, чтобы сбросить пароль. Затем мы отправим ссылку для восстановления на указанный вами адрес электронной почты! Вы можете восстановить его снова, перейдя по этой ссылке.',
    },
    'rjdijhkl': {
      'kk': 'Поштаңыз',
      'ru': 'Опубликовать это',
    },
    't6efxg08': {
      'kk': 'Тіркелген поштаңызды енгізіңіз',
      'ru': 'Введите зарегистрированный адрес электронной почты',
    },
    'i7tw794u': {
      'kk': 'Сілтеме жіберу',
      'ru': 'Отправить ссылку',
    },
    'eesq5iyi': {
      'kk': 'Home',
      'ru': 'Дом',
    },
  },
  // profilePage
  {
    '68cb0e10': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
    '7mkexqwk': {
      'kk': 'Профильіңіздің дұрыс толтырылғанына көз жеткізіңіз! ',
      'ru': 'Убедитесь, что ваш профиль заполнен правильно!',
    },
    'd87z0wm5': {
      'kk': 'Шығу',
      'ru': 'Выйти',
    },
    '9lmry7v1': {
      'kk': 'Аккаунт',
      'ru': 'Счет',
    },
    'vmbzmetd': {
      'kk': 'Switch to Dark Mode',
      'ru': 'Переключиться в темный режим',
    },
    'krd16o4v': {
      'kk': 'Switch to Light Mode',
      'ru': 'Переключиться в светлый режим',
    },
    'ys6w04dk': {
      'kk': 'Тіл',
      'ru': 'Язык',
    },
    'v4k85rr8': {
      'kk': 'Премиум профиль',
      'ru': 'Премиум-профиль',
    },
    'zdjm44mz': {
      'kk': 'Қосымша',
      'ru': 'добавить',
    },
    'qo8shc2j': {
      'kk': 'Көмек',
      'ru': 'Помощь',
    },
    'kk9ppnww': {
      'kk': 'Қолдану нұсқаулығы',
      'ru': 'Руководство пользователя',
    },
    'w1qnchdd': {
      'kk': 'Достармен бөлісу',
      'ru': 'Поделиться с друзьями',
    },
    'srq6vhvr': {
      'kk': '•',
      'ru': '•',
    },
  },
  // paymentpage
  {
    'm7rrtkym': {
      'kk': 'Сақтау',
      'ru': '',
    },
    'niobr27f': {
      'kk': 'Балансты толтыру',
      'ru': '',
    },
    '86pck7kf': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // pricepaymenpage
  {
    'jqydclzj': {
      'kk':
          'Жұмысты бастау үшін балансты өзіңіз қалаған валюта \nтүрімен толтырыңыз',
      'ru': '',
    },
    'd1k1ohzi': {
      'kk': '\$',
      'ru': '',
    },
    'zh1edhzt': {
      'kk': '£',
      'ru': '',
    },
    'b29vmhma': {
      'kk': 'R',
      'ru': '',
    },
    'hebmmpw9': {
      'kk': 'T',
      'ru': '',
    },
    '8tdiyktj': {
      'kk': 'Валюта түрі',
      'ru': '',
    },
    '4zeszigb': {
      'kk': 'Search for an item...',
      'ru': '',
    },
    'qjsef7gh': {
      'kk': '300.000',
      'ru': '',
    },
    'im0l646s': {
      'kk': 'Келесі',
      'ru': '',
    },
    'h8ednbhe': {
      'kk': 'Балансты толтыру',
      'ru': '',
    },
    '2px3fljg': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // welcomepage
  {
    'hcs5m13c': {
      'kk': 'Қош келдіңіз',
      'ru': '',
    },
    'sikstcgn': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // doesnotexistpage
  {
    'wgtdrcz4': {
      'kk': 'Сіз аккаунтқа тіркелмегенсіз!',
      'ru': 'Вы не авторизованы!',
    },
    'vdnt3x5l': {
      'kk':
          'Платформаны толық қолдану үшін аккаунтқа кіріңіз немесе тіркеліңіз!',
      'ru':
          'Войдите или зарегистрируйтесь, чтобы полноценно использовать платформу!',
    },
    'e3dkbpj6': {
      'kk': 'Кіру',
      'ru': 'Вход',
    },
    'jhx7h8xf': {
      'kk': 'Тіркелу',
      'ru': 'Регистрация',
    },
    'tjty8ef0': {
      'kk': 'Home',
      'ru': 'Дом',
    },
  },
  // statistics
  {
    'ofetfh4j': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // sendmoney
  {
    'rv74dqmm': {
      'kk': 'Жеке шот',
      'ru': 'Персональный счет',
    },
    '8imrtnn4': {
      'kk': 'Төменде жеке есеп шоттар көрсетілген',
      'ru': 'Индивидуальные аккаунты перечислены ниже',
    },
    'l1qsj2zv': {
      'kk': 'admin@gmail.com',
      'ru': '',
    },
    'woqi6x87': {
      'kk': 'Жалпы аударым',
      'ru': 'Общий трансфер',
    },
    'iovw285n': {
      'kk': '\$567,402',
      'ru': '\$567,402',
    },
    'qwf0tzi6': {
      'kk': 'Айлық аударым',
      'ru': 'Ежемесячный перевод',
    },
    'of80l4m4': {
      'kk': '2,208',
      'ru': '2,208',
    },
    'npstmfzu': {
      'kk': 'Күндік аударым',
      'ru': 'Ежедневный трансфер',
    },
    'ca3ry2dz': {
      'kk': '2,208',
      'ru': '2,208',
    },
    'w3cbs5xi': {
      'kk': 'Орташа сумма',
      'ru': 'Среднее количество',
    },
    '0ted0fh8': {
      'kk': '2,208',
      'ru': '',
    },
    '0wrjjh1t': {
      'kk': 'Жеке есеп шот',
      'ru': 'Персональный аккаунт',
    },
    'm2q12x10': {
      'kk': 'Сіздің балансыңыз',
      'ru': 'Ваш баланс',
    },
    '3s2454bo': {
      'kk': 'Толтыру',
      'ru': 'Наполнять',
    },
    'dga9a38h': {
      'kk': 'Айлық мақсат',
      'ru': '',
    },
    'ebww901z': {
      'kk': '12.2% /',
      'ru': '12.2% /',
    },
    '6ld7ix5q': {
      'kk': ' \$7,000',
      'ru': ' \$7,000',
    },
    'ksbpmgk2': {
      'kk': 'Болжамды сумма',
      'ru': 'Ориентировочная сумма',
    },
    'ue40gy8b': {
      'kk': '\$3,502',
      'ru': '\$3,502',
    },
    'zerhnxgi': {
      'kk': 'Топ крипто',
      'ru': '',
    },
    '0bw8oi8v': {
      'kk': 'Bitcoin',
      'ru': 'Bitcoin',
    },
    'wnq30hhz': {
      'kk': '1',
      'ru': '1',
    },
    '02gr38q9': {
      'kk': 'Ethereum',
      'ru': 'Ethereum',
    },
    'ozruffyb': {
      'kk': '2',
      'ru': '2',
    },
    'evbld4wl': {
      'kk': 'Trust Wallet',
      'ru': 'Trust Wallet',
    },
    'e1r5fbd2': {
      'kk': '3',
      'ru': '3',
    },
    '2i7xn6xq': {
      'kk': 'Binary X',
      'ru': 'Binary X',
    },
    'wifgjmjc': {
      'kk': '4',
      'ru': '',
    },
    'z9egj7y1': {
      'kk': 'Толтырылған баланс',
      'ru': 'Завершенный баланс',
    },
    'reonrwx5': {
      'kk': '\$529,204',
      'ru': '',
    },
    'vq6z58lb': {
      'kk': '55%',
      'ru': '',
    },
    '12e3skij': {
      'kk': 'Шығарылған баланс',
      'ru': 'Выпущенный остаток',
    },
    'caseb6qq': {
      'kk': '\$242,102',
      'ru': '',
    },
    '114s4455': {
      'kk': '25%',
      'ru': '',
    },
    'k5dhzxci': {
      'kk': 'Әрекеттер тарихы',
      'ru': 'История активности',
    },
    'r2zkwfqb': {
      'kk': 'Төменде сіздің жақындарыңызбен бөліскен суммаларыңыз көрсетілген',
      'ru': 'Ниже указаны суммы, которыми вы поделились со своими близкими.',
    },
    'bn4hprej': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    '7w883947': {
      'kk': 'Статус',
      'ru': 'Статус',
    },
    'bze6fkj2': {
      'kk': 'Жіберілді',
      'ru': 'Отправил',
    },
    'xdt4g25x': {
      'kk': 'Сумма мөлшері',
      'ru': 'Сумма сумма',
    },
    'asagbt96': {
      'kk': 'Деңгей',
      'ru': 'Уровень',
    },
    'pc6s8tan': {
      'kk': 'Қосымша',
      'ru': 'добавить',
    },
    '7avxrxsc': {
      'kk': 'Аға',
      'ru': '',
    },
    '97osswk3': {
      'kk': 'Мәлік Бердібаев',
      'ru': 'Мәлік Бердібаев',
    },
    'vw84mdhu': {
      'kk': 'Бизнес аккаунт',
      'ru': 'Бизнес аккаунт',
    },
    '32853t0y': {
      'kk': '\$2,100',
      'ru': '\$2,100',
    },
    'aocwczry': {
      'kk': 'Төленді',
      'ru': '',
    },
    'vja4s86x': {
      'kk': 'Белгісіз',
      'ru': 'Неизвестный',
    },
    '66yybwuk': {
      'kk': 'Арман Боранбай',
      'ru': 'Арман Боранбай',
    },
    'nlxwtv7c': {
      'kk': 'Жеке аккаунт',
      'ru': 'Персональный аккаунт',
    },
    'rn2fdg2q': {
      'kk': '\$620',
      'ru': '\$620',
    },
    '011gpync': {
      'kk': 'Кері',
      'ru': 'Отмена',
    },
    'b1jv81qx': {
      'kk': 'Дос',
      'ru': 'Друг',
    },
    '9hc9gk1g': {
      'kk': 'Айғаным Маликова',
      'ru': 'Айганьям Маликова',
    },
    'elycp7il': {
      'kk': 'Жеке аккаунт',
      'ru': 'Персональный аккаунт',
    },
    'sihrrhip': {
      'kk': '\$1900',
      'ru': '\$1900',
    },
    'dj9x2qcm': {
      'kk': 'Күтілуде',
      'ru': 'В ожидании',
    },
    '2fieltuy': {
      'kk': 'Card Header',
      'ru': '',
    },
    'g8sta7e0': {
      'kk': 'Create tables and ui elements that work below.',
      'ru': '',
    },
    '6seqiag1': {
      'kk': 'Add New',
      'ru': '',
    },
    '26on0a2r': {
      'kk': 'Work Type',
      'ru': '',
    },
    'vm35hbje': {
      'kk': 'Assigned User',
      'ru': '',
    },
    'pssarozs': {
      'kk': 'Contract Amount',
      'ru': '',
    },
    'j2ji4c3g': {
      'kk': 'Status',
      'ru': '',
    },
    '9s7yp73p': {
      'kk': 'Actions',
      'ru': '',
    },
    '7o18e0kj': {
      'kk': 'Design Work',
      'ru': '',
    },
    'seozctxq': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    'afr80ib2': {
      'kk': 'Business Name',
      'ru': '',
    },
    'cwvkfu1n': {
      'kk': '\$2,100',
      'ru': '',
    },
    '4klqazr6': {
      'kk': 'Paid',
      'ru': '',
    },
    'qiwzcmds': {
      'kk': 'Design Work',
      'ru': '',
    },
    '1ytgmnag': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    'q26k3sp7': {
      'kk': 'Business Name',
      'ru': '',
    },
    '0cp04a96': {
      'kk': '\$2,100',
      'ru': '',
    },
    'of4zslsd': {
      'kk': 'Paid',
      'ru': '',
    },
    'sgqka1sb': {
      'kk': 'Design Work',
      'ru': '',
    },
    '7d7kxsj2': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    '6n3t3sr1': {
      'kk': 'Business Name',
      'ru': '',
    },
    'l0kyq4bl': {
      'kk': '\$2,100',
      'ru': '',
    },
    '8bk2nhdc': {
      'kk': 'Paid',
      'ru': '',
    },
    'qa6a9q2t': {
      'kk': 'Design Work',
      'ru': '',
    },
    'g5jo2xtw': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    'giixbgtt': {
      'kk': 'Business Name',
      'ru': '',
    },
    '1mpusblm': {
      'kk': '\$2,100',
      'ru': '',
    },
    'lzpvbixk': {
      'kk': 'Paid',
      'ru': '',
    },
    '7u1krodo': {
      'kk': 'Design Work',
      'ru': '',
    },
    'hh4mtb8g': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    '8i8o3q5c': {
      'kk': 'Business Name',
      'ru': '',
    },
    't42y1d4o': {
      'kk': '\$2,100',
      'ru': '',
    },
    'ow8krsr9': {
      'kk': 'Pending',
      'ru': '',
    },
    '9zr9j7tv': {
      'kk': 'Design Work',
      'ru': '',
    },
    'bw3ebu0b': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    'mtwj44mh': {
      'kk': 'Business Name',
      'ru': '',
    },
    'ek87vnjq': {
      'kk': '\$2,100',
      'ru': '',
    },
    'eejsy8lw': {
      'kk': 'Pending',
      'ru': '',
    },
    '5d2n7o9k': {
      'kk': 'Design Work',
      'ru': '',
    },
    'nwf9z0y0': {
      'kk': 'Randy Peterson',
      'ru': '',
    },
    'tktc6ejd': {
      'kk': 'Business Name',
      'ru': '',
    },
    'zluvrryp': {
      'kk': '\$2,100',
      'ru': '',
    },
    'mk321ye2': {
      'kk': 'Pending',
      'ru': '',
    },
    '8iyz8xly': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // seedpage
  {
    '429xejhk': {
      'kk': 'Seed фразаларды өзіңізге жазып алыңыз!',
      'ru': 'Запишите свои Seed фразы!',
    },
    'ako0hkvy': {
      'kk':
          'Төмендегі рандомды сөздер сіздің аккаунтыңызды қайта қалпына келтіру үшін қолданады. Сөздерді ұмытып қалмау үшін және сенімді болу үшін скрин жасаңыз немесе жазып алыңыз! Seed Фраза тек бір рет қана беріледі. Сондықтан мұқият болыңыз!',
      'ru':
          'Случайные слова ниже будут использоваться для сброса вашей учетной записи. Сделайте скриншот или запишите слова, чтобы их не забыть и быть уверенным! Начальная фраза дается только один раз. Так что будь осторожен!',
    },
    'uav35iu6': {
      'kk': '1. Қияр',
      'ru': '1. Огурец',
    },
    'lt5sioj2': {
      'kk': '2. Астана',
      'ru': '2. Астана',
    },
    'udy2pxhh': {
      'kk': '3. Көше',
      'ru': '3. Улица',
    },
    'q8ulwm67': {
      'kk': '4. Бақа',
      'ru': '4. Лягушка',
    },
    'n9fxzaxq': {
      'kk': '5. Шыны',
      'ru': '5. Стекло',
    },
    'qud4gfm4': {
      'kk': '6. Мақта',
      'ru': '6. Хлопок',
    },
    'kqdl5f2b': {
      'kk': '7. Жиырма',
      'ru': '7. Двадцать',
    },
    '7ondyuw1': {
      'kk': '8. Қоңыз',
      'ru': '8. Жук',
    },
    'sh1m3aqp': {
      'kk': '9. Мектеп',
      'ru': '9. Школа',
    },
    'q5d2roey': {
      'kk': '10. Жылқы',
      'ru': '10. Лошадь',
    },
    '1biz1wkh': {
      'kk': 'Келесі',
      'ru': 'Следующий',
    },
    'wrl7u2ka': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // phonesignup
  {
    'pmh2ds12': {
      'kk': 'Тіркелу',
      'ru': 'Регистрация',
    },
    '0cqgenxb': {
      'kk': 'Төменге жарамды телефон нөміріңізді жазыңыз!',
      'ru': 'Введите свой действующий номер телефона ниже!',
    },
    '2fafbpyq': {
      'kk': 'Телефон нөміріңіз',
      'ru': 'Ваш номер телефона',
    },
    '8gu5g3hy': {
      'kk': '+7 777 742 40 69',
      'ru': '+7 777 742 40 69',
    },
    'nu3zq73x': {
      'kk': 'Келесі',
      'ru': 'Следующий',
    },
    '5n1skx0b': {
      'kk': 'Сізде телефон номер жоқ па?',
      'ru': 'У вас нет номера телефона?',
    },
    'hwic8a12': {
      'kk': 'Почта',
      'ru': 'Почта',
    },
    'j2jlpp7j': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // entercode
  {
    'p0qsf51c': {
      'kk': 'Құпия сөзді жазыңыз',
      'ru': 'Напишите пароль',
    },
    '9zo8mklk': {
      'kk': 'Төменге жіберілген құпия сөзді жазыңыз',
      'ru': 'Введите пароль, отправленный ниже',
    },
    'bsj4eepp': {
      'kk': 'Кері',
      'ru': 'Отмена',
    },
    'gqcphfp2': {
      'kk': 'Растау',
      'ru': 'Подтверждение',
    },
    'lu3evwcj': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // sendbitcoin
  {
    '6unez3u4': {
      'kk': 'BTC/USD ^ USD 59.515.54',
      'ru': 'BTC/USD ^ USD 59.515.54',
    },
    '2e00iw95': {
      'kk': 'Bitcoin',
      'ru': 'Bitcoin',
    },
    'epscaj96': {
      'kk': 'BTC/KZT',
      'ru': 'BTC/KZT',
    },
    '70a11hba': {
      'kk': 'KZT 28,693,923.98',
      'ru': 'KZT 28,693,923.98',
    },
    '4wqhede7': {
      'kk': 'Аударым',
      'ru': 'Перевод',
    },
    'e2pp4bze': {
      'kk': 'Қай криптоға жіберу керек?',
      'ru': 'На какую криптовалюту отправить?',
    },
    'c1n4g9jf': {
      'kk': 'Bitcoin',
      'ru': 'Bitcoin',
    },
    'i7l8o5zx': {
      'kk': 'Trust Wallet',
      'ru': 'Trust Wallet',
    },
    '9lw7b4by': {
      'kk': 'Bitcoin',
      'ru': 'Bitcoin',
    },
    'fn9i64lz': {
      'kk': 'Search for an item...',
      'ru': '',
    },
    'aozwe5bz': {
      'kk': '',
      'ru': '',
    },
    '72puhtvj': {
      'kk': 'Қабылдаушының адресі',
      'ru': 'Адрес получателя',
    },
    'finrvtxk': {
      'kk': 'user1@mail.ru',
      'ru': 'user1@mail.ru',
    },
    'w4vkl03h': {
      'kk': 'Саны',
      'ru': 'Количество',
    },
    'fg4bg6k0': {
      'kk': '10',
      'ru': '',
    },
    'uvir3x2o': {
      'kk': 'Ескертпе',
      'ru': 'Уведомления',
    },
    'ai7zrvuj': {
      'kk': 'Комиссия: 0.000000',
      'ru': 'Комиссия: 0.000000',
    },
    'tya08dh6': {
      'kk': 'Барлығы: 0.000000',
      'ru': 'Всего: 0.000000',
    },
    's7s74i5v': {
      'kk': 'Аудару',
      'ru': 'Перевод',
    },
    'j2jlpp7j': {
      'kk': 'Home',
      'ru': '',
    },
  },
  // sideBarNav
  {
    'f64sqtei': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    '5g89m7f5': {
      'kk': '1000',
      'ru': '1000',
    },
    'vvv9dnzq': {
      'kk': '\$',
      'ru': '',
    },
    'e0v2x8ab': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    'els86n7n': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    'afmp458b': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    'mdpa6co4': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    '0tccpo41': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'dt15ya3j': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    'd1ccn66a': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    'kcq5jbq4': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // sideBarNav2
  {
    '4k3eocbk': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    'rggcf58r': {
      'kk': '1000',
      'ru': '1000',
    },
    's5cgo0xu': {
      'kk': '\$',
      'ru': '',
    },
    'dx5g1f5b': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    'dl55p6iw': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    '47d1e3ed': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    'shrwbv4v': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    'e10a3kle': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'vetaltvg': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    '46nenn1y': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    'pphy4eye': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // sideBarNav3
  {
    'krhjonzv': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    '1nevybrg': {
      'kk': '1000',
      'ru': '1000',
    },
    'nqk24fj4': {
      'kk': '\$',
      'ru': '',
    },
    'm2nw42p4': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    '2xnkg4ov': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    'ej5bf72v': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    '4b83j3ow': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    'qkq4x7xs': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'd0gchlyk': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    'mrx5f1io': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    'abzsfsis': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // sideBarNav4
  {
    '8vjcgtt9': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    'wr6gy6az': {
      'kk': '1000',
      'ru': '1000',
    },
    'oos8xao5': {
      'kk': '\$',
      'ru': '',
    },
    '9eguvsou': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    'yt4h4acj': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    'n9oydcea': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    '2apomymr': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    'wz4gawgt': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'n3xwyp0m': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    'p879vxkx': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    'tz7fo3um': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // sideBarNav5
  {
    'kl096wf5': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    '6jo0zpr5': {
      'kk': '1000',
      'ru': '1000',
    },
    'l7jse36r': {
      'kk': '\$',
      'ru': '',
    },
    'yq62np8p': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    'otg3n3og': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    'z6lboa3r': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    'f7te5b8d': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    'yyn1upnx': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'gf0nvsbp': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    '2ww6crwx': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    '5mxkle4j': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // sideBarNav6
  {
    'r137ebj2': {
      'kk': 'Портфолио нөмірі ',
      'ru': 'Номер портфеля',
    },
    'wlueoz2e': {
      'kk': '1000',
      'ru': '1000',
    },
    'cw6dcl0g': {
      'kk': '\$',
      'ru': '',
    },
    'k8s0dyue': {
      'kk': 'Аккаунт  иесі',
      'ru': 'Владелец',
    },
    '936ds4ji': {
      'kk': 'Негізгі бет',
      'ru': 'Главная страница',
    },
    'vpj2frbp': {
      'kk': 'Ауысымдар',
      'ru': 'История',
    },
    '2050kovk': {
      'kk': 'Статистика',
      'ru': 'Статистика',
    },
    'x8zmfts9': {
      'kk': 'Жіберу',
      'ru': 'Переводы',
    },
    'vu7zb5lb': {
      'kk': 'Қабылдау',
      'ru': 'Прием',
    },
    '4s93rr7v': {
      'kk': 'Сатып алу/сату',
      'ru': 'Купи продай',
    },
    'abjgwg5p': {
      'kk': 'Профиль',
      'ru': 'Профиль',
    },
  },
  // Miscellaneous
  {
    '7q1ymysw': {
      'kk': '',
      'ru': '',
    },
    'zwfd3r9d': {
      'kk': '',
      'ru': '',
    },
    'pdd5n4zk': {
      'kk': '',
      'ru': '',
    },
    'fjnlqa6i': {
      'kk': '',
      'ru': '',
    },
    'khu1qenl': {
      'kk': '',
      'ru': '',
    },
    '0d6qfqb0': {
      'kk': '',
      'ru': '',
    },
    'gxqrkndi': {
      'kk': '',
      'ru': '',
    },
    'a6dw3b1h': {
      'kk': '',
      'ru': '',
    },
    '500r8d2v': {
      'kk': '',
      'ru': '',
    },
    '8nfk8xpm': {
      'kk': '',
      'ru': '',
    },
    '7esp8d2a': {
      'kk': '',
      'ru': '',
    },
    'ewy6e4it': {
      'kk': '',
      'ru': '',
    },
    'j87dlmz9': {
      'kk': '',
      'ru': '',
    },
    's7j3sonc': {
      'kk': '',
      'ru': '',
    },
    'nwa7mom9': {
      'kk': '',
      'ru': '',
    },
    'st9hc5j7': {
      'kk': '',
      'ru': '',
    },
    '5tkvr5gc': {
      'kk': '',
      'ru': '',
    },
    '2v8p137n': {
      'kk': '',
      'ru': '',
    },
    'xp13rr83': {
      'kk': '',
      'ru': '',
    },
    'msyq0qj4': {
      'kk': '',
      'ru': '',
    },
    'z8c80bwo': {
      'kk': '',
      'ru': '',
    },
    'q51b3dw4': {
      'kk': '',
      'ru': '',
    },
    '9ewlmck9': {
      'kk': '',
      'ru': '',
    },
    '4ux9r2z2': {
      'kk': '',
      'ru': '',
    },
    'zul2me26': {
      'kk': '',
      'ru': '',
    },
    '6vr9byws': {
      'kk': '',
      'ru': '',
    },
    'zonn00wi': {
      'kk': '',
      'ru': '',
    },
  },
].reduce((a, b) => a..addAll(b));
