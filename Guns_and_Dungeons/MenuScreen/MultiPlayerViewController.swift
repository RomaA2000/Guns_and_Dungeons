//
//  MultiPlayerViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//


import Foundation
import UIKit

class MultiPlayerViewController : UIViewController {
    
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005)
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton?.setBackgroundImage(UIImage(named: "locked"), for: .normal)
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
