//
//  SearchCollectionViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit

import Kingfisher
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let searchedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(searchedImageView)
        searchedImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(url: String) {
        let stringUrl = "https://image.tmdb.org/t/p/w500" + url
        let url = URL(string: stringUrl)
                let processor = DownsamplingImageProcessor(size: searchedImageView.bounds.size)
//                |> RoundCornerImageProcessor(cornerRadius: 5)
        searchedImageView.kf.indicatorType = .activity
        searchedImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [.processor(processor),
                              .scaleFactor(UIScreen.main.scale),
                              .transition(.fade(1)),
                              .cacheOriginalImage])
    }
}
