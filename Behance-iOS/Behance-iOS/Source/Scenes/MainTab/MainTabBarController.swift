//
//  MainTabBarController.swift
//  Behance-iOS
//
//  Created by κΉνμ on 2022/05/17.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.tabBar.unselectedItemTintColor = .behanceBlack
        self.tabBar.tintColor = .behanceBlue
        self.tabBar.backgroundColor = .white.withAlphaComponent(0.7)
    }
}
