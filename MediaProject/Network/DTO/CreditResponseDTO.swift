//
//  CreditResponseDTO.swift
//  MediaProject
//
//  Created by JongHoon on 2023/08/14.
//

struct CreditResponseDTO: Codable {
    let id: Int?
    let cast, crew: [CastDTO]?
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
    
    func toCast() -> Cast {
        return Cast(
            adult: self.adult ?? false,
            gender: self.gender ?? -1,
            id: self.id ?? -1,
            knownForDepartment: self.knownForDepartment ?? "",
            name: self.name ?? "",
            originalName: self.originalName ?? "",
            popularity: self.popularity ?? 0,
            profilePath: self.profilePath ?? "",
            castID: self.castID ?? 0,
            character: self.character ?? "",
            creditID: self.creditID ?? "",
            order: self.order ?? -1,
            department: self.department ?? "",
            job: self.job ?? ""
        )
    }
}

