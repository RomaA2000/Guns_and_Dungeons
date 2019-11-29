//
//  LevelStatistics.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 27.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

class LevelStatistics {
    
    let stars: Int16
    let levelNumber: Int16
    
    init(levelNumber: Int16, stars: Int16) {
        self.stars = stars
        self.levelNumber = levelNumber
    }
    
}
