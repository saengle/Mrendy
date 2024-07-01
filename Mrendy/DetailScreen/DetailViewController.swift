//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/12/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    lazy var id = ""
    private let detailView = DetailView()
    lazy var castList: [Cast] = []
    lazy var overView: String = ""
    lazy var backdropPath: String = ""
    lazy var posterPath: String = ""
    lazy var similarAndRecommendList: [[Results]] = [[],[]]
    
    override func loadView(){
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.mainTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}

extension DetailViewController {
    private func configureVC() {
        navigationController?.isNavigationBarHidden = false
        self.detailView.mainTableView.delegate = self
        self.detailView.mainTableView.dataSource = self
        self.detailView.mainTableView.rowHeight = UITableView.automaticDimension
        self.detailView.mainTableView.register(OverViewCell.self, forCellReuseIdentifier: OverViewCell.id)
        self.detailView.mainTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
        self.detailView.mainTableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.id)
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        // MARK:  Main View Posters
        group.enter()
        DispatchQueue.global().async(group: group) {
            if let tempId = Int(self.id) {
                ApiManager.shared.callRequestTMDB(api: APIModel.movieDetail(id: tempId), type: VideoDetail.self) { result in
                    switch result {
                    case .success(let detail):
                        print(detail)
                        guard let tempBackdropPath = detail.backdropPath else { return }
                        guard let tempPosterPath = detail.posterPath else { return }
                        self.detailView.configureView(backdropPath: tempBackdropPath, posterPath: tempPosterPath)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.leave()
        }
        // MARK:  TableView 2nd cell : Cast's Profiles
        group.enter()
        DispatchQueue.global().async(group: group) {
            if let tempId = Int(self.id) {
                ApiManager.shared.callRequestTMDB(api:APIModel.movieCredit(id: tempId), type: MovieCredit.self) { result in
                    switch result {
                    case .success(let credit):
                        guard let myTrendyResult = credit.cast else { return }
                        self.castList.append(contentsOf: myTrendyResult)
                        self.detailView.mainTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.leave()
        }
        // MARK:  TableView 3rd cell(CollectionView) Similar Movies
        group.enter()
        DispatchQueue.global().async(group: group) {
            if let tempId = Int(self.id) {
                ApiManager.shared.callRequestTMDB(api: APIModel.movieSimilar(id: tempId, page: 1), type: Trendy.self) { result in
                    switch result {
                    case .success(let trendy):
                        guard let trendyResults = trendy.results else { return }
                        self.similarAndRecommendList[0] = trendyResults
                        //pagenation위한 페이지 필요
                        self.detailView.mainTableView.reloadSections(IndexSet(integer: 2), with: .automatic)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.leave()
        }
        // MARK:  TableView 4th cell(CollectionView) Recommendation Movies
        group.enter()
        DispatchQueue.global().async(group: group) {
            if let tempId = Int(self.id) {
                ApiManager.shared.callRequestTMDB(api: APIModel.movieRecommend(id: tempId, page: 1), type: Trendy.self) { result in
                    switch result {
                    case .success(let trendy):
                        guard let trendyResults = trendy.results else { return }
                        self.similarAndRecommendList[1] = trendyResults
                        //pagenation위한 페이지 필요
                        self.detailView.mainTableView.reloadSections(IndexSet(integer: 3), with: .automatic)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.detailView.mainTableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:  Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // only overview
        case 1:
            return castList.count // cast's profiles
        case 2...3:
            return 1 // only collectionView
        default: return 0
        }
    }
    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    // MARK:  ConfigureCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: TableView 1st section OverView
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id, for: indexPath)
                    as? OverViewCell else { return UITableViewCell()}
            cell.configureCell(overView: overView)
            return cell
        }
        // MARK: TableView 2nd section Cast Image & Names
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath)
                    as? CastCell else { return UITableViewCell()}
            let data = castList[indexPath.row]
            guard let imagePath = data.profilePath else { return UITableViewCell() }
            guard let realName = data.originalName else { return UITableViewCell() }
            guard let name = data.character else { return UITableViewCell() }
            cell.configureCell(imagePath: imagePath, realName: realName, playName: name)
            return cell
        }
        // MARK:  TableView 3rd, 4th Section Similar & Recommendation Posters
        else if indexPath.section == 2 || indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.id, for: indexPath)
                    as? VideoListCell else { return UITableViewCell()}
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
            cell.collectionView.tag = indexPath.section - 2
            cell.collectionView.reloadData()
            return cell
        }  else { return UITableViewCell() }
    }
    // MARK:  Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "OvewView"
        case 1:
            return "Cast"
        case 2:
            return "Similar"
        case 3:
            return "Recommend"
        default: return ""
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarAndRecommendList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        if let data = similarAndRecommendList[collectionView.tag][indexPath.item].posterPath {
            cell.configureCollectionViewCell(imagePath: data)
        }
        return cell
    }
}
