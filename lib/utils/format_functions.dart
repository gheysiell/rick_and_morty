class FormatFunctions {
  static String safeParseString(dynamic value) {
    return (value?.toString() ?? '');
  }

  static int safeParseInt(dynamic value) {
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double safeParseDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  static List<dynamic> safeParseList(dynamic value) {
    if (value is List) {
      return value;
    }
    return [];
  }
}
