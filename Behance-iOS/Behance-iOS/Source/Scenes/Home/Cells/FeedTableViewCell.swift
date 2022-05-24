//
//  FeedTableViewCell.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    static let identifier = "FeedTableViewCell"
    
    @IBOutlet weak var feedImg: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundContainerView.layer.shadowColor = UIColor.black.cgColor
        backgroundContainerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        backgroundContainerView.layer.shadowRadius = 10.0
        backgroundContainerView.layer.shadowOpacity = 0.5
        backgroundContainerView.layer.cornerRadius = 10
        feedImg.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        feedImg.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Custom Methods
extension FeedTableViewCell {
    func setData(_ feedData: FeedDataModel) {
        userImg.image = UIImage(named: feedData.userImage)
        feedImg.image = UIImage(named: feedData.contentImage)
        contentLabel.text = feedData.content
        userNameLabel.text = feedData.userName
    }
}
