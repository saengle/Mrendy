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
    
    let deetailStackView = UIStackView()
    let titleLabel = UILabel()
    let actorsLabel = UILabel()
    let lineView = UIView()
    let horizontalStackView = UIStackView()
    let detailLabel = UILabel()
    let arrowButton = UIButton()
    
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
        self.addSubview(deetailStackView)
        
        [titleLabel, actorsLabel, lineView, horizontalStackView].forEach{deetailStackView.addSubview($0)}
        [detailLabel, arrowButton].forEach{horizontalStackView.addSubview($0)}
        
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
        
        deetailStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo( 3 * (phoneScreenWidth / 10) )
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
        }
        actorsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(actorsLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(1)
        }
        
        horizontalStackView.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        arrowButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(4)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
    
    func configureUI() {
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        
        genreLabel.font = .boldSystemFont(ofSize: 17)
        
        deetailStackView.backgroundColor = .white
        
        titleLabel.text = "테스트용 타이틀"
        
        actorsLabel.text = "배우이름이 이러쿵 저러쿵"
        actorsLabel.textColor = .systemGray
        actorsLabel.font = .systemFont(ofSize: 12)
        
        lineView.backgroundColor = .black
        
        detailLabel.text = "자세히보기"
        detailLabel.font = .systemFont(ofSize: 12)
        
        arrowButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        
    }
}
