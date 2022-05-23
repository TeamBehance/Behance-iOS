//
//  HomeViewController.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/14.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var homeTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeTV.layer.cornerRadius = 15.0
    }

}
