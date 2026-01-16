extension JsonExtensions on Object? {
  /// Converts a dynamic value to a boolean safely.
  /// Handles boolean types and "true"/"false" strings.
  bool toBool() {
    if (this == null) return false;
    if (this is bool) return this as bool;
    if (this is String) {
      return toString().toLowerCase() == 'true';
    }
    return false;
  }
}
