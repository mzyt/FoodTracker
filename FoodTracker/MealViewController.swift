//
//  MealViewController.swift
//  FoodTracker
//
//  Created by mizuno on 2016/11/22.
//  Copyright © 2016年 mizuno. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: properties
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextFeild.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    // MARK: UIImagePickerControllerDelegeate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and the uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: Any) {
        // Hide the keyboard
        nameTextFeild.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not token
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an images.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
}

