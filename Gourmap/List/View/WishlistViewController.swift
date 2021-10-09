//
//  WishlistViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit
import RealmSwift
import SDWebImage

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var wishlistTableView: UITableView!
    var results: [ShopList] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath) as! WishTableViewCell
        let wishShop = results[indexPath.row]
        cell.wishShopName.text = wishShop.shop_name
        cell.wishShopAddress.text = wishShop.shop_address
        cell.wishShopGenre.text = wishShop.shop_genre
        let imageURL = URL(string: wishShop.shop_logo_image)
        cell.wishShopImage.sd_setImage(with: imageURL, placeholderImage: nil)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wishlist"
        let realm = try! Realm()
        let wishdatas = realm.objects(ShopList.self).filter("wishStatus == true")
        for i in wishdatas {
            results.append(i)
        }
        wishlistTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetailFromWish", sender: results[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromWish" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.data = sender as! ShopList
        }
    }
    
}
