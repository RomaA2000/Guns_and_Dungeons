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

    init(weapon : Weapon?, bullets : UInt64, spawner : @escaping () -> Bullet?) {
        self.weapon = weapon
        self.bullets = bullets
        self.makeBullet = spawner
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
