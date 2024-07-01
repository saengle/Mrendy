//
//  SearchView.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit

import SnapKit


final class SearchView: UIView {
    
    lazy var searchedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3 , height:  width * 4 / 9  )
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    let backButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.returnKeyType = .route
        return sb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func configureUI() {
        self.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        configureHierachy()
        configureLayout()
    }
    
    private func configureHierachy() {
        [searchedCollectionView, backButton, searchBar].forEach{addSubview($0)}
    }
    
    private func configureLayout() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        searchedCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
}
