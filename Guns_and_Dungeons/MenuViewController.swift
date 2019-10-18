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
        view.backgroundColor = .white
        let sq : CGFloat = 0.08
        let kw : CGFloat = 5
        view.addButton(label: "Single player Texture",
                       params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.5), k: kw, square: sq))
        view.addButton(label: "Multi player Texture",
                       params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.3), k: kw, square: sq))
        view.addButton(label: "Shop",
                       params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.7), k: kw, square: sq))
        view.addButton(label: "Settings",
        params: AllParameters(centerPoint: CGPoint(x: 0.9, y: 0.9), k: 1, square: 0.01))
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
