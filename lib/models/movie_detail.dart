// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

MovieDetail movieDetailFromJson(String str) => MovieDetail.fromJson(json.decode(str));

String movieDetailToJson(MovieDetail data) => json.encode(data.toJson());

class MovieDetail {
     bool? adult;
    String? backdropPath;
    BelongsToCollection? belongsToCollection;
    int? budget;
    List<Genre>? genres;
    String? homepage;
    int? id;
    String? imdbId;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    List<ProductionCompany>? productionCompanies;
    List<ProductionCountry>? productionCountries;
    DateTime? releaseDate;
    int? revenue;
    int? runtime;
    List<SpokenLanguage>? spokenLanguages;
    String? status;
    String? tagline;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieDetail({
        required this.adult,
        required this.backdropPath,
        required this.belongsToCollection,
        required this.budget,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.imdbId,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCompanies,
        required this.productionCountries,
        required this.releaseDate,
        required this.revenue,
        required this.runtime,
        required this.spokenLanguages,
        required this.status,
        required this.tagline,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

     factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] != null ? BelongsToCollection.fromJson(json["belongs_to_collection"]) : null,
        budget: json["budget"],
        genres: json["genres"] != null ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))) : null,
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] != null ? List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))) : null,
        productionCountries: json["production_countries"] != null ? List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))) : null,
        releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : null,
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: json["spoken_languages"] != null ? List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))) : null,
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );  

    Map<String, dynamic> toJson() => {
      "adult": adult,
      "backdrop_path": backdropPath,
      // Use ?.toJson() to call toJson only if belongsToCollection is not null, otherwise return null
      "belongs_to_collection": belongsToCollection?.toJson(),
      "budget": budget,
      // Use null check before mapping the list, return null if genres is null
      "genres": genres != null ? List<dynamic>.from(genres!.map((x) => x.toJson())) : null,
      "homepage": homepage,
      "id": id,
      "imdb_id": imdbId,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      // Similar approach for productionCompanies and productionCountries
      "production_companies": productionCompanies != null ? List<dynamic>.from(productionCompanies!.map((x) => x.toJson())) : null,
      "production_countries": productionCountries != null ? List<dynamic>.from(productionCountries!.map((x) => x.toJson())) : null,
      // Handle releaseDate carefully, format it if not null
      "release_date": releaseDate != null ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}" : null,
      "revenue": revenue,
      "runtime": runtime,
      // Use null check for spokenLanguages
      "spoken_languages": spokenLanguages != null ? List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())) : null,
      "status": status,
      "tagline": tagline,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
  };
}

class BelongsToCollection {
    int id;
    String name;
    String posterPath;
    String backdropPath;

    BelongsToCollection({
        required this.id,
        required this.name,
        required this.posterPath,
        required this.backdropPath,
    });

    factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
    };
}

class Genre {
    int id;
    String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ProductionCompany {
    int id;
    String? logoPath;
    String name;
    String originCountry;

    ProductionCompany({
        required this.id,
        required this.logoPath,
        required this.name,
        required this.originCountry,
    });

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}

class ProductionCountry {
    String iso31661;
    String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage {
    String englishName;
    String iso6391;
    String name;

    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
