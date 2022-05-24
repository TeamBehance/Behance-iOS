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
        storyDataModel(storyImg: "imgStoryDummy3", userName: "+ 추가"),
        storyDataModel(storyImg: "imgStoryDummy1", userName: "박인우"),
        storyDataModel(storyImg: "imgStoryDummy2", userName: "김혜수"),
        storyDataModel(storyImg: "imgStoryDummy1", userName: "강윤서"),
        storyDataModel(storyImg: "imgStoryDummy1", userName: "황어진"),
        storyDataModel(storyImg: "imgStoryDummy2", userName: "성은정")
    ]
}
