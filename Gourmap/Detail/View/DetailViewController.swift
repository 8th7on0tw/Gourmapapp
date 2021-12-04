//
//  DetailViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var detailTableView: UITableView!
    var contentsName: [String] = ["店名","店舗ページ","住所","最寄駅","交通アクセス","営業時間","定休日","予算","カード利用","総席数","駐車場","PCクーポン","スマホクーポン"]
    var contentsDetail: [String?] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        cell.contentsName.text = contentsName[indexPath.row]
        if let detail = contentsDetail[indexPath.row] {
            cell.contentsDetail.text = detail
            cell.contentsDetail.textAlignment = NSTextAlignment.right
        } else {
            cell.contentsDetail.text = "ー"
            cell.contentsDetail.textAlignment = NSTextAlignment.center
        }
        return cell
    }
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopGenre: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var wishLabel: UIButton!
    
    var shop_id: String = ""
    var shop_data = ShopList()
    let detailViewModel = DetailViewModel()
    let likelistViewModel = LikelistViewModel()
    var likeFlag: Bool = false
    let wishlistViewModel = WishlistViewModel()
    var wishFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.getShopData(shop_id: shop_id){ data in
            shop_data = data
            self.navigationItem.hidesBackButton = false
            shopName.text = data.shop_name
            shopGenre.text = data.shop_genre_name
            let imageURL = URL(string: data.shop_photo_mobile_l)
            shopImage.sd_setImage(with: imageURL, placeholderImage: nil)
            contentsDetail = detailViewModel.makeContentsDetail(data: data)
            likelistViewModel.getLikeStatus(shop_id: data.shop_id) {
                if $0 == false {
                    likeFlag = false
                    likeLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
                    likeLabel.setTitleColor(UIColor.blue, for: .normal)
                } else {
                    likeFlag = true
                    likeLabel.backgroundColor = UIColor.blue
                    likeLabel.setTitleColor(UIColor.white, for: .normal)
                }
            }
            wishlistViewModel.getWishStatus(shop_id: data.shop_id) {
                if $0 == false {
                    wishFlag = false
                    wishLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
                    wishLabel.setTitleColor(UIColor.blue, for: .normal)
                } else {
                    wishFlag = true
                    wishLabel.backgroundColor = UIColor.blue
                    wishLabel.setTitleColor(UIColor.white, for: .normal)
                }
            }
        }
    }
    
    @IBAction func likeButton(_ sender: Any){
        if likeFlag == false{
            likelistViewModel.saveLikeShop(data: shop_data)
            likeLabel.backgroundColor = UIColor.blue
            likeLabel.setTitleColor(UIColor.white, for: .normal)
            likeFlag = true
        } else {
            likelistViewModel.deleteLikeShop(data: shop_data)
            likeLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
            likeLabel.setTitleColor(UIColor.blue, for: .normal)
            likeFlag = false
        }
    }
    
    @IBAction func wishButton(_ sender: Any){
        if wishFlag == false{
            wishlistViewModel.saveWishShop(data: shop_data)
            wishLabel.backgroundColor = UIColor.blue
            wishLabel.setTitleColor(UIColor.white, for: .normal)
            wishFlag = true
        } else {
            wishlistViewModel.deleteWishShop(data: shop_data)
            wishLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
            wishLabel.setTitleColor(UIColor.blue, for: .normal)
            wishFlag = false
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
