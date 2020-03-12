//
//  ViewController.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!
    
    let apiClient = APIClient()
    var source = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        getNews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! ListOfNewsTableViewCell
    
        cell.newsTitleLabel.text = source[indexPath.row].title
        
        return cell
    }
    
    private func getNews(){
            
            apiClient.getAllNews { [weak self] response in
                switch response {
                case .success(let news):
                    DispatchQueue.main.async {
                        self?.source = news.articles
                        self?.newsTableView.reloadData()
                    }
                case .failure(let error):
                    switch error {
                        case .responseError(let desp):
                            print(desp)
                    }
                }
            }
        }


}

