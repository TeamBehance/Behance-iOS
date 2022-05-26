//
//  StoryCollectionViewCell.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "StoryCollectionViewCell"
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var storyImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(storyData : storyDataModel) {
        userName.text = storyData.userName
        storyImg.image = UIImage(named: storyData.storyImg)
    }

}
