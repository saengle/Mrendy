//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit


class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    let apiManager = ApiManager()
    
    var searchedTrendyList: [Trendy] = []
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.callRequestSearch(query: "king") { result in
            switch result {
            case .success(let trendy):
                self.searchedTrendyList = [trendy]
                self.searchView.searchedCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        searchView.searchedCollectionView.dataSource = self
        searchView.searchedCollectionView.delegate = self
        searchView.searchedCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedTrendyList.first?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let data = searchedTrendyList.first?.results?[indexPath.row]
        
        cell.configureCell(url: data?.posterPath ?? "")
        
        return cell
    }
}
