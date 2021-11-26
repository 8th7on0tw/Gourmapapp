//
//  DetailTableViewCell.swift
//  Gourmap
//
//  Created by hiro on 2021/11/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var contentsName: UILabel!
    @IBOutlet var contentsDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
