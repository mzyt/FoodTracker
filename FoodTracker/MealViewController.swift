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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
    // or constructed as part of adding a new meal
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        nameTextFeild.delegate = self
        
        // Set up view if editing an existing Meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextFeild.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name
        checkValidMealName()
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
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    func checkValidMealName(){
        // Disable the Save button if the text field is empty
        let text = nameTextFeild.text ?? ""
        saveButton.isEnabled = !text.isEmpty
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

    // MARK: Navigations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIBarButtonItem, saveButton === sender {
            let name = nameTextFeild.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // modalナビゲーションで繊維したか
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
        
        
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

