//
//  GameScene.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18.10.2019.
//  Copyright © 2019 Алесандр Потапов. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "fon")
        sprite.position = CGPoint.zero
        sprite.scale(to: CGSize(width: 100, height: 100))
        return sprite
    }()
    
    var player: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "bot")
        sprite.position = CGPoint.zero
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.affectedByGravity = false;
        return sprite
    }()
    
    var grena: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "grena")
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.affectedByGravity = false;
        return sprite
    }()
    
    override func didMove(to view: SKView) {
        addChild(player)
        addChild(grena)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print(location)
            let move = SKAction.move(to: location, duration: 1)
            player.run(move)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
