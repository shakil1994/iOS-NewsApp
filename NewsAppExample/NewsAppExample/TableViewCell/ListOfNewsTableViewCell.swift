//
//  ListOfNewsTableViewCell.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import UIKit

class ListOfNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
