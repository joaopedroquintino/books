/// This method modify headers because the returns is <String,List<String>>
/// instead of <String,String>.
Map<String, String> modifyDioHeader(Map<String, List<String>> headers) {
  return headers.map<String, String>(
    (String key, List<String> value) {
      return MapEntry<String, String>(
        key,
        value[0],
      );
    },
  );
}
