//
//  FeedTableViewCell.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var feedImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var contensLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
