//
//  PosterCollectionViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/26/24.
//

import UIKit

import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.backgroundColor = .black
        posterImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        posterImageView.backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCollectionViewCell(imagePath: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: imagePath))") {
             let processor = DownsamplingImageProcessor(size:  posterImageView.bounds.size)
             |> RoundCornerImageProcessor(cornerRadius: 5)
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(
                 with: url,
                 placeholder: UIImage(named: "placeholderImage"),
                 options: [.processor(processor),
                           .scaleFactor(UIScreen.main.scale),
                           .transition(.fade(1)),
                           .cacheOriginalImage])
         }
    }
}
