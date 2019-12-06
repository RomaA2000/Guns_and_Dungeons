//
//  ShopViewController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18/10/2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//
import Foundation
import UIKit

class ShopViewController : UIViewController {
    
    var backButton: UIButton!
    var previewer: UIReviewer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005)
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton.setBackgroundImage(UIImage(named: "unlocked"), for: .normal)
        
        let previewerLocationParams = LocationParameters(centerPoint: CGPoint(x: 0.15, y: 0.5), k: 0.4, square: 0.09)
        let previewerRect = getRect(parentFrame: view.bounds, params: previewerLocationParams)
        let previewerParams = UIReviewerPrams(frame: previewerRect, backImage: UIImage(named: "unlocked"))
        previewer = UIReviewer(params: previewerParams)
        self.view.addSubview(previewer)
        
        previewer.setCharacteristics(pack: CharactPack(speed: 1, armor: 2, hp: 3, damage: 4))
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
}
