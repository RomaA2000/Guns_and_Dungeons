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
    var tabsView: TabsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let tabsViewParams = LocationParameters(centerPoint: CGPoint(x: 0.6, y: 0.5), k: 1.5, square: 0.4)
        let buttonToGuns = UIButton()
        buttonToGuns.setTitle("To guns", for: .normal)
        buttonToGuns.backgroundColor = .red
        let buttonToBases = UIButton()
        buttonToBases.setTitle("TO bases", for: .normal)
        buttonToBases.backgroundColor = .red
        tabsView = TabsView(frame: getRect(parentFrame: self.view.frame, params: tabsViewParams), tabPart: 0.1,
                            tabs: [buttonToGuns, buttonToBases])
        self.view.addSubview(tabsView)
        tabsView.delegate = self
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.006)
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

extension ShopViewController: TabsViewDelegate {
    func tabSelected(tabNumber: Int) {
        print("new tab selected")
    }
    
}
