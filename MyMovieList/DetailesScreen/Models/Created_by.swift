

import Foundation

struct Created_by : Codable {
    
	let id                  : Int?
	let credit_id           : String?
	let name                : String?
	let gender              : Int?
	let profile_path        : String?

	enum CodingKeys: String, CodingKey {

		case id             = "id"
		case credit_id      = "credit_id"
		case name           = "name"
		case gender         = "gender"
		case profile_path   = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values          = try decoder.container(keyedBy: CodingKeys.self)
		id                  = try values.decodeIfPresent(Int.self, forKey: .id)
		credit_id           = try values.decodeIfPresent(String.self, forKey: .credit_id)
		name                = try values.decodeIfPresent(String.self, forKey: .name)
		gender              = try values.decodeIfPresent(Int.self, forKey: .gender)
		profile_path        = try values.decodeIfPresent(String.self, forKey: .profile_path)
	}

}
