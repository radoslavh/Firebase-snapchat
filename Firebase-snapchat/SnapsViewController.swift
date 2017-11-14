//
//  SnapsViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 14/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    @IBOutlet weak var logout: UIBarButtonItem!
    @IBOutlet weak var addSnap: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addSnapAction(_ sender: Any) {
        performSegue(withIdentifier: "addSnapSeque", sender: nil)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
