extension SingleReplace<E> on List<E> {
  void replace(int index, E element) {
    this[index] = element;
  }
}
