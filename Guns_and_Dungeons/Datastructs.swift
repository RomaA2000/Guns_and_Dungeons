//
//  Datastructs.swift
//  Guns_and_Dungeons
//
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
