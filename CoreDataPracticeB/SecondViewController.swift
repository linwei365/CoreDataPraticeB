//
//  SecondViewController.swift
//  CoreDataPracticeB
//
//  Created by Lin Wei on 2/13/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
import CoreData
class SecondViewController: UIViewController {

    var indexRow: Int?
    var instructors = [Instructor]()
    var courses = [Course]()
    
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
        firstNameTextField.text = instructors[indexRow!].nameFirst
        lastNameTextField.text = instructors[indexRow!].nameLast
        courseTitleTextField.text = courses[indexRow!].title
        
        
        save.enabled = false
        cancel.enabled = false
        edit.enabled = true
        
        
    }
    
    func loadData () {
     
        
        let fetchRequest = NSFetchRequest(entityName: "Instructor")
        let fetchRequestB = NSFetchRequest(entityName: "Course")
        
        try! instructors = moc!.executeFetchRequest(fetchRequest) as! [Instructor]
        
        try! courses = moc!.executeFetchRequest(fetchRequestB) as! [Course]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelOnClick(sender: UIButton) {
        
        save.enabled = false
        cancel.enabled = false
        edit.enabled = true
        
    }
    
    @IBAction func saveOnClick(sender: UIButton) {
        
        
        
        instructors[indexRow!].nameFirst = firstNameTextField.text
        instructors[indexRow!].nameLast =  lastNameTextField.text
        
    
        courses [indexRow!].title = courseTitleTextField.text
        
        
        try! moc.save()
        
        save.enabled = false
        cancel.enabled = false
        edit.enabled = true
        
        
    }
    
    @IBAction func editOnClick(sender: UIButton) {
        
        save.enabled = true
        cancel.enabled = true
        edit.enabled = false
        
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
