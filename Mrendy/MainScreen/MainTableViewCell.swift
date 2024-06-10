//
//  MainTableViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit

import Kingfisher
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let posterImageView = UIImageView()
    
    
    let phoneScreenWidth = UIScreen.main.bounds.size.width
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierachy() {
        self.addSubview(dateLabel)
        self.addSubview(genreLabel)
        self.addSubview(posterImageView)
        
    }
    private func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(4)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(4)
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.bottom.equalTo(posterImageView.snp.top).offset(-8)
            make.height.equalTo(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(phoneScreenWidth - 40)
        }
    }
    
    func configureUI() {
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        
        genreLabel.font = .boldSystemFont(ofSize: 17)
        
    }
}
