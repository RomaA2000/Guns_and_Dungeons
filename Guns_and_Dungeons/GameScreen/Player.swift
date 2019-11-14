//
//  Player.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 09.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {

    let walkAnimation: SKAction
    var textures: [SKTexture] = []

    init(atlasName: String) {
        let textureAtlas = SKTextureAtlas(named: atlasName)
        for i in 0...textureAtlas.textureNames.count - 1 {
            let name = "bot3a\(i + 1).png"
            textures.append(SKTexture(imageNamed: name))
        }
        walkAnimation = SKAction.repeatForever(SKAction.animate(with: textures,
                                                                timePerFrame: 0.1,
                                                                resize: false,
                                                                restore: true))
        
        super.init(texture: textures.first!, color: .black, size: textures.first!.size())
        position = CGPoint(x: 100, y: 100)
        physicsBody = SKPhysicsBody(circleOfRadius: textures.first!.size().width / 2)
        physicsBody?.affectedByGravity = false
        name = "player"
//        blendMode = .replace // if we have no alpha components in sprite's texturea
    }
    
    func startMove() {
        run(walkAnimation, withKey: "walk")
    }
    
    func stopMove() {
        removeAction(forKey: "walk")
        texture = textures.first!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
