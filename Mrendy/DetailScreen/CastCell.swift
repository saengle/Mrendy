//
//  OverViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/25/24.
//

import UIKit

import Kingfisher
import SnapKit

final class CastCell: BaseTableViewCell {
    
    private let posterIamge = UIImageView()
    private let realNameLabel = UILabel()
    private let playNameLabel = UILabel()
    
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
            make.height.equalTo(72)
        }
        posterIamge.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
            make.height.equalTo(posterIamge.snp.width).multipliedBy(1.3)
        }
        
        realNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterIamge.snp.trailing).offset(16)
            make.bottom.equalTo(contentView.snp.centerY).inset(16)
        }
        
        playNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterIamge.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.centerY)
        }
    }
    func configureCell(imagePath: String, realName: String, playName: String) {
        realNameLabel.text = realName
        playNameLabel.text = playName
       if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: imagePath))") {
            let processor = DownsamplingImageProcessor(size:  posterIamge.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 5)
            posterIamge.kf.indicatorType = .activity
            posterIamge.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [.processor(processor),
                          .scaleFactor(UIScreen.main.scale),
                          .transition(.fade(1)),
                          .cacheOriginalImage])
        }
    }
}
