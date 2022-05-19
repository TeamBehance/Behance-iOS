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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
