//
//  storyTableViewCell.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/05/24.
//

import UIKit

class storyTableViewCell: UITableViewCell {
 
    @IBOutlet weak var storyCollectionView: UICollectionView!
 
    static let identifier = "storyTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let storyNib = UINib(nibName: StoryCollectionViewCell.identifier, bundle: nil)
        storyCollectionView.register(storyNib, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
    }
    
}

extension storyTableViewCell: UICollectionViewDelegate {
    
}

extension storyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyDataModel.sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(storyData: storyDataModel.sampleData[indexPath.row])
        return cell
    }
}

extension storyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width * (64/375)
        let cellHeight = CGFloat(100)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
