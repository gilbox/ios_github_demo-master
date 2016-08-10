//
//  ResultTableViewCell.swift
//  GithubDemo
//
//  Created by Gil Birman on 8/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

  @IBOutlet weak var starsLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var forksLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!

  var repo: GithubRepo? {
    didSet {
      starsLabel.text = "\(repo?.stars ?? 0)"
      forksLabel.text = "\(repo?.forks ?? 0)"
      ownerLabel.text = repo?.ownerHandle ?? ""
      nameLabel.text = repo?.name ?? ""
      descriptionLabel.text = repo?.repoDescription ?? ""
      if let url = repo?.ownerAvatarURL {
        avatarImageView.setImageWithURL(NSURL(string: url)!)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
