//
//  AppDelegate.swift
//  todoey
//
//  Created by Saeed on 5/9/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
     
        do{
        _ = try Realm()
        }catch{
            print("error for Realm \(error)")
        }

        return true
    }

}
