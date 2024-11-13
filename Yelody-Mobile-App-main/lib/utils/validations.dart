import 'package:get/get.dart';

class FieldValidator {
  static bool isHideoldpassword = true;
  static bool isHidepassword = true;
  static bool isHideconfirmpassword = true;
  static const String PASSWORD_VALIDATION_REGEX =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@}#\]{$&:)[*~^_,(+-.<%;/>]).{8,}$';
  static const String WEBSITE_VALIDATION_REGEX =
      'https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,}';

//------------- hide/Un hide--------------//
  static void oldpassword_hideIcon() {
    if (isHideoldpassword) {
      isHideoldpassword = false;
    } else {
      isHideoldpassword = true;
    }
  }

  static void password_hideIcon() {
    if (isHidepassword) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
  }

  static void confirm_password_hideIcon() {
    if (isHideconfirmpassword) {
      isHideconfirmpassword = false;
    } else {
      isHideconfirmpassword = true;
    }
  }

//------------------ Empty Validator ---------------//
  static String? validatePhone({required String value}) {
    if (value.isEmpty) {
      return "Phone number field can't be empty.";
    } else if (value.length < 16) {
      return "The phone number must be at least 11 characters.";
    }
    return null;
  }

//------------------ Empty Validator ---------------//
  static String? validateEmpty({required String value, required String label}) {
    if (value.isEmpty) {
      return "$label field can't be empty.";
    }
    return null;
  }

//------------------ Empty Validator ---------------//
  static String? validateNull({required String value, required String label}) {
    if (value == "") {
      return "$label field can't be empty.";
    }
    return null;
  }

//------------------ Email Validator ---------------//
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email field can't be empty.";
    } else if (!GetUtils.isEmail(value)) {
      return "Please enter valid email.";
    }
    return null;
  }

//------------------ Website Validator ---------------//
  static String? validateWebUrl(String value) {
    if (value.isEmpty) {
      return "Website Link field can't be empty.";
    } else if (!RegExp(WEBSITE_VALIDATION_REGEX).hasMatch(value)) {
      return "Please enter valid Website Link.";
    }
    return null;
  }

  //-----------------------OTP Validator---------------//
  static String? validatePin(String value) {
    if (value.isEmpty) {
      return "The OTP field can't be empty.";
    } else if (value.length == 6) {
      return null;
    }
    return "Invalid OTP verification code.";
  }

  //----------------Login Password Validator -----------------//
  static String? validateLoginPassword(String value, String? label) {
    if (value.trim().isEmpty) {
      return "$label field can't be empty.";
    } else if (!RegExp(PASSWORD_VALIDATION_REGEX).hasMatch(value)) {
      return "Invalid Password.";
    }
    return null;
  }

//---------------- CVC Validator -----------------//
  static String? validateCVC({required String value, String? label}) {
    if (value.trim().isEmpty) {
      return "$label  field can't be empty.";
    } else if (value.length <= 2) {
      return "$label must be atleast 3 digits.";
    }
    return null;
  }

  //---------------- Password Validator -----------------//
  static String? validateCardNo({required String value, String? label}) {
    if (value.trim().isEmpty) {
      return "$label  field can't be empty.";
    } else if (value.length <= 15) {
      return "$label must be atleast 16 digits.";
    }
    return null;
  }

  //---------------- Password Validator -----------------//
  static String? validatePassword(String value, String? label) {
    if (value.trim().isEmpty) {
      return "$label  field can't be empty.";
    } else if (!RegExp(PASSWORD_VALIDATION_REGEX).hasMatch(value)) {
      return "Password must be of 8 characters long and contain atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character.";
    }
    return null;
  }

//--------------------Confirm Password Validator--------//
  static String? validateConfirmPassword(
      String password, String confirmPassword, String label) {
    if (confirmPassword.isEmpty) {
      return "Confirm Password field can't be empty.";
    } else if (!(password == confirmPassword)) {
      return '$label and Confirm Password must be same.';
    } else if (password.isEmpty) {
      return "Confirm Password field can't be empty.";
    } else {
      return null;
    }
  }

  // -----------------------Null Validator---------------//
  static String? valiadteEmpty(String? value, String label) {
    if (value == null || value.isEmpty) {
      return "$label can not be empty";
    }
    return null;
  }

  // -----------------------Null Validator---------------//
  static String? validateUserName(String? value, String label) {
    if (value == null || value.isEmpty) {
      return "$label must be greater than 5 characters";
    } else if (value.length < 5) {
      return "$label must be greater than 5 characters";
    } else if (value.length > 20) {
      return "$label must be less than 20 characters";
    }
    return null;
  }
  //------------- Name Validator--------------//
}
