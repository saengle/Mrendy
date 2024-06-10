//
//  MainView.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit

import SnapKit

class MainView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        
        
        tableView.snp.makeConstraints {
            $0.bottom.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
