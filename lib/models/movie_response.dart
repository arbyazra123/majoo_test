import 'dart:convert';

class MovieResponseFailure extends MovieResponse{
  String? msg;
  MovieResponseFailure({this.msg});
}

class MovieResponse {
  MovieResponse({
    this.data,
    this.query,
    this.v,
  });
  List<Data>? data;
  String? query;
  int? v;
  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
      data: List<Data>.from(json["d"].map((x) => Data.fromJson(x))),
  query: json["q"],
  v: json["v"],
  );
  Map<String, dynamic> toJson() => {
  "d": List<dynamic>.from(data!.map((x) => x.toJson())),
  "q": query,
  "v": v,
};
}
class Data {
  Data({
    this.i,
    this.id,
    this.l,
    this.q,
    this.rank,
    this.s,
    this.series,
    this.vt,
    this.year,
    this.yr,
  });
  I? i;
  String? id;
  String? l;
  String? q;
  int? rank;
  String? s;
  List<Series>? series;
  int? vt;
  int? year;
  String? yr;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
      i: I.fromJson(json["i"]),
      id: json["id"],
      l: json["l"],
      q: json["q"],
      rank: json["rank"],
      s: json["s"],
      series: json["v"] == null ? null : List<Series>.from(json["v"].map((x) => Series.fromJson(x))),
  vt: json["vt"] == null ? null : json["vt"],
  year: json["y"],
  yr: json["yr"] == null ? null : json["yr"],
  );
  Map<String, dynamic> toJson() => {
  "i": i!.toJson(),
  "id": id,
  "l": l,
  "q": q,
  "rank": rank,
  "s": s,
  "v": series == null ? null : List<dynamic>.from(series!.map((x) => x.toJson())),
  "vt": vt == null ? null : vt,
  "y": year,
  "yr": yr == null ? null : yr,
};
}
class I {
  I({
    this.height,
    this.imageUrl,
    this.width,
  });
  int? height;
  String? imageUrl;
  int? width;
  factory I.fromJson(Map<String, dynamic> json) => I(
    height: json["height"],
    imageUrl: json["imageUrl"],
    width: json["width"],
  );
  Map<String, dynamic> toJson() => {
  "height": height,
  "imageUrl": imageUrl,
  "width": width,
};
}
class Series {
  Series({
    this.i,
    this.id,
    this.l,
    this.s,
  });
  I? i;
  String ?id;
  String? l;
  String? s;
  factory Series.fromJson(Map<String, dynamic> json) => Series(
    i: I.fromJson(json["i"]),
    id: json["id"],
    l: json["l"],
    s: json["s"],
  );
  Map<String, dynamic> toJson() => {
  "i": i!.toJson(),
  "id": id,
  "l": l,
  "s": s,
};
}

















