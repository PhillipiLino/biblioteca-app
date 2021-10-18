class GoogleEndpoints {
  static String apod(
    String apiKey,
    String filter, [
    int startIndex = 10,
    int count = 10,
  ]) =>
      'https://www.googleapis.com/books/v1/volumes?projection=full&maxResults=$count&startIndex=$startIndex&q=$filter&key=$apiKey';
}
