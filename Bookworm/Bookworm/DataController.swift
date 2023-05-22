//
//  DataController.swift
//  Bookworm
//
//  Created by Nana Bonsu on 4/19/23.
//

import CoreData
import Foundation


//here is where you load the Core Data model to be used first!
class DataController: ObservableObject { //you can observe this for relevant changes neede to be made!
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
