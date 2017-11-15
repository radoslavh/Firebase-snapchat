//
//  SnapsViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 14/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var logout: UIBarButtonItem!
    @IBOutlet weak var addSnap: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps")
            .observe(DataEventType.childAdded) { (snapshot) in
                print(snapshot)
                
                let snap = Snap()
                snap.imageURL = (snapshot.value as? NSDictionary)!["imageURL"] as! String
                snap.desc = (snapshot.value as? NSDictionary)!["description"] as! String
                snap.from = (snapshot.value as? NSDictionary)!["from"] as! String
                snap.uuid = (snapshot.value as? NSDictionary)!["uuid"] as! String
                snap.key = snapshot.key
                
                self.snaps.append(snap)
                self.tableView.reloadData()
        }
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps")
            .observe(DataEventType.childRemoved) { (snapshot) in
                print(snapshot)
                var index = 0
                for snap in self.snaps {
                    if snap.key == snapshot.key{
                        self.snaps.remove(at: index)
                    }
                    index += 1
                }
                self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count == 0 ? 1 : snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps! 😕"
        } else {
            cell.textLabel?.text = snaps[indexPath.row].from
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewSnapSegue", sender: snaps[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! SnapDetailViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    @IBAction func addSnapTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSnapSeque", sender: nil)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
