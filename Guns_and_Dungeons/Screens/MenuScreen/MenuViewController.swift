//
//  MenuViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var singlePlayerButton : UIButton?
    var multiPlayerButton : UIButton?
    var shopButton : UIButton?
    var settingsButton : UIButton?
    var background: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.background = UIImageView(frame: self.view.frame)
        self.background?.image = UIImage(named: "iron_back")
        self.view.addSubview(background!)
        
        let sq : CGFloat = 0.08
        let kw : CGFloat = 4
        singlePlayerButton = view.addButton(label: "Single player", target: self, selector: #selector(toSinglePlayerScreen),
                                            params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.3), k: kw, square: sq))
        singlePlayerButton?.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        multiPlayerButton = view.addButton(label: "Multi player Texture",
                                           target: self,
                                           selector: #selector(toMultiPlayerScreen),
                                           params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.5), k: kw, square: sq))
        multiPlayerButton?.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        shopButton =  view.addButton(label: "Shop", target: self, selector: #selector(toShopScreen),
                                     params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.7), k: kw, square: sq))
        shopButton?.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        settingsButton = view.addButton(label: "Settings", target: self, selector: #selector(toSettingScreen),
                                        params: LocationParameters(centerPoint: CGPoint(x: 0.9, y: 0.9), k: 1, square: 0.01))
        settingsButton?.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
    }
    
    @objc func toSinglePlayerScreen() {
        self.navigationController?.pushViewController(SinglePlayerViewController(), animated: true)
    }
    
    @objc func toMultiPlayerScreen() {
        self.navigationController?.pushViewController(MultiPlayerViewController(), animated: true)
    }
    
    @objc func toShopScreen() {
        self.navigationController?.pushViewController(ShopViewController(), animated: true)
    }
    
    @objc func toSettingScreen() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
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
