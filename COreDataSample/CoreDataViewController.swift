//
//  CoreDataViewController.swift
//  COreDataSample
//
//  Created by School on 07/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    public var context: NSManagedObjectContext!
    
    fileprivate func createPerson(_ p: Person) {
        
        p.firstName = "New"
        p.lastName = "Test"
        p.school = "Ican"
        
        try? self.context.save()
    }
    
    fileprivate func updatePerson() {
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "school == %@","Ican")
        
        guard let result = try? self.context.fetch(request) else {
            return
        }
        
        result.forEach {  $0.school = "Samba 15 ans"}
        
        try? self.context.save()
        
    }
    
    fileprivate func fetchPerson() {
        
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "school == %@","ESGI")
        
        guard let result = try? self.context.fetch(request) else {
            return
        }
        
        result.forEach {  self.context.delete($0) }
        try? self.context.save()
        
        // print("\n\(p.firstName ?? " ") \t \(p.lastName ?? " ") \t \(p.school ?? "") \n"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        guard let p =
            NSEntityDescription.insertNewObject(forEntityName: "Person", into: self.context) as?
            Person else {
                    return
            }
        */
        //let p = Person(context: self.context)
        //createPerson(p)
        
        //fetchPerson()

        updatePerson()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
