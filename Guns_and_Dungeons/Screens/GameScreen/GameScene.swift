//
//  GameScene.swift
//  Guns_andDungeons
//
//  Created by Александр Потау on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    weak var viewController: GameViewController?

    let moveJoystick = AnalogJoystick(withDiameter: 100)
    let fireJoystick = AnalogJoystick(withDiameter: 100)
    let cameraNode: SKCameraNode = SKCameraNode()

    var player: Player!
    var wall: Wall!
    var pauseButton: Button!
    var enemyController: EnemiesController!
    var textureAtlas: SKTextureAtlas!
    var levelNumber : UInt64 = 1
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player = createPlayer()
        addChild(player)
        camera = cameraNode
        player.addChild(cameraNode)
        
        textureAtlas = SKTextureAtlas(named: "tex")
        textureAtlas.preload { print("preloaded")  }
        enemyController = EnemiesController(atlas: textureAtlas, scene: scene!, levelNumber : levelNumber)

        let sensitivity: CGFloat = 0.5
        
        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: 0, y: -frame.height / 2, width: frame.width / 2, height: frame.height))
        moveJoystickHiddenArea.joystick = moveJoystick
        moveJoystick.isMoveable = true
        cameraNode.addChild(moveJoystickHiddenArea)
        moveJoystick.sensitivityBias = sensitivity

        let fireJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: -frame.width / 2, y: -frame.height / 2, width: frame.width / 2, height: frame.height))
        fireJoystickHiddenArea.joystick = fireJoystick
        fireJoystick.isMoveable = true
        cameraNode.addChild(fireJoystickHiddenArea)
        fireJoystick.sensitivityBias = sensitivity
        
        view.isMultipleTouchEnabled = true
        
        let pauseDefault = SKTexture(imageNamed: "pausebutton0")
        let pauseTexture = SKTexture(imageNamed: "pausebutton1")
        let pauseLocationParams = LocationParameters(centerPoint: CGPoint(x: 0, y: 0.15), k: 1, square: 0.001)
        pauseButton = Button(defaultTexture: pauseDefault, pressedTexture: pauseTexture,
                             params: pauseLocationParams, sceneFrame: self.frame)
        pauseButton.position = CGPoint(x: 0, y: 180 * (frame.size.width / 650))
        print(self.frame.size)
        pauseButton.zPosition = 15
        cameraNode.addChild(pauseButton)
    }
    
    func checkCollision(contact: SKPhysicsContact, firstType: UInt32, secondType: UInt32) -> (first: SKNode?, second: SKNode?)? {
        if (contact.bodyA.node?.physicsBody?.categoryBitMask == firstType &&
            contact.bodyB.node?.physicsBody?.categoryBitMask == secondType) {
            return (contact.bodyA.node, contact.bodyB.node)
        } else if (contact.bodyB.node?.physicsBody?.categoryBitMask == firstType &&
                contact.bodyA.node?.physicsBody?.categoryBitMask == secondType) {
            return (contact.bodyB.node, contact.bodyA.node)
        }
        return nil
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let (bullet, _) =         checkCollision(contact: contact,
                                                    firstType: CategoryMask.bullet,
                                                    secondType: CategoryMask.wall) {
            bullet?.removeFromParent()
        } else if let (bullet, unit) = checkCollision(contact: contact,
                                                    firstType: CategoryMask.bullet,
                                                    secondType: CategoryMask.ai){
            (unit as? DestroyableUnit)?.healthPoints
                -= Int64((bullet as? Bullet)?.damage ?? 0)
            bullet?.removeFromParent()
        }
        
    }

    override func update(_ currentTime: TimeInterval) {
        player.moveByVector(direction: CGVector(p1: CGPoint.zero, p2: moveJoystick.velocity))
        if (fireJoystick.isActivated()) {
            player.rotateGunTo(angel: fireJoystick.angular)
            cameraNode.zRotation = -player.zRotation
            player.weapon?.fire(currentTime: currentTime)
        }
        if (moveJoystick.isActivated()) {
            player.zRotation = moveJoystick.angular
            cameraNode.zRotation = -player.zRotation
        }
        enemyController.update(currentTime)
        if (enemyController.outOfCharge) {
            endGame()
        }
    }
    
    func endGame() {
        self.physicsWorld.speed = 0
        self.isPaused = true
        self.viewController?.toLevelSelectionScreen()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    
    func createPlayer() -> Player {
        let animationTexturesParams = getAnimation(atlasName: "player", frameName: "pl", defaultName: "pl1", size: 4)
        let clip: Clip = Clip(bullets: 100, spawner: { return Bullet(defaultTexture: SKTexture(imageNamed: "bullet"), damage: 1)}, frequence: 1, bulletSpeed: 1000)
        let weapon: Weapon = Weapon(defaultTexture: SKTexture(imageNamed: "gun1"), clip: clip)
        let animatedUnitParams = AnimatedUnitParams(animationTexturesParams: animationTexturesParams,
                                                    location: CGPoint.zero,
                                                    weapon: weapon)
        let destroyableUnitParams = DestroyableUnitParams(animatedUnitParams: animatedUnitParams, healthPoints: 10, deathAnimation: animationTexturesParams.defaultAnimation)
        let mobileUnitParams = MobileUnitParams(destoyableUntiParams: destroyableUnitParams, maxSpeed: 5, walkAnimation: animationTexturesParams.defaultAnimation)
        let playerPhysicsBodyMask = PhysicsBodyMask(category: CategoryMask.player, collision: CategoryMask.ai | CategoryMask.wall, contact: CategoryMask.bullet)
        
        let playerParams = PlayerParams(mobileUnitParams: mobileUnitParams, mask: playerPhysicsBodyMask, radius: mobileUnitParams.defaultTexture.size().width / 2)
        return Player(params: playerParams)
    }
}
