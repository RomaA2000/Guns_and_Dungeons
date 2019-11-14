//
//  Wall.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 14.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode {
    
    init(textureName: String, size: CGSize) {
        let spriteTexture = SKTexture(imageNamed: textureName)
        super.init(texture: spriteTexture, color: .black, size: size)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        name = "wall"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
