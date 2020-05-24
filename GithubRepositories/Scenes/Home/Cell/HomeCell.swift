//
//  HomeCell.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    func set(with item: GithubRepository) {
        self.ownerImageView.loadFrom(url: item.owner?.avatarUrl)
        self.repositoryNameLabel.text = item.fullName
        self.descriptionLabel.text = item.description
        self.starsLabel.text = item.starsFormatted
        self.forkLabel.text = item.forksFormatted
        self.ownerLabel.text = item.owner?.login
    }
}
