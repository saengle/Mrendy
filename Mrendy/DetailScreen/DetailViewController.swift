//
//  SearchViewController.swift
//  Mrendy
//
//  Created by 쌩 on 6/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    override func loadView(){
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
}

extension DetailViewController {
    private func configureVC() {
        self.detailView.mainTableView.delegate = self
        self.detailView.mainTableView.dataSource = self
        self.detailView.mainTableView.rowHeight = UITableView.automaticDimension
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
            let cell = UITableViewCell()
        cell.backgroundColor = .brown
        return cell
    }
 
}
