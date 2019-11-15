//
//  Statistics+CoreDataClass.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Statistics)
public class Statistics: NSManagedObject {

    init() {
        self.stars = -1
        self.levelNumber = -1
        super.init()
    }
}
