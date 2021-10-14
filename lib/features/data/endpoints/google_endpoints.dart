class GoogleEndpoints {
  static String apod(
    String apiKey,
    String filter, [
    int count = 10,
    int startIndex = 10,
  ]) =>
      'https://www.googleapis.com/books/v1/volumes?projection=full&maxResults=$count&startIndex=$startIndex&q=$filter&key=$apiKey';
}
