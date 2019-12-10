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
    let number: Int
    let units: Array<UnitSpawnParams>
}

struct UnitSpawnParams: Decodable {
    let type: String
    let gunImg: String
    let img: String
    let speed: Int
    let damage: Int
    let frequence: Int
    let hp: Int
}

class Enemies {
    var spawners: [Spawner] = []
    let atlas: SKTextureAtlas
    var schedule: Schedule
    let scene: SKScene
    
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
    }
    
    func addSpawner(location: CGPoint, number: Int) {
        print("addSpawner")
        spawners.append(Spawner(spawnParams: schedule.spawners[number], scene: scene,spawnPoint: location ,atlas: atlas))
    }
}
