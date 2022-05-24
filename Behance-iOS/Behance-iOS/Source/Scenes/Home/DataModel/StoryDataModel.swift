//
//  StoryDataModel.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/05/24.
//

import Foundation

struct storyDataModel {
    let storyImg: String
    let userName: String
}

extension storyDataModel {
    static let sampleData: [storyDataModel] = [
        storyDataModel(storyImg: "imgStory3", userName: "+ 추가"),
        storyDataModel(storyImg: "imgStory1", userName: "박인우"),
        storyDataModel(storyImg: "imgStory2", userName: "김혜수"),
        storyDataModel(storyImg: "imgStory1", userName: "강윤서"),
        storyDataModel(storyImg: "imgStory1", userName: "황어진"),
        storyDataModel(storyImg: "imgStory2", userName: "성은정")
    ]
}
