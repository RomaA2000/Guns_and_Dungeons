//
//  MenuViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

 
    var singlePlayerButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let singlePlayerButton = UIButton();
        let multiPlayerButton = UIButton();
        let shopButton = UIButton()
        let settingsButton = UIButton()
        singlePlayerButton.setUpButton(label : "Single player Texture", color : .black, translatesMask: false)
        multiPlayerButton.setUpButton(label : "Multi player Texture", color : .black, translatesMask: false)
               shopButton.setUpButton(label : "Shop Texture", color : .black, translatesMask: false)
               settingsButton.setUpButton(label : "Setting Texture", color : .black, translatesMask: false)
        view.add
        // Do any additional setup after loading the view.
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
