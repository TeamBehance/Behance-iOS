//
//  MyPageViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    let titles = ["작업", "정보", "무드보드"]
    var page = 0 {
        didSet {
            titleCollectionView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.indicatorView.frame.origin.x = CGFloat(self.page * 60 + 97)
            }
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleCollectionView: UICollectionView!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    @IBOutlet weak var addButtonContainerView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUI()
    }
    
    // MARK: - Function
    
    private func setCollectionView() {
        contentsCollectionView.setCollectionViewLayout(createLayout(), animated: true)
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        titleCollectionView.setCollectionViewLayout(createTitleLayout(), animated: true)
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
    }
    
    private func setUI() {
        setProfileUI()
        setIndicatorUI()
    }
    
    private func setProfileUI() {
        profileBackgroundView.layer.cornerRadius = 55
        profileImageView.layer.cornerRadius = 45
        usernameLabel.font = .NotoSans(.bold, size: 17)
    }
    
    private func setIndicatorUI() {
        indicatorView.layer.cornerRadius = 18
    }
    
    // MARK: - IBAction
    
    @IBAction func projectAddButtonDidTap(_ sender: Any) {
        guard let addProjectViewController = UIStoryboard(name: "AddProject", bundle: nil)
                .instantiateViewController(withIdentifier: "AddProjectViewController") as? AddProjectViewController else { return }
        addProjectViewController.modalPresentationStyle = .fullScreen
        self.present(addProjectViewController, animated: true, completion: nil)
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func createTitleLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(60),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            self?.addButtonContainerView.isHidden = (offset.x >= UIScreen.main.bounds.width)
            self?.page = Int(offset.x / UIScreen.main.bounds.width)
        }
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case titleCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageTitleCollectionViewCell.identifier, for: indexPath) as? MyPageTitleCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(title: titles[indexPath.item], isSelected: page == indexPath.item)
            return cell
        case contentsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageTaskCollectionViewCell.identifier, for: indexPath) as? MyPageTaskCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
