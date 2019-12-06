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
    
    init(defaultTexture : SKTexture) {
        super.init(texture: defaultTexture, color: .black, size: defaultTexture.size())
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.frame.width / 2)
    }

    func setVelocityVector(angle: CGFloat) {
        physicsBody?.velocity = CGVector(dx: cos(angle) * maxVelocity, dy : sin(angle) * maxVelocity)
    }
    
    func setVelocityVector(angle: CGFloat, length: CGFloat) {
        maxVelocity = length
        setVelocityVector(angle: angle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


