//
//  GameScene.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var map : SKTileMapNode = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 10, rows: 10, tileSize: CGSize(width: 128, height: 128))
    
    func createNoiseMap() -> GKNoiseMap {
        //Get our noise source, this can be customized further
        let source = GKPerlinNoiseSource()
        //Initalize our GKNoise object with our source
        let noise = GKNoise.init(source)
        //Create our map,
        //sampleCount = to the number of tiles in the grid (row, col)
        let map = GKNoiseMap.init(noise, size: vector2(1.0, 1.0), origin: vector2(0, 0), sampleCount: vector2(10, 10), seamless: true)
        return map
    }
    
    var player: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "grena")
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
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        let noiseMap = createNoiseMap()
        map.enableAutomapping = true
        for col in 0..<10 {
            for row in 0..<10 {
                let val = noiseMap.value(at: vector2(Int32(row),Int32(col)))
                switch val {
                case -1.0..<(0.3):
                    if let g = tileSet.tileGroups.first(where: {
                        ($0.name ?? "") == ""}) {
                        map.setTileGroup(g, forColumn: col, row: row)
                    }
                default:
                    if let g = tileSet.tileGroups.first(where: {
                        ($0.name ?? "") == "Sand"}) {
                        map.setTileGroup(g, forColumn: col, row: row)
                    }
                }
             }
        }
        addChild(map)
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
