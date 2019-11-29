//
//  GameViewController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18.10.2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var levelNumber: Int = 0
    var gameScene: SKScene?
    
    convenience init(number: Int) {
        self.init()
        levelNumber = number
    }
    
    override func loadView() {
        let sceneView = SKView()
        sceneView.backgroundColor = .white
        
        self.view = sceneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Level-\(levelNumber)") {
                gameScene = scene
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                (scene as? GameScene)?.viewController = self
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func toLevelSelectionScreen() {
        gameScene?.isPaused = true
        let mainNavigationController = navigationController as! MainNavigationController
        mainNavigationController.toLevelSelectionViewController(statistics: LevelStatistics(levelNumber: Int16(levelNumber), stars: 1))
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
