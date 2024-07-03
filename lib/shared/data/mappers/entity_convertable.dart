mixin EntityConvertible<T, E> {
  E get toEntity;
  T fromEntity(E entity) => throw UnimplementedError();
}
