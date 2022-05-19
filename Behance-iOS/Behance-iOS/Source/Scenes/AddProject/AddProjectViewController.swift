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
            if editorHeightConstraint.constant >= -view.frame.height*0.5 {
                editorHeightConstraint.constant += translation.y
            }
        case .ended:
            print(sender.velocity(in: view))
            UIView.animate(withDuration: 1000) {
                let percentage = (self.editorCollectionView.frame.height + translation.y) / self.view.frame.height
                if percentage > 0.8 {
                    self.editorHeightConstraint.constant = self.view.frame.height*0.35 - 120
                } else if 0.4 < percentage && percentage < 0.8 {
                    self.editorHeightConstraint.constant = 0
                } else {
                    self.editorHeightConstraint.constant = -self.view.frame.height*0.5
                }
            }
        default:
            break
        }
        
        var opacity = (view.frame.height*0.35 - 120 - editorHeightConstraint.constant) / 100
        opacity = opacity < 0 ? 0 : opacity
        opacity = opacity > 1 ? 1 : opacity
        
        photoCollectionView.alpha = opacity
    }
}
