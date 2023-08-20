//
//  RelatedVideoResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/18.
//


struct RelatedVideoResponseDTO: Codable {
    let id: Int?
    let results: [RelatedVideoInfoDTO]?
    // MARK: - Result
    struct RelatedVideoInfoDTO: Codable {
        let iso639_1, iso3166_1, name, key: String?
        let site: String?
        let size: Int?
        let type: String?
        let official: Bool?
        let publishedAt, id: String?
        
        enum CodingKeys: String, CodingKey {
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case name, key, site, size, type, official
            case publishedAt = "published_at"
            case id
        }
    }
}

extension RelatedVideoResponseDTO {
    
    func toRelatedVideoInfos() -> [RelatedVideoInfo] {
        
        let relatedVideoInfos = results?.map {
            $0.toRelatedVideoInfo()
        }

        return relatedVideoInfos ?? []
    }
}

extension RelatedVideoResponseDTO.RelatedVideoInfoDTO {

    func toRelatedVideoInfo() -> RelatedVideoInfo {
        
        return RelatedVideoInfo(
            name: name ?? "",
            site: site ?? "",
            type: type ?? ""
        )
    }
}
