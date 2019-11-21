//
//  Wall.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 20.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import SpriteKit

class Wall: SKSpriteNode {
    
    init(defaultTexture: SKTexture, location: CGRect) {
        super.init(texture: defaultTexture, color: .black, size: location.size);
        self.position = location.origin
        self.physicsBody = SKPhysicsBody.init(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CategoryMask.wall
        self.physicsBody?.collisionBitMask = CategoryMask.player | CategoryMask.bullet | CategoryMask.enemy
        self.physicsBody?.contactTestBitMask = self.physicsBody!.collisionBitMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
