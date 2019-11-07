//
//  MainNavigationController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18.10.2019.
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
    
    func toGameSceneViewController() {
        popToRootViewController(animated: false)
        pushViewController(GameViewController(), animated: false)
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
