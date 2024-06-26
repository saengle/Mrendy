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
    
    var trendyList: [Results] = []
    var page = 1
    var totalPage = 1
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.callRequestTrendy(api: APIModel.trendingAll(period: Period.week, page: 1)) { result in
            switch result {
            case .success(let trendy):
                guard let trendyResults = trendy.results else { return }
                self.trendyList = trendyResults
                guard let updatedTotalPage = trendy.totalPages else { return }
                self.totalPage = updatedTotalPage
                self.mainView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.navigationItem.title = "Mrendy"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.prefetchDataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainView.tableView.reloadData()
    }
}

extension MainViewController {
    @objc func searchButtonTapped() {
        let searchVC = SearchViewController()
        self.navigationController?.modalPresentationStyle = .fullScreen
        //        let nav = UINavigationController(rootViewController: searchVC)
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.modalTransitionStyle = .crossDissolve
        present(searchVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        
        let data = trendyList[indexPath.row]
        // 장르 가져오기 (Int -> String)
        var genreString = "#"
        if let genreID = data.genreIDS?.first {
            if let genre = Genres.Genre[genreID] {
                genreString = genreString + genre
            }
        }
        
        // 셀에 데이터 넣어주기.
        cell.configureCellData(data: data, genre: genreString)
        
        return cell
    }
    // MARK:  cell touch -> DetailScreen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.id = String(describing: trendyList[indexPath.row].id)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if trendyList.count - 2 == item.row && self.page < self.totalPage {
                page += 1
                apiManager.callRequestTrendy(api: APIModel.trendingAll(period: Period.week, page: page)) { result in
                    switch result {
                    case .success(let trendy):
                        guard let trendyResults = trendy.results else { return }
                        self.trendyList.append(contentsOf: trendyResults)
                        self.mainView.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
