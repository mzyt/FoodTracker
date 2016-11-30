//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by mizuno on 2016/11/27.
//  Copyright © 2016年 mizuno. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem

        // Load the sample data.
        loadSampleMeals()
    }
    
    func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        let meal1 = Meal(name: "Capres sald", photo: photo1, rating: 4)!
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 3)!
        let meal3 = Meal(name: "Past with Meatballs", photo: photo3, rating: 5)!
        
        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView2")
        // Table view cells are reused and should ve dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell

        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            
            let mealViewController = segue.destination as! MealViewController
            
            // Get the cell that generated this segue
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealViewController.meal = selectedMeal
            }
        }else if segue.identifier == "AddItem"{
            print("Adding new meal.")
        }
    }
    
    @IBAction func unwindToMealList(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? MealViewController, let meal = source.meal {
            
            // テーブルのセルが選択された場合
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // Update as existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.none)
            }else{
                // Add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }

}
