//
//  Unit.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 14.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class AnimatedUnit: SKSpriteNode {
    var defaultAnimation: SKAction
    var defaultTexture: SKTexture
    
    init(texture: SKTexture, animation: SKAction, location: CGPoint) {
        defaultTexture = texture
        defaultAnimation = animation
        super.init(texture: defaultTexture, color: .black, size: defaultTexture.size())
        position = location
    }
    
    required init?(coder aDecoder: NSCoder) {
        defaultAnimation = SKAction()
        defaultTexture = SKTexture()
        super.init(coder: aDecoder)
    }
    
}
