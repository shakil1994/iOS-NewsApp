//
//  NewsDetailsViewController.swift
//  iOSNewsApp
//
//  Created by MAC on 10/23/21.
//  Copyright © 2021 DhakaLive. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    var newsDetailsData : Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        print("newsDetailsData : ",newsDetailsData)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
