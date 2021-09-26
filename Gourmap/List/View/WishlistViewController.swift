//
//  WishlistViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/30.
//

import UIKit

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cell = WishTableViewCell()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
