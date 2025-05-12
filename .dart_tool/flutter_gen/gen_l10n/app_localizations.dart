import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Family Arbore'**
  String get title;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Family Arbore'**
  String get greeting;

  /// No description provided for @dec.
  ///
  /// In en, this message translates to:
  /// **'A platform built for families to connect, share, and grow together. Share posts, likes, and comments, message each other, set up family events, and even create your family tree heritage. Join us and keep your family legacy alive.'**
  String get dec;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Create your account and start sharing moments.'**
  String get signUp;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'ConfirmPassword'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ? Sign in here.'**
  String get alreadyHaveAccount;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get logoutSure;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose From Gallery'**
  String get chooseFromGallery;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get takeAPhoto;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Photo Gallery'**
  String get editProfile;

  /// No description provided for @familyList.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get familyList;

  /// No description provided for @signInDec.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account to continue.'**
  String get signInDec;

  /// No description provided for @forgetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'forget your password ?'**
  String get forgetYourPassword;

  /// No description provided for @forgetPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPasswordScreenTitle;

  /// No description provided for @pleaseEnterYouEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get pleaseEnterYouEmail;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'SendEmail'**
  String get sendEmail;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get please_enter_password;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @pleaseEnterAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter all fields'**
  String get pleaseEnterAllFields;

  /// No description provided for @emailisnotvalid.
  ///
  /// In en, this message translates to:
  /// **'Email is not valid'**
  String get emailisnotvalid;

  /// No description provided for @telUsPost.
  ///
  /// In en, this message translates to:
  /// **'Tell us about the post you want to create'**
  String get telUsPost;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @addPostTitle.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get addPostTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'POST'**
  String get post;

  /// No description provided for @selectMedia.
  ///
  /// In en, this message translates to:
  /// **'Select Media'**
  String get selectMedia;

  /// No description provided for @writeyoucomment.
  ///
  /// In en, this message translates to:
  /// **'Write you comment'**
  String get writeyoucomment;

  /// No description provided for @theInputMustbeEmail.
  ///
  /// In en, this message translates to:
  /// **'The input must be email'**
  String get theInputMustbeEmail;

  /// No description provided for @passwordMustBeSame.
  ///
  /// In en, this message translates to:
  /// **'Password must be same'**
  String get passwordMustBeSame;

  /// No description provided for @passwordToShort.
  ///
  /// In en, this message translates to:
  /// **'This password is too short. It must contain at least 8 characters.'**
  String get passwordToShort;

  /// No description provided for @containsACapitaLetter.
  ///
  /// In en, this message translates to:
  /// **'Contains a capital letter'**
  String get containsACapitaLetter;

  /// No description provided for @containANumber.
  ///
  /// In en, this message translates to:
  /// **'Contains a number'**
  String get containANumber;

  /// No description provided for @containASpacialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Contains spacial character'**
  String get containASpacialCharacter;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
