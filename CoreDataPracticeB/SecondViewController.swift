//
//  SecondViewController.swift
//  CoreDataPracticeB
//
//  Created by Lin Wei on 2/13/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
import CoreData

protocol SecondViewControllerDelegate {
    
    func setTextTooFalse()
    
}

class SecondViewController: UIViewController {

    var delegate:SecondViewControllerDelegate? = nil
    
    
    var indexRow: Int?
    var instructors = [Instructor]()
    var courses = [Course]()
    
    var searchActive = false
    var searchText:String = ""
    var filteredCourses = [Course]()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var courseTitleTextField: UITextField!
    @IBOutlet weak var cancel: UIButton!
    
    var moc: NSManagedObjectContext!
    
    
    @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var save: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
        
       
        
        
      
        disableText()
        
        
    }
    
    func disableText () {
        save.enabled = false
        save.hidden = true
        
        cancel.enabled = false
        cancel.hidden = true
        edit.enabled = true
        edit.hidden = false
    
        firstNameTextField.enabled = false
        lastNameTextField.enabled = false
        courseTitleTextField.enabled = false
    
    }
    
    func enableText () {
        save.enabled = true
        save.hidden = false
        
        cancel.enabled = true
        cancel.hidden = false
        edit.enabled = false
        edit.hidden = true
        
        firstNameTextField.enabled = true
        lastNameTextField.enabled = true
        courseTitleTextField.enabled = true
        
        
    }
    
    override func showViewController(vc: UIViewController, sender: AnyObject?) {
                self.delegate?.setTextTooFalse()
    }
    
    func loadData () {
     
        if (self.searchActive && self.searchText != "" ) {
            
            
            //needs something to be send when filtering the data moc doesn't do it  still need fix this problem
            
            //       let fetchRequest = NSFetchRequest(entityName: "Instructor")
            
            let fetchRequestB = NSFetchRequest(entityName: "Course")
            let predicateB = NSPredicate(format: "title LIKE[c]'\(self.searchText)*'" )
            
            fetchRequestB.predicate = predicateB
            
            
            //         try! filteredInstructors = managedObjectContext!.executeFetchRequest(fetchRequest) as! [Instructor]
            
            try! filteredCourses = moc!.executeFetchRequest(fetchRequestB) as! [Course]
            
            firstNameTextField.text = filteredCourses[indexRow!].instructor!.nameFirst
            lastNameTextField.text = filteredCourses[indexRow!].instructor!.nameLast
            courseTitleTextField.text = filteredCourses[indexRow!].title
            
    
          
            
            if(filteredCourses.count == 0){
                searchActive = false;
                  self.searchText = ""
            } else {
                
                searchActive = true;
            }
            
        }
            
        else {
            
            
            //            vc.courses = courses
            //            vc.instructors = instructors
            
       
        
        let fetchRequest = NSFetchRequest(entityName: "Instructor")
        let fetchRequestB = NSFetchRequest(entityName: "Course")
        
        try! instructors = moc!.executeFetchRequest(fetchRequest) as! [Instructor]
        
        try! courses = moc!.executeFetchRequest(fetchRequestB) as! [Course]
            
            firstNameTextField.text = courses[indexRow!].instructor!.nameFirst
            lastNameTextField.text = courses[indexRow!].instructor!.nameLast
            courseTitleTextField.text = courses[indexRow!].title
        }
    }

    
    
    
    func saveData (){
        
        if (self.searchActive && self.searchText != "" ) {
        
            
            filteredCourses[indexRow!].instructor!.nameFirst = firstNameTextField.text
            filteredCourses[indexRow!].instructor!.nameLast =  lastNameTextField.text
            
            filteredCourses[indexRow!].title = courseTitleTextField.text
            
            
            try! moc.save()
            
            
            searchActive = false;
            self.searchText = ""
            
//            if(filteredCourses.count == 0){
//                searchActive = false;
//            } else {
//                searchActive = true;
//            }
//            
            disableText()
            
        }
        
        else {
            
            
            
            courses[indexRow!].instructor!.nameFirst = firstNameTextField.text
           courses[indexRow!].instructor!.nameLast =  lastNameTextField.text
            
            
            courses [indexRow!].title = courseTitleTextField.text
            
            
            try! moc.save()
            
            disableText()
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelOnClick(sender: UIButton) {
        
   disableText()
   
    }
    
    @IBAction func saveOnClick(sender: UIButton) {
        
       // self.delegate?.setTextTooFalse()
        
       // navigationController!.popViewControllerAnimated(true)
        
    saveData()
        
        
        
    }
    
    @IBAction func editOnClick(sender: UIButton) {
        
     enableText()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
