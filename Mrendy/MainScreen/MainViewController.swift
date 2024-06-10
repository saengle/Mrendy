//
//  MainViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit

import Kingfisher

class MainViewController: UIViewController {
    
    let apiManager = ApiManager()
    let mainView = MainView()
    
    var trendyList: [Trendy] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.callRequestTrendy() { result in
            switch result {
            case .success(let trendy):
                self.trendyList = [trendy]
                self.mainView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.navigationItem.title = "Mrendy"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainView.tableView.reloadData()
    }
}

extension MainViewController {
    @objc func searchButtonTapped() {}
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        let data = trendyList.first?.results?[indexPath.row]
        
        cell.dateLabel.text = data?.releaseDate ?? data?.firstAirDate
        cell.genreLabel.text = data?.title ?? data?.originalName
        
        // backdropPath or posterPath
        if let imagePath = data?.backdropPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: imagePath))") {
                cell.posterImageView.kf.setImage(with: url)
            }
        }
        
        
        return cell
    }
}
