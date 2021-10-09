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
    
    var data = ShopList()
    let likelistViewModel = LikelistViewModel()
    var likeFlag: Bool = false
    let wishlistViewModel = WishlistViewModel()
    var wishFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        shopName.text = data.shop_name
        shopGenre.text = data.shop_genre
        let imageURL = URL(string: data.shop_photo_mobile)
        shopImage.sd_setImage(with: imageURL, placeholderImage: nil)
        likelistViewModel.getLikeStatus(shop_id: data.object_id) {
            if $0 == false {
                likeFlag = false
                likeLabel.backgroundColor = UIColor.white
                likeLabel.setTitleColor(UIColor.blue, for: .normal)
            } else {
                likeFlag = true
                likeLabel.backgroundColor = UIColor.blue
                likeLabel.setTitleColor(UIColor.white, for: .normal)
            }
        }
        wishlistViewModel.getWishStatus(shop_id: data.object_id) {
            if $0 == false {
                wishFlag = false
                wishLabel.backgroundColor = UIColor.white
                wishLabel.setTitleColor(UIColor.blue, for: .normal)
            } else {
                wishFlag = true
                wishLabel.backgroundColor = UIColor.blue
                wishLabel.setTitleColor(UIColor.white, for: .normal)
            }
        }
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
    
    @IBAction func wishButton(_ sender: Any){
        if wishFlag == false{
            wishlistViewModel.saveWishShop(data: data)
            wishLabel.backgroundColor = UIColor.blue
            wishLabel.setTitleColor(UIColor.white, for: .normal)
            wishFlag = true
        } else {
            wishlistViewModel.deleteWishShop(data: data)
            wishLabel.backgroundColor = UIColor.white
            wishLabel.setTitleColor(UIColor.blue, for: .normal)
            wishFlag = false
        }
    }
}
