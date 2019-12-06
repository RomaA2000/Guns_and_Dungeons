//
//  Bullet.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 11.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    
    var textures: [SKTexture] = []
    var flyAnimation: SKAction
    
    init(atlasName: String) {
        let textureAtlas = SKTextureAtlas(named: atlasName)
        for i in 0...textureAtlas.textureNames.count - 1 {
            let name = "bot3a\(i + 1).png"
            textures.append(SKTexture(imageNamed: name))
        }
        flyAnimation = SKAction.repeatForever(SKAction.animate(with: textures,
                                                                timePerFrame: 0.1,
                                                                resize: false,
                                                                restore: true))
        
        super.init(texture: SKTexture(imageNamed: "rocket1"), color: .black, size: SKTexture(imageNamed: "rocket1").size())
        position = CGPoint(x: 100, y: 100)
        physicsBody = SKPhysicsBody(circleOfRadius: textures.first!.size().width / 2)
        physicsBody?.affectedByGravity = false
//        blendMode = .replace // if we have no alpha components in sprite's texturea
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        print("kek")
    }
    
}
