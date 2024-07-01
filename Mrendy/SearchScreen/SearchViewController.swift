//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit


class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    
    var searchedResultsList: [Results] = []
    var myPage = 1
    var totalPage = 1
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        navigationController?.isNavigationBarHidden = true
        //collection view, cell 연결 및 등록
        searchView.searchedCollectionView.dataSource = self
        searchView.searchedCollectionView.delegate = self
        searchView.searchedCollectionView.prefetchDataSource = self
        searchView.searchedCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        
        searchView.searchBar.delegate = self
        hideKeyboard()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
extension SearchViewController {
    @objc
    private func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedResultsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let data = searchedResultsList[indexPath.row]
        cell.configureCell(url: data.posterPath ?? data.backdropPath ?? "")
        
        return cell
    }
    // MARK:  페이징 처리
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
         let totalPages = self.totalPage
         let myListCount = self.searchedResultsList.count
        guard let query = self.searchView.searchBar.text else { return }
        for item in indexPaths {
            // 현재 스크롤이 마지막에서 2번째를 보고있고, mypage < tatalpage 이면 추가검색
            if myListCount - 2 == item.row && self.myPage < totalPages {
                myPage += 1
                ApiManager.shared.callRequestTMDB(api: APIModel.searchAll(query: query, page: myPage), type: Trendy.self) { result in
                    switch result {
                    case .success(let trendy):
                        guard let myTrendyResult = trendy.results else { return }
                        self.searchedResultsList.append(contentsOf: myTrendyResult)
                        self.searchView.searchedCollectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    // MARK:  cell touch -> DetailScreen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell {
            let vc = DetailViewController()
            if let tempID = searchedResultsList[indexPath.item].id?.codingKey.stringValue,
                let tempOverview = searchedResultsList[indexPath.item].overview?.codingKey.stringValue {
                vc.id = tempID
                vc.overView = tempOverview
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    // MARK:  Search button clicked - search api
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 페이지네이션 위한 페이지 1로 리셋.
        guard let query = searchBar.text else {return}
        self.myPage = 1
        ApiManager.shared.callRequestTMDB(api: APIModel.searchAll(query: query, page: myPage), type: Trendy.self) { result in
            switch result {
            case .success(let trendy):
                guard let myTrendyResult = trendy.results else { return }
                self.searchedResultsList = myTrendyResult
                guard let total = trendy.totalPages else { return }
                self.totalPage = total
                self.searchView.searchedCollectionView.scrollsToTop = true
                self.searchView.searchedCollectionView.reloadData()
                self.searchView.searchedCollectionView.scrollsToTop = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        dismissKeyboard()
    }
    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
