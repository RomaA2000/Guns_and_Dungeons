//
//  Enemies.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 09.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

struct Schedule: Decodable {
    var spawners: Array<SpawnParams>
}

struct SpawnParams: Decodable {
    let number: UInt64
    let units: Array<UnitSpawnParams>
}

struct UnitSpawnParams: Decodable {
    let type: String
    let gunImg: String
    let img: String
    let speed: UInt64
    let damage: UInt64
    let frequence: UInt64
    let hp: Int64
}

class EnemiesController {
    var spawners: [Spawner] = []
    let atlas: SKTextureAtlas
    var schedule: Schedule
    let scene: SKScene
    var outOfCharge: Bool = false
    
    init(atlas: SKTextureAtlas, scene: SKScene) {
        self.atlas = atlas
        self.scene = scene
        let path = Bundle.main.path(forResource: "scheme1", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            print(try JSONDecoder().decode(Schedule.self, from: data))
            self.schedule =  try JSONDecoder().decode(Schedule.self, from: data);
        }
        catch {
            fatalError("JSON data not found")
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        for spawner in spawners {
            spawner.update(currentTime)
            if (spawner.isEmpty) {
                print("empty")
            }
        }
        spawners = spawners.filter({ !$0.isEmpty })
        self.outOfCharge = spawners.count == 0
    }
    
    func addSpawner(location: CGPoint, number: Int) {
        print("addSpawner")
        spawners.append(Spawner(spawnParams: schedule.spawners[number], scene: scene,spawnPoint: location ,atlas: atlas))
    }
}
