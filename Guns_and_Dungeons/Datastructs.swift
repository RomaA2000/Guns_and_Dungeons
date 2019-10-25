//
//  Datastructs.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18/10/2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

class LevelInfo {
    var available : Bool
    var description : String
    init(available: Bool, description: String) {
        self.available = available
        self.description = description
    }
}
