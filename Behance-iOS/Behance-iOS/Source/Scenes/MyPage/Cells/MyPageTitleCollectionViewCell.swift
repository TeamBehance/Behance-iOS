//
//  MyPageTitleCollectionViewCell.swift
//  Behance-iOS
//
//  Created by κΉνμ on 2022/05/27.
//

import UIKit

final class MyPageTitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyPageTitleCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title: String, isSelected: Bool) {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? .white : .behanceDarkgray
        titleLabel.font = .NotoSans(.bold, size: 15)
    }
}
