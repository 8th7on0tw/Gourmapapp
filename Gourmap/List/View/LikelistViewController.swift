//
//  LikelistViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit
import RealmSwift

class LikelistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cell = LikeTableViewCell()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Likelist"
        let realm = try! Realm()
        let results = realm.objects(LikeShop.self)
        print (results[0])
    }
    
}
