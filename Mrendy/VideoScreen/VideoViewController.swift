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
        callRequest()
        
    }

    func callRequest() {
        ApiManager.shared.callRequestTMDB(api: APIModel.movieVideo(id: 786892), type: Video.self) { result in
            switch result {
            case .success(let video):
                guard let id = video.results?.first?.key else { return }
                self.videoView.configureView(id: id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
