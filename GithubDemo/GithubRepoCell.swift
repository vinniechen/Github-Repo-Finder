//
//  GithubRepoCell.swift
//  GithubDemo
//
//  Created by Vinnie Chen on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class GithubRepoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var forkImage: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
