

import Foundation
struct KnownFor : Codable {
	let adult : Bool?
	let backdrop_path : String?
	let first_air_date : String?
	let genre_ids : [Int]?
	let id : Int?
	let media_type : String?
	let name : String?
	let origin_country : [String]?
	let original_language : String?
	let original_name : String?
	let overview : String?
	let poster_path : String?
	let vote_average : Double?
	let vote_count : Int?

	enum CodingKeys: String, CodingKey {

		case adult              = "adult"
		case backdrop_path 		= "backdrop_path"
		case first_air_date     = "first_air_date"
		case genre_ids          = "genre_ids"
		case id                 = "id"
		case media_type         = "media_type"
		case name               = "name"
		case origin_country     = "origin_country"
		case original_language  = "original_language"
		case original_name      = "original_name"
		case overview           = "overview"
		case poster_path        = "poster_path"
		case vote_average       = "vote_average"
		case vote_count         = "vote_count"
	}

	init(from decoder: Decoder) throws {
		let values          = try decoder.container(keyedBy: CodingKeys.self)
		adult               = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdrop_path       = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		first_air_date      = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		genre_ids           = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		id                  = try values.decodeIfPresent(Int.self, forKey: .id)
		media_type          = try values.decodeIfPresent(String.self, forKey: .media_type)
		name                = try values.decodeIfPresent(String.self, forKey: .name)
		origin_country      = try values.decodeIfPresent([String].self, forKey: .origin_country)
		original_language   = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_name       = try values.decodeIfPresent(String.self, forKey: .original_name)
		overview            = try values.decodeIfPresent(String.self, forKey: .overview)
		poster_path         = try values.decodeIfPresent(String.self, forKey: .poster_path)
		vote_average        = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		vote_count          = try values.decodeIfPresent(Int.self, forKey: .vote_count)
	}

}
