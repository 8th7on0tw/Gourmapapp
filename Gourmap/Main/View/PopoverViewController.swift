//
//  PopoverViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/09/18.
//

import UIKit

class PopoverViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
     
    @IBAction func yesButton(_ sender: Any) {
    }
    
    
    @IBAction func noButton(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
