//
//  VideoView.swift
//  Mrendy
//
//  Created by 쌩 on 7/2/24.
//

import UIKit
import WebKit

import SnapKit

class VideoView: UIView {
    
    let webkitView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .cyan
        configureUI()
        
        callRequest()
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(webkitView)
        webkitView.backgroundColor = .brown
        webkitView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        let tempKey = "fkjs_kY1F7Q"
        let key = tempKey
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else { return }
        let request = URLRequest(url: url)
        webkitView.load(request)
        
    }
    
    func fetchData() {
    }
    func callRequest() {
        
        "https://developer.themoviedb.org/reference/tv-series-videos"
    }
}
