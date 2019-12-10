//
//  Spawner.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 09.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class Spawner {
    
    let spawnPosition: CGPoint
    let atlas: SKTextureAtlas
    var units: [DestroyableUnit]
    var spawnParams: SpawnParams
    var numberInSchedule: Int = 0
    var scene: SKScene
    
    var isEmpty: Bool {
        get {
            return self.numberInSchedule == self.spawnParams.units.count && self.units.count == 0
        }
    }
    
    init(spawnParams: SpawnParams, scene: SKScene ,spawnPoint: CGPoint, atlas: SKTextureAtlas) {
        self.atlas = atlas
        self.units = []
        self.numberInSchedule = 0
        self.spawnParams = spawnParams
        self.spawnPosition = spawnPoint
        self.scene = scene
    }
    
    func update(_ currentTime: TimeInterval) {
        for unit in self.units {
            unit.update(currentTime)
            if (unit.healthPoints <= 0) {
                print("delete")
                unit.removeFromParent()
            }
        }
        self.units = self.units.filter({$0.healthPoints > 0})
        self.checkForSpawn()
    }
    
    func checkForSpawn() {
        // MARK: -overflow
        if (numberInSchedule < self.spawnParams.units.count && self.units.count == 0) {
            let current: UnitSpawnParams = spawnParams.units[numberInSchedule]
            switch current.type {
            case "warrior":
                let enemy = makeWarrior(params: spawnParams.units[numberInSchedule])
                numberInSchedule += 1
                units.append(enemy)
                scene.addChild(enemy)
                break
            default:
                print("")
            }
        }
    }
    
    func makeWarrior(params: UnitSpawnParams) -> Enemy {
        let animationParams = getAnimation(atlas: atlas, frameName: params.img, defaultName: params.img + "1", size: 4)
        let clip: Clip = Clip(bullets: 1000,
                              spawner: { return Bullet(defaultTexture: self.atlas.textureNamed("bullet"), damage: params.damage)},
                              frequence: TimeInterval(params.frequence),
                              bulletSpeed: 10)
        let weapon: Weapon = Weapon(defaultTexture: atlas.textureNamed(params.gunImg), clip: clip)
        let animatedUnitParams = AnimatedUnitParams(animationTexturesParams: animationParams,
                                                    location: spawnPosition,
                                                    weapon: weapon)
        let destroyableUnitParams = DestroyableUnitParams(animatedUnitParams: animatedUnitParams,
                                                          healthPoints: params.hp,
                                                          deathAnimation: animationParams.defaultAnimation)
        let mobileUnitParams = MobileUnitParams(destoyableUntiParams: destroyableUnitParams,
                                                maxSpeed: CGFloat(params.speed),
                                                walkAnimation: animatedUnitParams.defaultAnimation)
        let enemyMask = PhysicsBodyMask(category: CategoryMask.ai,
                                        collision: CategoryMask.player | CategoryMask.wall | CategoryMask.ai,
                                        contact: CategoryMask.bullet)
        let enemyParams = EnemyParams(mobileUnitParams: mobileUnitParams,
                                      mask: enemyMask,
                                      radius: animationParams.defaultTexture.size().width / 2,
                                      purviewRange: 50)
        return Enemy(params: enemyParams)
    }
    
    
}
