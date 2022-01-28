//
//  UIImageView+AsyncDownload.swift
//  MarsRover
//
//  Created by Алена on 01.11.2021.
//

import UIKit

extension UIImageView {
    public func loadImage(imageString: String) {
        let urlImage = URL(string: imageString)
        guard let url = urlImage else {
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responds, error in
            if data != nil {
                DispatchQueue.main.async {
                    if let dataImage = data {
                        self.image = UIImage(data: dataImage)
                    }
                }
            }
        } .resume()
    }
}
