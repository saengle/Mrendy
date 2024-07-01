//
//  VideoScreen.swift
//  Mrendy
//
//  Created by 쌩 on 7/2/24.
//

import UIKit

class VideoViewController: UIViewController {
    
    let videoView = VideoView()
    
    override func loadView() {
        view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
