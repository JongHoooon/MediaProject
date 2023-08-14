//
//  MovieListResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

struct MovieListResponseDTO: Codable {
    let page: Int?
    let movies: [MovieDTO]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toMovie() -> Movie {
        return Movie(
            adult: self.adult ?? false,
            backdropPath: self.backdropPath ?? "",
            id: self.id ?? 0,
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            overview: self.overview ?? "",
            posterPath: self.posterPath ?? "",
            mediaType: self.mediaType ?? "",
            genreIDS: self.genreIDS ?? [],
            popularity: self.popularity ?? 0,
            releaseDate: self.releaseDate ?? "",
            voteAverage: self.voteAverage ?? 0
        )
    }
}
