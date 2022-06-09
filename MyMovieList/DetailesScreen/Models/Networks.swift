

import Foundation

struct Networks : Codable {
	let name : String?
	let id : Int?
	let logo_path : String?
	let origin_country : String?

	enum CodingKeys: String, CodingKey {

		case name               = "name"
		case id                 = "id"
		case logo_path          = "logo_path"
		case origin_country     = "origin_country"
	}

	init(from decoder: Decoder) throws {
		let values      = try decoder.container(keyedBy: CodingKeys.self)
		name            = try values.decodeIfPresent(String.self, forKey: .name)
		id              = try values.decodeIfPresent(Int.self, forKey: .id)
		logo_path       = try values.decodeIfPresent(String.self, forKey: .logo_path)
		origin_country  = try values.decodeIfPresent(String.self, forKey: .origin_country)
	}

}
