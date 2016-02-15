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


class MainTableViewController: UITableViewController,UISearchBarDelegate {

 
    //step 2 array of managedObject which [Instructor]
    
    var instructors = [Instructor]()
    var courses = [Course]()
    var managedObjectContext: NSManagedObjectContext?
    
    var fetchResultController = NSFetchedResultsController ()
    
    //search bar
    @IBOutlet weak var searchBar: UISearchBar!
    
      var searchActive : Bool = false
    var filteredInstructors:[Instructor] = []
    var filteredCourses:[Course] = []
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    
    // searchbar delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
//       let fetchRequest = NSFetchRequest(entityName: "Instructor")
     
          let fetchRequestB = NSFetchRequest(entityName: "Course")
        let predicateB = NSPredicate(format: "title LIKE[c]'\(searchText)*'" )
       
       fetchRequestB.predicate = predicateB
        
        
//         try! filteredInstructors = managedObjectContext!.executeFetchRequest(fetchRequest) as! [Instructor]
        
        try! filteredCourses = managedObjectContext!.executeFetchRequest(fetchRequestB) as! [Course]
        
        
        
        
//        filtered = data.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
        
        if(filteredCourses.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadData()
        
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("data", sender: nil);
//    }

    func loadData () {
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName: "Instructor")
        let fetchRequestB = NSFetchRequest(entityName: "Course")
      

        
        try! instructors = managedObjectContext!.executeFetchRequest(fetchRequest) as! [Instructor]
        
        try! courses = managedObjectContext!.executeFetchRequest(fetchRequestB) as! [Course]
        
    }
    
    
    
    
    func searchName (course:String) {
        
        
        let fetchRequest = NSFetchRequest(entityName: "Instructor")
        let fetchRequestB = NSFetchRequest(entityName: "Course")
        
        let predicateB = NSPredicate(format: "title LIKE[c]'\(course)*'" )
        
        fetchRequestB.predicate = predicateB
        
        
        try! instructors = managedObjectContext!.executeFetchRequest(fetchRequest) as! [Instructor]
        
        try! courses = managedObjectContext!.executeFetchRequest(fetchRequestB) as! [Course]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // save text function
    
    func saveText(firstName:String, lastName: String, courseTitle: String)  {
        
          managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let instructor = NSEntityDescription.insertNewObjectForEntityForName("Instructor", inManagedObjectContext: managedObjectContext!) as! Instructor
     
        instructor.setValue(firstName, forKey: "nameFirst")
        instructor.setValue(lastName, forKey: "nameLast")
        
          let course = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: managedObjectContext!) as! Course
        
        course.setValue(courseTitle, forKey: "title")
        
        //---
        
        var error: NSError?
        
        do {
           try managedObjectContext!.save()
            instructors.append(instructor)
            courses.append(course)
        }
        catch let error1 as NSError {
            
            error =  error1
        }
        
        if error != nil {
            
            print("failed to save")
        }
        //----
       
        
       
 
//        try! managedObjectContext.save()
        
        
    }
    

    @IBAction func addButtonOnClick(sender: UIBarButtonItem) {
        
        let alert  =  UIAlertController(title: "Add Instructor", message: "New Instructor Name", preferredStyle: UIAlertControllerStyle.Alert)
     
        let addAction =  UIAlertAction(title: "add", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            
            let firstName = alert.textFields![0]
            let lastName = alert.textFields![1]
            let courseTitle = alert.textFields![2]
         
            self.saveText(firstName.text!, lastName: lastName.text!, courseTitle: courseTitle.text!)
            
            self.searchActive = false
            self.tableView.reloadData()
            
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
        
        
        if(searchActive) {
            return filteredCourses.count
        }
        return instructors.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        
        let instructorName =  instructors[indexPath.row]
        
        cell.textLabel?.text = "Instructor: " + instructorName.nameFirst! + " " + instructorName.nameLast!
        
//        cell.detailTextLabel?.text = "Course Title: " + courses[indexPath.row].title!
        
        
        
        if(searchActive && searchBar.text != "" ){
            cell.detailTextLabel?.text = "Course Title: " + filteredCourses[indexPath.row].title!
 
        } else {
            cell.detailTextLabel?.text = "Course Title: " + courses[indexPath.row].title!
        }
        
        

        return cell
    }


 
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            
            let instructor = instructors[indexPath.row]
            let course = courses[indexPath.row]
            managedObjectContext?.deleteObject(instructor)
            managedObjectContext?.deleteObject(course)
            
            instructors.removeAtIndex(indexPath.row)
            courses.removeAtIndex(indexPath.row)
            
            try! managedObjectContext?.save()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let index = self.tableView.indexPathForSelectedRow
        
        let vc =  segue.destinationViewController as! SecondViewController
        
        vc.indexRow = index?.row
        
//        var selectedItem:[Course]
        if (self.searchActive && self.searchBar.text != "" ) {
            vc.courses = filteredCourses
       
            //needs something to be send when filtering the data moc doesn't do it  still need fix this problem
         vc.moc = managedObjectContext
            
            
        }
        
        else {
            
            
//            vc.courses = courses
//            vc.instructors = instructors
            
            
            
            
          vc.moc = managedObjectContext
        }
        
        
        //-------------
        
       

    
        
        
    }
    

}
