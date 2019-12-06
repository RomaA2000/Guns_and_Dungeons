//
//  Wearop.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 16.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import SpriteKit

class Weapon : SKSpriteNode {
    var clip : Clip?

    init(defaultTexture : SKTexture, clip : Clip?) {
        self.clip = clip
        super.init(texture: defaultTexture, color: .black, size: defaultTexture.size())
        self.clip?.changeWeapon(weapon: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getAngle() -> CGFloat {
        return zRotation
    }

    func spawn(bullet : Bullet) {
        scene?.addChild(bullet)
    }

    func fire(currentTime: TimeInterval) {
        clip.takeShot(currentTime: currentTime)
    }

    func replaceClip(clip : Clip) -> Clip {
        let lastClip = clip
        self.clip = clip
        self.clip?.changeWeapon(weapon: self)
        lastClip.changeWeapon(weapon: nil)
        return lastClip
    }
}
