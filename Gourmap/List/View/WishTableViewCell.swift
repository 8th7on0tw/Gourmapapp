//
//  WishTableViewCell.swift
//  Gourmap
//
//  Created by hiro on 2021/09/04.
//

import UIKit

class WishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wishShopImage: UIImageView!
    @IBOutlet weak var wishShopName: UILabel!
    @IBOutlet weak var wishShopAddress: UILabel!
    @IBOutlet weak var wishShopGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
