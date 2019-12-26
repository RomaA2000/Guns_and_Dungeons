//
//  Bullet.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 05.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : SKSpriteNode {
    var maxVelocity : CGFloat = 0
    let damage: UInt64
    
    init(defaultTexture : SKTexture, damage: UInt64) {
        self.damage = damage
        
        super.init(texture: defaultTexture, color: .black, size: defaultTexture.size())
        
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.frame.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CategoryMask.bullet
        self.physicsBody?.collisionBitMask = CategoryMask.player | CategoryMask.ai | CategoryMask.wall
        self.physicsBody?.contactTestBitMask = self.physicsBody!.collisionBitMask
        self.physicsBody?.mass = 0
        
        self.zPosition = 2
    }

    func setVelocityVector(angle: CGFloat) {
        physicsBody?.velocity = CGVector(dx: cos(angle) * maxVelocity, dy : sin(angle) * maxVelocity)
    }
    
    func setVelocityVector(direction: CGVector) {
        physicsBody?.velocity = CGVector(dx: direction.dx * maxVelocity, dy : direction.dy * maxVelocity)
    }
    
    func setVelocityVector(angle: CGFloat, length: CGFloat) {
        maxVelocity = length
        setVelocityVector(angle: angle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


