//
//  TrendListResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

struct TrendListResponseDTO: Codable {
    let page: Int?
    let videoDTOs: [VideoDTO]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case videoDTOs = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct VideoDTO: Codable {
        let adult: Bool?
        let backdropPath: String?
        let id: Int?
        let title: String?
        let name: String?
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
            case id, title, name
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
        
        func toVideo() -> Video {
            var videoTitle = ""
            if let title = title {
                videoTitle = title
            }
            if let name = name {
                videoTitle = name
            }
            let mediaType = MediaType(rawValue: mediaType ?? "")
            
            return Video(
                adult: self.adult ?? false,
                backdropPath: self.backdropPath ?? "",
                id: self.id ?? 0,
                title: videoTitle,
                originalTitle: self.originalTitle ?? "",
                overview: self.overview ?? "",
                posterPath: self.posterPath ?? "",
                mediaType: mediaType,
                genreIDS: self.genreIDS ?? [],
                popularity: self.popularity ?? 0,
                releaseDate: self.releaseDate ?? "",
                voteAverage: self.voteAverage ?? 0
            )
        }
    }
    
    func toVideos() -> [Video] {
        let videos = videoDTOs?.map {
            $0.toVideo()
        }
        
        return videos ?? []
    }
}

