//
//  FeedDataModel.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/05/24.
//

import UIKit

struct FeedDataModel {
    let userImage: String
    let userName: String
    let contentImage: String
    let content: String
}

// 더미데이터
extension FeedDataModel {
    static let sampleData: [FeedDataModel] = [
        FeedDataModel(userImage: "userimg", userName: "김혜수", contentImage: "imgDummy1", content: "솝트짱"),
        FeedDataModel(userImage: "userimg", userName: "박인우", contentImage: "imgDummy2", content: "30기"),
        FeedDataModel(userImage: "userimg", userName: "강윤서", contentImage: "imgDummy3", content: "어쩌구"),
        FeedDataModel(userImage: "userimg", userName: "황어진", contentImage: "imgDummy4", content: "iOS"),
        FeedDataModel(userImage: "userimg", userName: "이영주", contentImage: "imgDummy5", content: "과제는"),
        FeedDataModel(userImage: "userimg", userName: "이창환", contentImage: "imgDummy6", content: "미리미리"),
        FeedDataModel(userImage: "userimg", userName: "박현지", contentImage: "imgDummy7", content: "디자인1"),
        FeedDataModel(userImage: "userimg", userName: "성은정", contentImage: "imgDummy8", content: "디자인2"),
        FeedDataModel(userImage: "userimg", userName: "이서우", contentImage: "imgDummy9", content: "디자인3"),
        FeedDataModel(userImage: "userimg", userName: "정지연", contentImage: "imgDummy10", content: "디자인4"),
        ]
}
