//
//  MyPageProjectViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/22.
//

import UIKit

final class MyPageProjectViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Function
    
    private func setUI() {
        setLabelUI()
    }
    
    private func setLabelUI() {
        emptyTitleLabel.font = .NotoSans(.bold, size: 17)
        emptyDescriptionLabel.font = .NotoSans(.regular, size: 12)
    }

}
