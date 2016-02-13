//
//  MainTableViewController.swift
//  CoreDataPracticeB
//
//  Created by Lin Wei on 2/13/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
// step 1 import
import CoreData


class MainTableViewController: UITableViewController {

    //step 2 array of managedObject which [Instructor]
    
    var instructors = [Instructor]()
    var courses = [Course]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonOnClick(sender: UIBarButtonItem) {
        
        let alert  =  UIAlertController(title: "Add Instructor", message: "New Instructor Name", preferredStyle: UIAlertControllerStyle.Alert)
     
        let addAction =  UIAlertAction(title: "add", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            
        }
        
        let cancelAction =  UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (firstName:UITextField) -> Void in
            
            firstName.placeholder = "First Name"
            
            
        }
        alert.addTextFieldWithConfigurationHandler { (lastName:UITextField) -> Void in
            
            lastName.placeholder = "Last Name"
            
            
        }
        alert.addTextFieldWithConfigurationHandler { (courseTitle:UITextField) -> Void in
            
            courseTitle.placeholder = "Course Title"
            
            
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        
        
        presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return instructors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        
        let instructorName =  instructors[indexPath.row]
        
        cell.textLabel?.text = instructorName.nameFirst! + " " + instructorName.nameLast!
        
        cell.detailTextLabel?.text = courses[indexPath.row].title
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
