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

    var player: Player!
    var enemy: Enemy!
    var wall: Wall!
    
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
        
        //MARK:- test
        let animationTexturesParams = getAnimation(atlasName: "Enemy", frameName: "bot3a", defaultName: "bot3a1", size: 4)
        let animatedUnitParams = AnimatedUnitParams(animationParams: animationTexturesParams,
                                                    location: CGPoint.zero,
                                                    weapon: nil)
        let destroyableUnitParams = DestroyableUnitParams(animatedUnitParams: animatedUnitParams, healthPoints: 10, deathAnimation: animationTexturesParams.defaultAnimation)
        let mobileUnitParams = MobileUnitParams(destoyableUntiParams: destroyableUnitParams, maxSpeed: 10, walkAnimation: animationTexturesParams.defaultAnimation)
        let playerParams = PlayerParams(mobileUnitParams: mobileUnitParams)
        player = Player(params: playerParams)
        addChild(map);
        addChild(player)
        camera = cameraNode
        player.addChild(cameraNode)
        //MARK:- test
        
        enemy = Enemy(params: EnemyParams(mobileUnitParams: mobileUnitParams, purvewRange: 30));
        enemy.position = CGPoint(x: 100, y: 100);
        addChild(enemy)
        
        wall = Wall(defaultTexture: SKTexture(imageNamed: "fon"), location: CGRect(x: 200, y: 100, width: 100, height: 100))
        addChild(wall)
        
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
    
    func checkCollision(contact: SKPhysicsContact, firstType: UInt32, secondType: UInt32) -> [SKNode?]? {
        if (contact.bodyA.node?.physicsBody?.categoryBitMask == firstType &&
            contact.bodyB.node?.physicsBody?.categoryBitMask == secondType) {
            return [contact.bodyA.node, contact.bodyB.node]
        }
        else if (contact.bodyB.node?.physicsBody?.categoryBitMask == firstType &&
                contact.bodyA.node?.physicsBody?.categoryBitMask == secondType) {
            return [contact.bodyB.node, contact.bodyA.node]
        }
        return nil
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let bodies = checkCollision(contact: contact, firstType: CategoryMask.player, secondType: CategoryMask.wall) {
            let player = bodies[0]
            print("kek")
            player?.physicsBody?.velocity = CGVector.zero
            player!.position = CGPoint.zero
        }
    }

    override func update(_ currentTime: TimeInterval) {
        player.physicsBody!.velocity = CGVector(dx: moveJoystick.velocity.x * 2, dy: moveJoystick.velocity.y * 2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        player.zRotation += 30
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
