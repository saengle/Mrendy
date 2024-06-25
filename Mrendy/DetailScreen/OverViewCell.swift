//
//  OverViewCell.swift
//  Mrendy
//
//  Created by 쌩 on 6/25/24.
//

import UIKit

import SnapKit

class OverViewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 13)
    return lb
    }()
    let resizeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        overviewLabel.text = "아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글아주아주긴글긴글긴글긴글긴글"
        overviewLabel.numberOfLines = 3
        resizeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        resizeButton.tintColor = .black
    }
    
    override func configureHierachy() {
        contentView.addSubview(overviewLabel)
        contentView.addSubview(resizeButton)
    }
    override func configureLayout() {
        overviewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(28)
        }
        resizeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
    }
    override func configureCell() {}
}
