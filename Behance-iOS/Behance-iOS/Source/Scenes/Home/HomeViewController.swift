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
        
        let nib = UINib(nibName: FeedTableViewCell.identifier, bundle: nil)
        homeTV.register(nib, forCellReuseIdentifier: FeedTableViewCell.identifier)
        
        homeTV.delegate = self
        homeTV.dataSource = self
        
        
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedDataModel.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.setData(FeedDataModel.sampleData[indexPath.row])
        
        return cell
    }
}
