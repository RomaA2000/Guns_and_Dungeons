//
//  MultiPlayerViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import Foundation
import UIKit

class ArcadeViewController : UIViewController {
    
    var backButton: UIButton!
    var background: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.background = UIImageView(frame: self.view.frame)
        self.background?.image = UIImage(named: "iron_back")
        self.view.addSubview(background!)
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005)
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
