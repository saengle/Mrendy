//
//  OverViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/25/24.
//

import UIKit

class CastCell: BaseTableViewCell {
    
    let posterIamge = UIImageView()
    let realNameLabel = UILabel()
    let playNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        playNameLabel.font = .systemFont(ofSize: 13)
        playNameLabel.textColor = .systemGray
    }
    
    override func configureHierachy() {
        [posterIamge, realNameLabel, playNameLabel].forEach{contentView.addSubview($0)}
    }
    override func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        posterIamge.backgroundColor = .black
        posterIamge.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.height.equalTo(posterIamge.snp.width).multipliedBy(1.3)
        }
        realNameLabel.text = "기무아무개"
        realNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterIamge.snp.trailing).offset(16)
            make.bottom.equalTo(contentView.snp.centerY).inset(16)
        }
        playNameLabel.text = "이무아무아무개"
        playNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterIamge.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.centerY)
        }
    }
    override func configureCell() {}
}
