//
//  Enemies.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 20.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class Enemies {
    
    var spawners: [Spawner] = []
    
    init() {
        
    }
    
    func addSpawner(spawner: Spawner) {
        spawners.append(spawner)
    }
    
    func updateEnemies() {
        
    }
}


