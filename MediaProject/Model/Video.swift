//
//  Video.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

struct Video {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let mediaType: MediaType?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    
    var releaseDateText: String? {
        guard !releaseDate.isEmpty else { return nil }
        
        let releaseDateSplits = releaseDate.split(separator: "-")
        let year = releaseDateSplits[0]
        let month = releaseDateSplits[1]
        let day = releaseDateSplits[2]
        return [
            month,
            day,
            year
        ].map { String($0 ?? "") }
            .joined(separator: "/")
    }
    var voteAverageText: String? {
        return String(format: "%.1f", voteAverage)
    }
}
