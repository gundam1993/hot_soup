class ImageHelper {
  static String testAvatarUrl(String origin) {
    RegExp exp = new RegExp("^http");
    Iterable<Match> matches = exp.allMatches(origin);
    for (Match m in matches) {
      if (m.group(0) == 'http') {
        return origin;
      }
    }
    String url = 'http:' + origin;
    return url;
  }
}