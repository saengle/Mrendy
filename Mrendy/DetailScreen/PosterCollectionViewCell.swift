//
//  PosterCollectionViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/26/24.
//

import UIKit

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
        print("셀 인잇 !!!!!!!!!!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
