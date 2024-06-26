//
//  OverViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/25/24.
//

import UIKit

import SnapKit

class VideoListCell: BaseTableViewCell {
    
    static let id = String(describing: VideoListCell.self)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 120)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        configureCell()
    }
    
    override func configureHierachy() {
        contentView.addSubview(collectionView)
    }
    override func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(contentView)
        }
    }
    override func configureCell() {
    }
}
