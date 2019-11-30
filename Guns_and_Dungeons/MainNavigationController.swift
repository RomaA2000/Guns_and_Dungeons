//
//  MainNavigationController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//


import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setToolbarHidden(true, animated: true)
        setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func toGameSceneViewController(levelNumber: Int) {
        pushViewController(GameViewController(number: levelNumber), animated: true)
    }
    
    func toLevelSelectionViewController(statistics: LevelStatistics) {
        popViewController(animated: true)
        let singlePlayerViewController = self.topViewController as! SinglePlayerViewController
        singlePlayerViewController.setStatistics(statistics: statistics)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
