//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var id = ""
    let detailView = DetailView()
    let apiManager = ApiManager()
    lazy var castList: [Cast] = []
    lazy var overView: String = ""
    lazy var backdropPath: String = ""
    lazy var posterPath: String = ""
    override func loadView(){
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        fetchData()
        
        
    }
}

extension DetailViewController {
    private func configureVC() {
        self.detailView.mainTableView.delegate = self
        self.detailView.mainTableView.dataSource = self
        self.detailView.mainTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.callRequestCredit(id: self.id) { result in
                switch result {
                case .success(let credit):
                    guard let myTrendyResult = credit.cast else { return }
                    self.castList.append(contentsOf: myTrendyResult)
                    self.detailView.mainTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            group.leave()
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.apiManager.callRequestDetail(id: self.id) { result in
                switch result {
                case .success(let detail):
                    guard let tempOverView = detail.overview else { return }
                    self.overView = tempOverView
                    
                    guard let tempBackdropPath = detail.backdropPath else { return }
                    guard let tempPosterPath = detail.posterPath else { return }
                    self.detailView.configureView(backdropPath: tempBackdropPath, posterPath: tempPosterPath)
                    self.detailView.mainTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
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
            return 1
        case 1:
            return castList.count
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
            cell.configureCell(overView: overView)
            return cell
        } else if indexPath.section == 1 {
            self.detailView.mainTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath)
                    as? CastCell else { return UITableViewCell()}
             let data = castList[indexPath.row]
            guard let imagePath = data.profilePath else { return UITableViewCell() }
            guard let realName = data.originalName else { return UITableViewCell() }
            guard let name = data.character else { return UITableViewCell() }
            cell.configureCell(imagePath: imagePath, realName: realName, playName: name)
            return cell
        } else if indexPath.section == 2 || indexPath.section == 3 {
            self.detailView.mainTableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.id)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.id, for: indexPath)
                    as? VideoListCell else { return UITableViewCell()}
   
            return cell
        } else { return UITableViewCell() }
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

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        cell.backgroundColor = .gray
            print("셀이 불러와지질 않아 !?")
        return cell
    }
}
