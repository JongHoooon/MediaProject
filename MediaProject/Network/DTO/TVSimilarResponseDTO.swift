//
//  TVSimilarResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//

// MARK: - TVSimilarDTO
struct TVSimilarResponseDTO: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct Result: Codable {
        let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]?
        let id: Int?
        let originCountry: [String]?
        let originalLanguage, originalName, overview: String?
        let popularity: Double?
        let posterPath, firstAirDate, name: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case firstAirDate = "first_air_date"
            case name
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
        
        func toVideo() -> Video {
            return Video(
                adult: adult ?? false,
                backdropPath: backdropPath ?? "",
                id: id ?? -1,
                title: name ?? "",
                originalTitle: originalName ?? "",
                overview: overview ?? "",
                posterPath: posterPath ?? "",
                mediaType: "",
                genreIDS: genreIDS ?? [],
                popularity: popularity ?? 0,
                releaseDate: firstAirDate ?? "",
                voteAverage: voteAverage ?? 0
            )
        }
    }
    
    func toVideos() -> [Video] {
        let videos = results?.compactMap {
            return $0.toVideo()
        }
        
        return videos ?? []
    }
}

