//
//  AddProjectViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit
import Photos

final class AddProjectViewController: UIViewController {
    
    struct EditorIdentifier: Hashable {
        var id: UUID
        var image: UIImage
    }
    
    @IBOutlet weak var editorCollectionView: UICollectionView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var editorHeightConstraint: NSLayoutConstraint!
    private let editorBackgroundView = EditorBackgroundView()
    
    private var editorPhotoArray = [EditorIdentifier]()
    private lazy var editorDataSource = UICollectionViewDiffableDataSource<Int, EditorIdentifier>(collectionView: editorCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: EditorIdentifier) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { preconditionFailure() }
        cell.configure(image: itemIdentifier.image)
        return cell
    }
    
    private var photoArray = [UIImage]()
    private lazy var photoDataSource = UICollectionViewDiffableDataSource<Int, UIImage>(collectionView: photoCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: UIImage) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { preconditionFailure() }
        cell.configure(image: itemIdentifier)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPermissionIfNecessary { [weak self] granted in
            if granted {
                self?.getImageFromGallery()
                self?.applyToPhotoCollectionView()
            }
        }
        configureEditorCollectionView()
        configurePhotoCollectionView()
    }
    
    private func getPermissionIfNecessary(completion: @escaping (Bool) -> (Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        case .authorized:
            completion(true)
        default:
            completion(false)
        }
    }
    
    private func getImageFromGallery() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let allPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
        allPhotos.enumerateObjects { (asset, count, stop) in
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(asset.pixelHeight) * UIScreen.main.bounds.width/CGFloat(asset.pixelWidth))
            let imageManager = PHImageManager.default()
            let optinos = PHImageRequestOptions()
            optinos.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: optinos, resultHandler: { [weak self] (image, info) in
                if let image = image {
                    self?.photoArray.append(image)
                }
            })
        }
    }
    
    private func configureEditorCollectionView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        editorCollectionView.collectionViewLayout = layout
        editorCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        editorCollectionView.delegate = self
        editorCollectionView.backgroundView = editorBackgroundView
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
        applyToPhotoCollectionView()
    }
    
    private func applyToPhotoCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(photoArray)
        photoDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyToEditorCollectionView() {
        editorBackgroundView.alpha = editorPhotoArray.isEmpty ? 1 : 0
        var snapshot = NSDiffableDataSourceSnapshot<Int, EditorIdentifier>()
        snapshot.appendSections([0])
        snapshot.appendItems(editorPhotoArray)
        editorDataSource.apply(snapshot, animatingDifferences: true)
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
    
}

extension AddProjectViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView === photoCollectionView else { return }
        editorPhotoArray.append(EditorIdentifier(id: UUID(), image: photoArray[indexPath.item]))
        applyToEditorCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard collectionView === editorCollectionView else { return nil }
        if editorPhotoArray.isEmpty { return nil }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let delete = UIAction(title: NSLocalizedString("삭제", comment: String()),
                                  image: UIImage(systemName: "trash")) { [weak self] _ in
                self?.editorPhotoArray.remove(at: indexPath.item)
                self?.applyToEditorCollectionView()
            }
            return UIMenu(title: "이 사진을", children: [delete])
        })
    }
    
}
