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
        
        homeTV.register(UINib(nibName: storyTableViewCell.identifier, bundle: nil),
                        forCellReuseIdentifier: storyTableViewCell.identifier)
        
        homeTV.delegate = self
        homeTV.dataSource = self
        
        story()
        project()
        
        
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 380
    }
}

extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return FeedDataModel.sampleData.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: storyTableViewCell.identifier, for: indexPath) as? storyTableViewCell else { return UITableViewCell() }
            //cell.setData(storyData: storyDataModel.sampleData[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
            cell.setData(FeedDataModel.sampleData[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController {
    func story() {
        HomeService.shared.story { response in
            switch response {
            case .success(let data):
                guard let data = data as? StoryResponse else { return }
                print(data)
                print("된다")
            default:
                print("!@!#!@")
                return
            }
        }
    }
    
    func project() {
        HomeService.shared.project { response in
            switch response {
            case .success(let data):
                guard let data = data as? ProjectResponse else { return }
                print(data)
                print("프로젝트 가져오기")
            default:
                return

            }
        }
    }
}
