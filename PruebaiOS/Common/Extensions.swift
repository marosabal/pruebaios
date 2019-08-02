//
//  Extensions.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

import UIKit

extension UIImageView {

    func fetch(from link: String) {
        image = UIImage(named: "movie")
        let manager = MovieManager()
        manager.downloadImage(from: link) { data in
            if let validData = data, let image = UIImage(data: validData) {
                self.image = image
                self.setNeedsDisplay()
            }
        }
    }
}
