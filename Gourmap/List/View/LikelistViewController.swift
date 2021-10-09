//
//  LikelistViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit
import RealmSwift
import SDWebImage

class LikelistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var likelistTableView: UITableView!
    var results: [ShopList] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likelistCell", for: indexPath) as! LikeTableViewCell
        let likeShop = results[indexPath.row]
        cell.shopName.text = likeShop.shop_name
        cell.shopAddress.text = likeShop.shop_address
        cell.shopGenre.text = likeShop.shop_genre
        let imageURL = URL(string: likeShop.shop_logo_image)
        cell.shopImage.sd_setImage(with: imageURL, placeholderImage: nil)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Likelist"
        let realm = try! Realm()
        let likedatas = realm.objects(ShopList.self).filter("likeStatus == true")
        for i in likedatas {
            results.append(i)
        }
        likelistTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetailFromLike", sender: results[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromLike" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.data = sender as! ShopList
        }
    }
    
}
