//
//  UIImageView+setImage.swift
//  Gourmap
//
//  Created by hiro on 2021/09/19.
//

import Foundation

extension UIImageView {
    
    func setImage(with url: URL) {
        
        self.sd_setImage(with: url) { [weak self] image, error, _, _ in
            if error == nil, let image = image {
                self?.image = image
            } else {
                // error handling
            }
        }
        
    }
}
