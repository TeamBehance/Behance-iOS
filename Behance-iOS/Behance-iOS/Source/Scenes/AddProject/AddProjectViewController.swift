//
//  AddProjectViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

final class AddProjectViewController: UIViewController {

    @IBOutlet weak var editorCollectionView: UICollectionView!    
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var editorHeightConstraint: NSLayoutConstraint!
    
    private lazy var photoDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: photoCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { preconditionFailure() }
        cell.configure(image: UIImage(named: itemIdentifier))
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }

    @IBAction func menuDidMoved(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        sender.setTranslation(.zero, in: view)
        switch sender.state {
        case .changed:
            if editorHeightConstraint.constant >= -view.frame.height*0.5 && editorHeightConstraint.constant <= view.frame.height*0.20 {
                editorHeightConstraint.constant += translation.y
            }
        case .ended:
            let percentage = (editorCollectionView.frame.height + translation.y) / view.frame.height
            if percentage > 0.8 {
                editorHeightConstraint.constant = view.frame.height*0.20
            } else if 0.4 < percentage && percentage < 0.8 {
                editorHeightConstraint.constant = 0
            } else {
                editorHeightConstraint.constant = -view.frame.height*0.5
            }
        default:
            break
        }
        
        var alpha = (self.view.frame.height*0.20 - editorHeightConstraint.constant) / 100
        alpha = alpha < 0 ? 0 : alpha
        alpha = alpha > 1 ? 1 : alpha
        
        photoCollectionView.alpha = alpha
    }
    
    private func setCollectionView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        photoCollectionView.setCollectionViewLayout(layout, animated: false)
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        applyDataSource(sections: [0], items: ["imgDummy1","imgDummy2","imgDummy3","imgDummy4","imgDummy5",
                             "imgDummy6","imgDummy7","imgDummy8","imgDummy9","imgDummy10","imgDummy11"])
    }
    
    private func applyDataSource(sections: [Int], items: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections(sections)
        snapshot.appendItems(items)
        photoDataSource.apply(snapshot, animatingDifferences: true)
    }
}
