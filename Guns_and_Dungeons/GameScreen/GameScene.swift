//
//  GameScene.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18.10.2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//


import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {

    let moveJoystick = AnalogJoystick(withDiameter: 100)

    var map : SKTileMapNode = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 10, rows: 10, tileSize: CGSize(width:                128, height: 128))

    let cameraNode: SKCameraNode = {
        let cameraNode = SKCameraNode()
        return cameraNode
    }()

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

    var player: Player = Player(atlasName: "AnimatedTextures")
    var wall: Wall = Wall(textureName: "fon", size: CGSize(width: 100, height: 200))

    var grena: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "grena")
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.affectedByGravity = false;
        sprite.name = "grena"
        return sprite
    }()

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        let noiseMap = createNoiseMap()
        map.enableAutomapping = true
        for col in 0..<10 {
            for row in 0..<10 {
                let val = noiseMap.value(at: vector2(Int32(row),Int32(col)))
                switch val {
                case -1.0..<(0.3):
                    if let g = tileSet.tileGroups.first(where: {
                        ($0.name ?? "") == "Grass"}) {
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
        wall.position = CGPoint(x: -100, y: -100)
        addChild(wall)
        camera = cameraNode
        player.addChild(cameraNode)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: -frame.width / 2, y: -frame.height / 2, width: frame.width, height: frame.height))
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystick.isMoveable = true
        player.addChild(moveJoystickHiddenArea)
        view.isMultipleTouchEnabled = true
    }

//    func explode(bullet: SKNode, enemy: SKNode) {
//        bullet.removeFromParent()
//        print("explode")
//    }


//    func didBegin(_ contact: SKPhysicsContact) {
//        print("contact")
//        if contact.bodyA.node?.name == "bullet" {
//            explode(bullet: contact.bodyA.node!, enemy: contact.bodyB.node!)
//        } else if contact.bodyB.node?.name == "bullet" {
//            explode(bullet: contact.bodyB.node!, enemy: contact.bodyA.node!)
//        }
//        if (contact.bodyA.node?.name == "wall" && contact.bodyB.node?.name == "player") {
//            print("p vs w")
//            (contact.bodyB.node as? Player)!.removeAction(forKey: "walk")
//        } else if (contact.bodyB.node?.name == "wall" && contact.bodyA.node?.name == "player") {
//            print("p vs w")
//            (contact.bodyA.node as? Player)!.removeAction(forKey: "walk")
//
//        }
//    }

    override func update(_ currentTime: TimeInterval) {
        if (moveJoystick.velocity != CGPoint.zero) {
            player.physicsBody!.velocity = CGVector(dx: moveJoystick.velocity.x * 2, dy: moveJoystick.velocity.y * 2)
        }
    }

//    func touchDown(atPoint pos : CGPoint) {
//
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//
//    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.location(in: self)
//            let move = SKAction.move(to: location, duration: 1)
//
//
//            player.zRotation += 0.5
//            camera?.zRotation -= 0.5
//
//            player.run(move)
//            player.startMove()
//
//            let bullet = Bullet(atlasName: "AnimatedTextures")
//            bullet.name = "bullet"
//            bullet.position = CGPoint(x: player.position.x + 50, y: player.position.y)
//            addChild(bullet)
//            let action = SKAction.move(by: CGVector(dx: 1000, dy: 0), duration: 2)
//            bullet.physicsBody?.contactTestBitMask = bullet.physicsBody!.collisionBitMask
//            bullet.run(action)
//        }
////    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        camera?.position = touches.first!.location(in: self)
//        player.stopMove()
//    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
