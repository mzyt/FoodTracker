//
//  meal.swift
//  FoodTracker
//
//  Created by mizuno on 2016/11/27.
//  Copyright © 2016年 mizuno. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding{
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    static var documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendPathComponent("meal")
    
    // MARK: Types
    struct PropertyKey {
        static let nemeKey = "name"
        static let photoKey = "photoKey"
        static let ratingKey = "retingKey"
    }
    
    // MARK: Initialzation
    init?(name: String, photo: UIImage?, rating: Int){
        
        // Initializa stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is nagative
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nemeKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: PropertyKey.nemeKey) as! String
        photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        rating = aDecoder.decodeObject(forKey: PropertyKey.ratingKey)
        
        
    }
}
