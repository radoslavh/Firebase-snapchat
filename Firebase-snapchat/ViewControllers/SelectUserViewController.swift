//
//  SelectUserViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 14/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var desc = ""
    var imageURL = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        Database.database().reference().child("users")
            .observe(DataEventType.childAdded) { (snapshot) in
                print(snapshot)
                
                let user = User()
                user.email = (snapshot.value as? NSDictionary)!["email"] as! String
                user.uid = snapshot.key
                
                self.users.append(user)
                self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email , "description":self.desc, "imageURL":self.imageURL, "uuid":self.uuid];
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController!.popToRootViewController(animated: true)
    }
}








