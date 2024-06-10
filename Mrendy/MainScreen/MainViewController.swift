//
//  MainViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit


class MainViewController: UIViewController {
    
    let apiManager = ApiManager()
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.callRequestTrendy() { results in
            print(results)
        }
        self.navigationItem.title = "Mrendy"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
}

extension MainViewController {
    @objc func searchButtonTapped() {}
}
