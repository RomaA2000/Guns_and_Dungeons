//
//  Wearop.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 16.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import SpriteKit

protocol UnitHolder {
    func getAngleOnScene() -> CGFloat
}

class Weapon : SKSpriteNode {
    var clip : Clip?
    var spawnLength: CGFloat
    var base: UnitHolder?
    
    init(defaultTexture : SKTexture, clip : Clip?) {
        self.clip = clip
        self.spawnLength = defaultTexture.size().height * 0.8
        super.init(texture: defaultTexture, color: .black, size: defaultTexture.size())
        self.clip?.changeWeapon(weapon: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getAngle() -> CGFloat {
        return zRotation + .pi/2 + (base?.getAngleOnScene() ?? 0)
    }
    
    func spawn(bullet: Bullet) {
        let bulletPosition = CGPoint(x: 0, y: spawnLength)
        bullet.setVelocityVector(angle: self.getAngle())
        bullet.position = scene?.convert(bulletPosition, from: self) ?? CGPoint.zero
        scene?.addChild(bullet)
    }

    func fire(currentTime: TimeInterval) {
        clip?.takeShot(currentTime: currentTime)
    }

    func replaceClip(clip : Clip) -> Clip {
        let lastClip = clip
        self.clip = clip
        self.clip?.changeWeapon(weapon: self)
        lastClip.changeWeapon(weapon: nil)
        return lastClip
    }
}
