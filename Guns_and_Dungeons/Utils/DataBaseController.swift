//
//  DataBaseController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import CoreData

class DataBaseController {
    var context: NSManagedObjectContext
    var coordinator: NSPersistentStoreCoordinator

    init() {
        let model = NSManagedObjectModel.mergedModel(from: nil)!
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        // url до базы
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let storeURL = url.appendingPathComponent("LevelsInfo.sqlite")
        
        // добавляем store
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        // context
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
    }
}
