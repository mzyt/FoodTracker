//
//  meal.swift
//  FoodTracker
//
//  Created by mizuno on 2016/11/27.
//  Copyright © 2016年 mizuno. All rights reserved.
//

import UIKit

class Meal{
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialzation
    init?(name: String, photo: UIImage?, rating: Int){
        
        // Initializa stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // Initialization should fail if there is no name or if the rating is nagative
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
