class FormValidate {
  String validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    // final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    // if (!nameExp.hasMatch(value))
    //   return 'Please enter only alphabetical characters.';
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please choose a password.';
    if (value.length < 6) return 'The Password must be at least 8 characters.';
    return null;
  }

  String validateMustInput(String value) {
    if (value.length < 1) {
      return 'This field must be required.';
    }
  }

  String validatePrice(String value) {
    if (!(value.length > 0)) {
      return 'This field value must be required.';
    }
    if (value.split('.').length > 2) {
      return 'This field value is not correct.';
    }
    return null;
  }
}
