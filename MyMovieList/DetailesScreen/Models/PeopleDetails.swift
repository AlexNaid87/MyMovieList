

import Foundation

struct PeopleDetails : Codable {
	let adult                   : Bool?
	let also_known_as           : [String]?
	let biography               : String?
	let birthday                : String?
	let deathday                : String?
	let gender                  : Int?
	let homepage                : String?
	let id                      : Int?
	let imdb_id                 : String?
	let known_for_department    : String?
	let name                    : String?
	let place_of_birth          : String?
	let popularity              : Double?
	let profile_path            : String?

	enum CodingKeys: String, CodingKey {

		case adult                  = "adult"
		case also_known_as          = "also_known_as"
		case biography              = "biography"
		case birthday               = "birthday"
		case deathday               = "deathday"
		case gender                 = "gender"
		case homepage               = "homepage"
		case id                     = "id"
		case imdb_id                = "imdb_id"
		case known_for_department   = "known_for_department"
		case name                   = "name"
		case place_of_birth         = "place_of_birth"
		case popularity             = "popularity"
		case profile_path           = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values              = try decoder.container(keyedBy: CodingKeys.self)
		adult                   = try values.decodeIfPresent(Bool.self, forKey: .adult)
		also_known_as           = try values.decodeIfPresent([String].self, forKey: .also_known_as)
		biography               = try values.decodeIfPresent(String.self, forKey: .biography)
		birthday                = try values.decodeIfPresent(String.self, forKey: .birthday)
		deathday                = try values.decodeIfPresent(String.self, forKey: .deathday)
		gender                  = try values.decodeIfPresent(Int.self, forKey: .gender)
		homepage                = try values.decodeIfPresent(String.self, forKey: .homepage)
		id                      = try values.decodeIfPresent(Int.self, forKey: .id)
		imdb_id                 = try values.decodeIfPresent(String.self, forKey: .imdb_id)
		known_for_department    = try values.decodeIfPresent(String.self, forKey: .known_for_department)
		name                    = try values.decodeIfPresent(String.self, forKey: .name)
		place_of_birth          = try values.decodeIfPresent(String.self, forKey: .place_of_birth)
		popularity              = try values.decodeIfPresent(Double.self, forKey: .popularity)
		profile_path            = try values.decodeIfPresent(String.self, forKey: .profile_path)
	}

}
