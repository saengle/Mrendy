//
//  OverViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/25/24.
//

import UIKit

class VideoListCell: BaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        contentView.backgroundColor = .black
    }
    
    override func configureHierachy() {}
    override func configureLayout() {}
    override func configureCell() {}
}