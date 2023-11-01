
typedef DeserializerFactory<T> = T Function(Map<String, dynamic>);

List<T> jsonDecodeList<T>(Iterable mapList, DeserializerFactory<T> factory) {
  return List<T>.of(mapList.map((entity) => factory(entity)));
}
