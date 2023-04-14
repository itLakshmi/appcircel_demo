


class ServerURL {


  static String baseurl = "https://www.reddit.com/r/health/hot.json?limit=10";

  static getUrl(RequestType RequestTypes) {
    switch (RequestTypes) {

      case RequestType.base:
        return baseurl;


    }
  }

}


enum RequestType {

  base,

}