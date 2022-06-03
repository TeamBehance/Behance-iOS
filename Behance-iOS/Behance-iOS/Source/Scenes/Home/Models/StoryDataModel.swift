//
//  StoryDataModel.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/06/03.
//

import Foundation

struct StoryResponse: Codable {
    var status: Int
    var success: Bool?
    var message: String?
    var data: [Story]?
}

struct Story: Codable {
    let _id: String?
    let name: String?
    let photo: String?
}
