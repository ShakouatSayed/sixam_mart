import 'package:sixam_mart/util/app_constants.dart';

enum HtmlType{
  TERMS_AND_CONDITION,
  PRIVACY_POLICY,
  ABOUT_US,
}

extension HtmlTypeExtension on HtmlType{

  String get apiEndpoint{
    switch(this){
      case HtmlType.TERMS_AND_CONDITION:
        return AppConstants.TERMS_AND_CONDITIONS_URI;

      case HtmlType.PRIVACY_POLICY:
        return AppConstants.PRIVACY_POLICY_URI;

      case HtmlType.ABOUT_US:
        return AppConstants.ABOUT_US_URI;

        default:
          return AppConstants.ABOUT_US_URI;
    }
  }

  String get displayName{
    switch(this) {
      case HtmlType.TERMS_AND_CONDITION:
        return "Terms & Conditions";
      case HtmlType.PRIVACY_POLICY:
        return "Privacy Policy";
      case HtmlType.ABOUT_US:
        return "About Us";
      default:
        return "About Us";
    }
  }
}