//
//  Enemies.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев. on 09.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

struct SpawnParams: Decodable {
    let units: Array<UnitSpawnParams>
}

struct UnitSpawnParams: Decodable {
    let type: String
    let gunImg: String
    let img: String
    let speed: UInt64
    let damage: UInt64
    let frequence: UInt64
    let positionX: Float
    let positionY: Float
    let hp: Int64
    let wave: UInt64
}

class EnemiesController {
    var spawner: Spawner
    let atlas: SKTextureAtlas
    let scene: SKScene
    var outOfCharge: Bool = false
    
    init(atlas: SKTextureAtlas, scene: SKScene, levelNumber : UInt64) {
        self.atlas = atlas
        self.scene = scene
        let path = Bundle.main.path(forResource: "scheme\(levelNumber)", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            print(try JSONDecoder().decode(SpawnParams.self, from: data))
            self.spawner = Spawner(spawnParams: try JSONDecoder().decode(SpawnParams.self, from: data), scene: scene, atlas: atlas)
        } catch {
            fatalError("JSON data not found")
        }
    }

    func update(_ currentTime: TimeInterval) {
        let enemiesInfo = spawner.getInfo()
        //solver here
        spawner.update(currentTime)
        if spawner.isEmpty {
            print("empty")
            outOfCharge = true
        }
    }
}
