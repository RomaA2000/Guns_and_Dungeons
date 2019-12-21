//
//  Spawner.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев. on 09.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class Spawner {
    let atlas: SKTextureAtlas
    var units: [DestroyableUnit]
    var spawnParams: SpawnParams
    var scene: SKScene
    var nowWave : UInt64;
    var isEmpty: Bool {
        get {
            return self.units.count == 0
        }
    }
    
    init(spawnParams: SpawnParams, scene: SKScene, atlas: SKTextureAtlas) {
        self.atlas = atlas
        self.units = []
        self.nowWave = 0
        self.spawnParams = spawnParams
        self.scene = scene
        makeWave()
    }
    
    func makeWave() {
        for i in spawnParams.units {
            if i.wave == nowWave {
                var enemy : DestroyableUnit? = nil
                switch i.type {
                case "warrior":
                    enemy = makeWarrior(params: i)
                    break
                default:
                    break
                }
                addUnit(unit: enemy)
            }
        }
    }
    
    func addUnit(unit : DestroyableUnit?) {
        if let i = unit {
            units.append(i)
            scene.addChild(i)
        }
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
        if self.units.isEmpty {
            nowWave += 1
            makeWave()
        }
    }
    
    func getInfo() -> Array<SpawnerRequest> {
        return Array<SpawnerRequest>(units.map({ SpawnerRequest(location: $0.position)}))
    }
    
    func makeWarrior(params: UnitSpawnParams) -> Enemy {
        let animationParams = getAnimation(atlas: atlas, frameName: params.img, defaultName: params.img + "1", size: 3)
        let clip: Clip = Clip(bullets: 1000,
                              spawner: { return Bullet(defaultTexture: self.atlas.textureNamed("bullet"), damage: params.damage)},
                              frequence: TimeInterval(params.frequence),
                              bulletSpeed: 10)
        let weapon: Weapon = Weapon(defaultTexture: atlas.textureNamed(params.gunImg), clip: clip)
        let animatedUnitParams = AnimatedUnitParams(animationTexturesParams: animationParams,
                                                    location: CGPoint(x: CGFloat(params.positionX), y: CGFloat(params.positionY)),
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
