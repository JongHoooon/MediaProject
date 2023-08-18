//
//  CreditResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

struct CreditResponseDTO: Codable {
    let id: Int?
    let castDTOs, crew: [CastDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id, crew
        case castDTOs = "cast"
    }
    
    // MARK: - CastDTO
    struct CastDTO: Codable {
        let adult: Bool?
        let gender, id: Int?
        let knownForDepartment: String?
        let name, originalName: String?
        let popularity: Double?
        let profilePath: String?
        let castID: Int?
        let character, creditID: String?
        let order: Int?
        let department: String?
        let job: String?
        
        enum CodingKeys: String, CodingKey {
            case adult, gender, id
            case knownForDepartment = "known_for_department"
            case name
            case originalName = "original_name"
            case popularity
            case profilePath = "profile_path"
            case castID = "cast_id"
            case character
            case creditID = "credit_id"
            case order, department, job
        }
    }
    
    func toCasts() -> [Cast] {
        let casts = castDTOs?.compactMap {
            return Cast(
                adult: $0.adult ?? false,
                gender: $0.gender ?? -1,
                id: $0.id ?? -1,
                knownForDepartment: $0.knownForDepartment ?? "",
                name: $0.name ?? "",
                originalName: $0.originalName ?? "",
                popularity: $0.popularity ?? 0,
                profilePath: $0.profilePath ?? "",
                castID: $0.castID ?? 0,
                character: $0.character ?? "",
                creditID: $0.creditID ?? "",
                order: $0.order ?? -1,
                department: $0.department ?? "",
                job: $0.job ?? ""
            )
        }
        return casts ?? []
    }
}
