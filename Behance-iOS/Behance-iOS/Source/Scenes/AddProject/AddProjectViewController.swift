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
    private let editorBackgroundView = EditorBackgroundView()
    
    private var editorDummyArray = [EditorIdentifier]()
    private lazy var editorDataSource = UICollectionViewDiffableDataSource<Int, EditorIdentifier>(collectionView: editorCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: EditorIdentifier) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { preconditionFailure() }
        cell.configure(image: UIImage(named: itemIdentifier.name))
        return cell
    }
    
    private var photoDummyArray = ["imgDummy1","imgDummy2","imgDummy3","imgDummy4","imgDummy5",
                                   "imgDummy6","imgDummy7","imgDummy8","imgDummy9","imgDummy10","imgDummy11"]
    private lazy var photoDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: photoCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { preconditionFailure() }
        cell.configure(image: UIImage(named: itemIdentifier))
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEditorCollectionView()
        configurePhotoCollectionView()
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
    
    private func configureEditorCollectionView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        editorCollectionView.setCollectionViewLayout(layout, animated: false)
        editorCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        editorCollectionView.delegate = self
        editorCollectionView.backgroundView = editorBackGroundView
        applyToEditorCollectionView()
    }
    
    private func configurePhotoCollectionView() {
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
        photoCollectionView.delegate = self
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(photoDummyArray)
        photoDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyToEditorCollectionView() {
        editorBackGroundView.alpha = editorDummyArray.isEmpty ? 1 : 0
        var snapshot = NSDiffableDataSourceSnapshot<Int, EditorIdentifier>()
        snapshot.appendSections([0])
        snapshot.appendItems(editorDummyArray)
        editorDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AddProjectViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView === photoCollectionView else { return }
        editorDummyArray.append(EditorIdentifier(id: UUID(), name: photoDummyArray[indexPath.item]))
        applyToEditorCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard collectionView === editorCollectionView else { return nil }
        if editorDummyArray.isEmpty { return nil }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let delete = UIAction(title: NSLocalizedString("삭제", comment: String()),
                                  image: UIImage(systemName: "trash")) { [weak self] _ in
                self?.editorDummyArray.remove(at: indexPath.item)
                self?.applyToEditorCollectionView()
            }
            return UIMenu(title: "이 사진을", children: [delete])
        })
    }
    
}

struct EditorIdentifier: Hashable {
    var id: UUID
    var name: String
}

final class EditorBackgroundView: UIView {
    
    static let identifier = "EditorDefaultCollectionViewCell"
    private let wholeStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .white
        
        imageView.image = Const.Image.grid
        wholeStackView.addArrangedSubview(imageView)
        
        titleLabel.text = "프로젝트 시작"
        wholeStackView.addArrangedSubview(titleLabel)
        
        contentLabel.text = "아래 툴을 사용하여 내 프로젝트에\n콘텐츠를 추가할 수 있습니다."
        contentLabel.numberOfLines = 2
        wholeStackView.addArrangedSubview(contentLabel)
        
        self.addSubview(wholeStackView)
        wholeStackView.spacing = 20
        wholeStackView.alignment = .center
        wholeStackView.axis = .vertical
        wholeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wholeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wholeStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
