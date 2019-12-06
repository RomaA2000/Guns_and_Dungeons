//
//  Clip.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 05.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Clip {
    weak var weapon : Weapon?
    var bullets : UInt64 = 0
    let frequence: TimeInterval
    var lastShotTime: TimeInterval
    var bulletSpeed: CGFloat
    
    var makeBullet = {() -> Bullet? in
        return nil
    }

    init(bullets : UInt64, spawner : @escaping () -> Bullet?, frequence: TimeInterval, bulletSpeed: CGFloat) {
        self.bulletSpeed = bulletSpeed
        self.frequence = frequence
        self.lastShotTime = 0
        self.weapon = nil
        self.bullets = bullets
        self.makeBullet = spawner
    }

    func changeWeapon(weapon : Weapon?) {
        self.weapon = weapon
    }
    
    func takeShot(currentTime: TimeInterval) -> Bullet? {
        if (bullets > 0) {
            if (currentTime - lastShotTime >= frequence) {
                if let bullet = makeBullet() {
                    bullet.setVelocityVector(angle: weapon?.getAngle() ?? 0, length: bulletSpeed)
                    weapon?.spawn(bullet: bullet)
                    bullets -= 1
                    return bullet
                }
            }
        }
        return nil
    }
}
