

import Foundation

struct Cast : Codable {
	let genre_ids               : [Int]?
	let id                      : Int?
	let original_language       : String?
	let original_title          : String?
	let poster_path             : String?
	let video                   : Bool?
	let vote_average            : Double?
	let overview                : String?
	let release_date            : String?
	let vote_count              : Int?
	let title                   : String?
	let adult                   : Bool?
	let backdrop_path           : String?
	let popularity              : Double?
	let character               : String?
	let credit_id               : String?
	let order                   : Int?

	enum CodingKeys: String, CodingKey {

		case genre_ids          = "genre_ids"
		case id                 = "id"
		case original_language  = "original_language"
		case original_title     = "original_title"
		case poster_path        = "poster_path"
		case video              = "video"
		case vote_average       = "vote_average"
		case overview           = "overview"
		case release_date       = "release_date"
		case vote_count         = "vote_count"
		case title              = "title"
		case adult              = "adult"
		case backdrop_path      = "backdrop_path"
		case popularity         = "popularity"
		case character          = "character"
		case credit_id          = "credit_id"
		case order              = "order"
	}

	init(from decoder: Decoder) throws {
		let values              = try decoder.container(keyedBy: CodingKeys.self)
		genre_ids               = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		id                      = try values.decodeIfPresent(Int.self, forKey: .id)
		original_language       = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_title          = try values.decodeIfPresent(String.self, forKey: .original_title)
		poster_path             = try values.decodeIfPresent(String.self, forKey: .poster_path)
		video                   = try values.decodeIfPresent(Bool.self, forKey: .video)
		vote_average            = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		overview                = try values.decodeIfPresent(String.self, forKey: .overview)
		release_date            = try values.decodeIfPresent(String.self, forKey: .release_date)
		vote_count              = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		title                   = try values.decodeIfPresent(String.self, forKey: .title)
		adult                   = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdrop_path           = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		popularity              = try values.decodeIfPresent(Double.self, forKey: .popularity)
		character               = try values.decodeIfPresent(String.self, forKey: .character)
		credit_id               = try values.decodeIfPresent(String.self, forKey: .credit_id)
		order                   = try values.decodeIfPresent(Int.self, forKey: .order)
	}

}
