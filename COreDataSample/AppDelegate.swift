//
//  AppDelegate.swift
//  COreDataSample
//
//  Created by School on 06/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
     var context : NSManagedObjectContext?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.context = self.loadCoreDataContext()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let coreDataViewController = CoreDataViewController()
        
        coreDataViewController.context = self.context
        
        window.rootViewController = coreDataViewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    
    }

}
extension AppDelegate  {
    
    func  loadCoreDataContext() -> NSManagedObjectContext?  {
        guard
            let schemaURL = Bundle.main.url(forResource: "COreDataSample", withExtension:"momd"),
            let model = NSManagedObjectModel(contentsOf: schemaURL)
            else {
                return nil
            }

        let store = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                else {
                 return nil
            }
        let storageUrl = documentDirectory.appendingPathComponent("mySuper.sqlite")
        
        
        print(storageUrl)
        
        
        _ = try? store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageUrl, options: nil)
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = store
        return context
    }
}

