class NewsData {
  String? kind;
  Data? data;

  NewsData({this.kind, this.data});

  NewsData.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? after;
  int? dist;
  List<ListData>? listData;
  String? before;

  Data({this.after, this.dist, this.listData, this.before});

  Data.fromJson(Map<String, dynamic> json) {
    after = json['after'];
    dist = json['dist'];
    if (json['children'] != null) {
      listData = <ListData>[];
      json['children'].forEach((v) {
        listData!.add(ListData.fromJson(v));
      });
    }
    before = json['before'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['after'] = after;
    data['dist'] = dist;
    if (listData != null) {
      data['children'] = listData!.map((v) => v.toJson()).toList();
    }
    data['before'] = before;
    return data;
  }
}

class ListData {
  Details? details;

  ListData({this.details});

  ListData.fromJson(Map<String, dynamic> json) {
    details =
    json['data'] != null ? Details.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['data'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  bool? clicked;
  String? title;
  String? selftext;
  String? authorFullname;
  String? thumbnail;
  double? created;
  int? likes;
  String? url;
  int? subredditSubscribers;
  double? createdUtc;

  Details(
      {this.clicked,
        this.title,
        this.selftext,
        this.authorFullname,
        this.thumbnail,
        this.created,
        this.likes,
        this.url,
        this.subredditSubscribers,
        this.createdUtc});

  Details.fromJson(Map<String, dynamic> json) {
    clicked = json['clicked'];
    title = json['title'];
    selftext = json['selftext'];
    authorFullname = json['author_fullname'];
    thumbnail = json['thumbnail'];
    created = json['created'];
    likes = json['likes'];
    url = json['url'];
    subredditSubscribers = json['subreddit_subscribers'];
    createdUtc = json['created_utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clicked'] = clicked;
    data['title'] = title;
    data['selftext'] = selftext;
    data['author_fullname'] = authorFullname;
    data['thumbnail'] = thumbnail;
    data['created'] = created;
    data['likes'] = likes;
    data['url'] = url;
    data['subreddit_subscribers'] = subredditSubscribers;
    data['created_utc'] = createdUtc;
    return data;
  }
}