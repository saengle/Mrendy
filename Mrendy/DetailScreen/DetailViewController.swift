//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    override func loadView(){
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
}

extension DetailViewController {
    private func configureVC() {
        self.detailView.mainTableView.delegate = self
        self.detailView.mainTableView.dataSource = self
        self.detailView.mainTableView.rowHeight = UITableView.automaticDimension
        
        
       
//        self.detailView.mainTableView.cell
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:  Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2...3:
            return 1
        default: return 0
        }
    }
    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    // MARK:  ConfigureCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 0 {
            self.detailView.mainTableView.register(OverViewCell.self, forCellReuseIdentifier: OverViewCell.id)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id, for: indexPath)
                    as? OverViewCell else { return UITableViewCell()}
            print(indexPath.section)
            
            return cell
        } else if indexPath.section == 1 {
            self.detailView.mainTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath)
                    as? CastCell else { return UITableViewCell()}
            print(indexPath.section)
            return cell
        } else {
            self.detailView.mainTableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.id)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.id, for: indexPath)
                    as? VideoListCell else { return UITableViewCell()}
            print(indexPath.section)
            return cell
        }
    }
    // MARK:  Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "OvewView"
        case 1:
            return "Cast"
        case 2...3:
            return "울랄라"
        default: return ""
        }
    }
}
