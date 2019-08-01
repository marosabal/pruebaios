//
//  MovieTableViewCell.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var labelTitle: UILabel?
    @IBOutlet private weak var imageViewIcon: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        imageViewIcon?.contentMode = .scaleAspectFit
        imageViewIcon?.clipsToBounds = true
        imageViewIcon?.layer.masksToBounds = true
        imageViewIcon?.layer.cornerRadius = 4
        imageViewIcon?.image = UIImage(named: "movie")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        labelTitle?.text = ""
        imageViewIcon?.image = UIImage(named: "movie")
    }

    func configure(info: MovieInfo) {
        labelTitle?.text = info.title
        imageViewIcon?.fetch(from: info.imageURL)
    }

}
