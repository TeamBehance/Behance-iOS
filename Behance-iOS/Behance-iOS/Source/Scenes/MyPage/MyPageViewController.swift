//
//  MyPageViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Function
    
    private func setUI() {
        setProfileUI()
    
    }
    
    private func setProfileUI() {
        profileBackgroundView.layer.cornerRadius = 55
        profileImageView.layer.cornerRadius = 45
        usernameLabel.font = .NotoSans(.bold, size: 17)
    }

}
