//
//  SearchView.swift
//  Mrendy
//
//  Created by 쌩 on 6/12/24.
//

import UIKit

import SnapKit

class DetailView: UIView {
    
    let backgroundPosterImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let posterImageView = UIImageView()
   
    let mainTableView = {
        let tb = UITableView()
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [backgroundPosterImageView, posterImageView, mainTableView].forEach{addSubview($0)}
    }
    private func configureLayout() {
        backgroundPosterImageView.backgroundColor = .systemMint
        backgroundPosterImageView.snp.makeConstraints{
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        posterImageView.backgroundColor = .white
        posterImageView.snp.makeConstraints{
            $0.top.bottom.equalTo(backgroundPosterImageView).inset(16)
            $0.leading.equalTo(backgroundPosterImageView.snp.leading).inset(16)
            $0.width.equalTo(posterImageView.snp.height).multipliedBy(1.0 / 1.3)
        }
        mainTableView.backgroundColor = .green
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(backgroundPosterImageView.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    private func configureView() {}
}
