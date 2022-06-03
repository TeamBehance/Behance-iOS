//
//  ProjectDataModel.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/06/03.
//

import Foundation

struct ProjectResponse: Codable {
    var status: Int
    var success: Bool?
    var message: String?
    var data: [ProjectData]?
}

struct ProjectData: Codable {
    let _id: String?
    let name: String?
    let photo: String?
    var writer: writerData?
}

struct writerData: Codable {
    let name: String?
    let photo: String?
}

