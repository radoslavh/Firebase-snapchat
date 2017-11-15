//
//  SnapDetailViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 15/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class SnapDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.text = snap.desc
        imageView.sd_setImage(with: URL.init(string: snap.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("Pic was deleted")
        }
    }
}
