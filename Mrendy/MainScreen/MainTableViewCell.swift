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
    static let id = String(describing: MainTableViewCell.self)
    
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let posterImageView = UIImageView()
    
    let deetailStackView = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
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
        
        [titleLabel, descriptionLabel, lineView, horizontalStackView].forEach{deetailStackView.addSubview($0)}
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
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
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
        
        descriptionLabel.text = "배우이름이 이러쿵 저러쿵"
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = .systemFont(ofSize: 12)
        
        lineView.backgroundColor = .black
        
        detailLabel.text = "자세히보기"
        detailLabel.font = .systemFont(ofSize: 12)
        
        arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        arrowButton.tintColor = .black
    }
    func configureCellData(data: Results, genre: String) {
        dateLabel.text = data.releaseDate ?? data.firstAirDate
        
        //Image  backdropPath or posterPath
        if let imagePath = data.backdropPath {
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
        
        titleLabel.text = data.title ?? data.name
        descriptionLabel.text = data.overview
        genreLabel.text = genre
    }
}
