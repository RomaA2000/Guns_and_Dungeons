//
//  Clip.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 05.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

class Clip {
    weak var weapon : Weapon?
    var bullets : UInt64 = 0
    var makeBullet = {() -> Bullet? in
        return nil
    }

    init(bullets : UInt64, spawner : @escaping () -> Bullet?) {
        self.weapon = nil
        self.bullets = bullets
        self.makeBullet = spawner
    }

    func changeWeapon(weapon : Weapon?) {
        self.weapon = weapon
    }
    
    func takeShot() {
        if (bullets > 0) {
            if let bullet = makeBullet() {
                bullet.setVelocityVector(angle: weapon?.getAngle() ?? 0)
                weapon?.spawn(bullet: bullet)
                bullets -= 1
            }
        }
    }
}
