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
    let speed: Float
    let damage: UInt64
    let frequence: Float
    let positionX: Float
    let positionY: Float
    let hp: Int64
    let wave: UInt64
    let dist: Float
}

class EnemiesController {
    var spawner: Spawner
    let atlas: SKTextureAtlas
    weak var scene: GameScene?
    var outOfCharge: Bool = false
    let requesSolver: RequesSolver

    init(atlas: SKTextureAtlas, scene: GameScene, levelNumber : UInt64) {
        self.atlas = atlas
        self.scene = scene
        self.requesSolver = RequesSolver(walls: scene.walls)
        let path = Bundle.main.path(forResource: "scheme\(levelNumber)", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            self.spawner = Spawner(spawnParams: try JSONDecoder().decode(SpawnParams.self, from: data), scene: scene, atlas: atlas)
        } catch {
            fatalError("JSON data not found")
        }
    }

    func update(_ currentTime: TimeInterval) {
        if let sceneUnwrapped = scene {
            let request = spawner.getInfo()
            let results = requesSolver.solve(request: request, players: [sceneUnwrapped.player.position])
            spawner.update(currentTime, targets: results)
            if spawner.isEmpty {
                outOfCharge = true
            }
        }
    }
}
