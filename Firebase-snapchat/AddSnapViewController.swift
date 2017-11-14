//
//  AddSnapViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 14/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import Firebase

class AddSnapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func onNextAction(_ sender: Any) {
        nextButton.isEnabled = false
        uploadImg()
    }
    
    func uploadImg(){
        let imagesFolder = Storage.storage().reference().child("images")
        let imageData = UIImagePNGRepresentation(imageView.image!)!
        imagesFolder.child("images.png").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print("we tried to upload")
            if error != nil {
                print("We have an error!")
            }else{
                self.performSegue(withIdentifier: "selecUsersSegue", sender: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func onCameraAction(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
        nextButton.isEnabled = true
    }
}
