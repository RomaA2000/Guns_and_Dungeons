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
    let fireJoystick = AnalogJoystick(withDiameter: 100)
    let cameraNode: SKCameraNode = SKCameraNode()

    var player: Player!
    var enemy: Enemy!
    var wall: Wall!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //map
        
        
       
        //map
        player = createPlayer()
        addChild(player)
        camera = cameraNode
        player.addChild(cameraNode)
        //MARK:- test
        
        wall = Wall(defaultTexture: SKTexture(imageNamed: "fon"), location: CGRect(x: 200, y: 100, width: 100, height: 100))
        addChild(wall)
        
        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: -frame.width / 2, y: -frame.height / 2, width: frame.width / 2, height: frame.height))
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystick.isMoveable = true
        cameraNode.addChild(moveJoystickHiddenArea)
        
        let fireJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: 0, y: -frame.height / 2, width: frame.width / 2, height: frame.height))
        fireJoystickHiddenArea.joystick = fireJoystick
        fireJoystick.isMoveable = true
        cameraNode.addChild(fireJoystickHiddenArea)
        
        view.isMultipleTouchEnabled = true
    }
    
    func checkCollision(contact: SKPhysicsContact, firstType: UInt32, secondType: UInt32) -> [SKNode?]? {
        if (contact.bodyA.node?.physicsBody?.categoryBitMask == firstType &&
            contact.bodyB.node?.physicsBody?.categoryBitMask == secondType) {
            return [contact.bodyA.node, contact.bodyB.node]
        } else if (contact.bodyB.node?.physicsBody?.categoryBitMask == firstType &&
                contact.bodyA.node?.physicsBody?.categoryBitMask == secondType) {
            return [contact.bodyB.node, contact.bodyA.node]
        }
        return nil
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let bodies = checkCollision(contact: contact, firstType: CategoryMask.player, secondType: CategoryMask.wall) {
            let player = bodies[0]
            player?.physicsBody?.velocity = CGVector.zero
            player!.position = CGPoint.zero
        }
    }

    override func update(_ currentTime: TimeInterval) {
        player.physicsBody!.velocity = CGVector(dx: moveJoystick.velocity.x * 2, dy: moveJoystick.velocity.y * 2)
        if (!fireJoystick.isHidden) {
            player.zRotation = fireJoystick.angular
            cameraNode.zRotation = -player.zRotation
        } else if (!moveJoystick.isHidden) {
            player.zRotation = moveJoystick.angular
            cameraNode.zRotation = -player.zRotation
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func createPlayer() -> Player {
        let animationTexturesParams = getAnimation(atlasName: "Enemy", frameName: "bot3a", defaultName: "bot3a1", size: 4)
        let animatedUnitParams = AnimatedUnitParams(animationTexturesParams: animationTexturesParams,
                                                    location: CGPoint.zero,
                                                    weapon: nil)
        let destroyableUnitParams = DestroyableUnitParams(animatedUnitParams: animatedUnitParams, healthPoints: 10, deathAnimation: animationTexturesParams.defaultAnimation)
        let mobileUnitParams = MobileUnitParams(destoyableUntiParams: destroyableUnitParams, maxSpeed: 10, walkAnimation: animationTexturesParams.defaultAnimation)
        let playerPhysicsBodyMask = PhysicsBodyMask(category: CategoryMask.player, collision: CategoryMask.ai | CategoryMask.wall, contact: CategoryMask.bullet)
        
        let playerParams = PlayerParams(mobileUnitParams: mobileUnitParams, mask: playerPhysicsBodyMask, radius: mobileUnitParams.defaultTexture.size().width / 2)
        return Player(params: playerParams)
    }
}
