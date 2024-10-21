class Validators {
  static const emptyField = 'Required field';
  //validators para el formulario.
  static String? titleValidator(String? title) {
    final RegExp titlePattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (title == null || title.isEmpty) return emptyField;
    if (!titlePattern.hasMatch(title)) {
      return 'This field must contain a valid title';
    }
    return null;
  }

  static String? releaseYearValidator(String? releaseYear) {
    final RegExp yearPattern = RegExp(r'^\d{4}$');
    if (releaseYear == null || releaseYear.isEmpty) return emptyField;
    if (!yearPattern.hasMatch(releaseYear)) {
      return 'This field must be a 4-digit year';
    }
    return null;
  }

  static String? ratingValidotor(String? rating) {
    final RegExp ratingPattern = RegExp(r'^10(\.0+)?|[0-9](\.\d+)?$');
    if (rating == null || rating.isEmpty) return emptyField;
    if (!ratingPattern.hasMatch(rating)) {
      return 'This field must be a rating between 0 and 10';
    }
    return null;
  }
}
