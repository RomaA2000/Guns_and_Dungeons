//
//  LevelStatistics.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 27.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

class LevelStatistics {
    
    let stars: UInt64
    let levelNumber: UInt64
    
    init(levelNumber: UInt64, stars: UInt64) {
        self.stars = stars
        self.levelNumber = levelNumber
    }
    
}
