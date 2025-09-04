class Validators {
  static bool isValidEmail(String v) => RegExp(r'^.+@.+\..+$').hasMatch(v);
  static bool isValidPassword(String v) => v.trim().length >= 6;
}