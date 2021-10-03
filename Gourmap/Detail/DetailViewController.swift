//
//  DetailViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController{
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopGenre: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var wishLabel: UIButton!
    
    var data = ShopPinAnnotation()
    let likelistViewModel = LikelistViewModel()
    var likeFlag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        shopName.text = data.shop_name
        shopGenre.text = data.shop_genre
        let imageURL = URL(string: data.photo_mobile)
        shopImage.sd_setImage(with: imageURL, placeholderImage: nil)
        if data.likeStatus == false {
            likeFlag = false
        } else {
            likeFlag = true
        }
    }
    
    @IBAction func wishButton(_ sender: Any){
    }                                                                 
    
    @IBAction func likeButton(_ sender: Any) {
        if likeFlag == false{
            likelistViewModel.saveLikeShop(data: data)
            likeLabel.backgroundColor = UIColor.blue
            likeLabel.setTitleColor(UIColor.white, for: .normal)
            likeFlag = true
        } else {
            likelistViewModel.deleteLikeShop(data: data)
            likeLabel.backgroundColor = UIColor.white
            likeLabel.setTitleColor(UIColor.blue, for: .normal)
            likeFlag = false
        }
    }
    
    @IBAction func toMainButton(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: nil)
    }
}
