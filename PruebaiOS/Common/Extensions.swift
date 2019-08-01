//
//  Extensions.swift
//  PruebaiOS
//
//  Created by Ale on 7/31/19.
//  Copyright © 2019 everis. All rights reserved.
//

import UIKit

extension UIImageView {

    func fetch(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
                self.setNeedsDisplay()
            }
        }
        task.resume()
    }

    func fetch(from link: String) {
        image = UIImage(named: "movie")
        guard let url = URL(string: link) else {
            return
        }
        fetch(from: url)
    }
}
