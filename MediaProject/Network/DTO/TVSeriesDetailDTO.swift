//
//  TVSeriesDetailDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//

struct TVSeriesDetailDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let name: String?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCountries: [ProductionCountry]?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    // MARK: - Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }

    // MARK: - ProductionCountry
    struct ProductionCountry: Codable {
        let iso3166_1, name: String?

        enum CodingKeys: String, CodingKey {
            case iso3166_1 = "iso_3166_1"
            case name
        }
    }

    // MARK: - Season
    struct Season: Codable {
        let airDate: String?
        let episodeCount, id: Int?
        let name, overview, posterPath: String?
        let seasonNumber: Int?
        let voteAverage: Double?

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case episodeCount = "episode_count"
            case id, name, overview
            case posterPath = "poster_path"
            case seasonNumber = "season_number"
            case voteAverage = "vote_average"
        }
    }

    // MARK: - SpokenLanguage
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String?

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }

    func toTVDetail() -> TVDetail {
        let seasonNumbers = seasons?.compactMap { $0.seasonNumber }
        let episodeCounts = seasons?.compactMap { $0.episodeCount }
    
        return TVDetail(
            seasonID: id ?? -1,
            seasonNumbers: seasonNumbers ?? [],
            episodeCounts: episodeCounts ?? []
        )
    }
}
