//
//	Photo.swift
//
//	Create by Ahmed Tawfik on 3/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Photo : Decodable {

	let id : String?
	let imagePath : String?


	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case imagePath = "imagePath"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
	}


}
