/// STRING EXTENSION
extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegExp.hasMatch(this);
  }

  bool isUzbekNumber() {
    // Uzbek phone numbers should match the pattern +998 XXX XXX XXX or +998XX XXXXXXX
    final regex = RegExp(r'^\+998\d{9}$');
    return regex.hasMatch(this);
  }
}
