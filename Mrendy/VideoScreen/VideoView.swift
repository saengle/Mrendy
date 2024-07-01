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
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(webkitView)
        webkitView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureView(id: String) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(id)") else { return }
        let request = URLRequest(url: url)
        webkitView.load(request)
    }
}
