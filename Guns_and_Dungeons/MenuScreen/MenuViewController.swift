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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let sq : CGFloat = 0.08
        let kw : CGFloat = 5
        singlePlayerButton = view.addButton(label: "Single player Texture", target: self, selector: #selector(toSinglePlayerScreen),
                                            params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.3), k: kw, square: sq))
        multiPlayerButton = view.addButton(label: "Multi player Texture", target: self, selector: #selector(toMultiPlayerScreen),
                                           params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.5), k: kw, square: sq))
        shopButton =  view.addButton(label: "Shop", target: self, selector: #selector(toShopScreen),
                                     params: LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.7), k: kw, square: sq))
        settingsButton = view.addButton(label: "Settings", target: self, selector: #selector(toSettingScreen),
                                        params: LocationParameters(centerPoint: CGPoint(x: 0.9, y: 0.9), k: 1, square: 0.01))
        
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
        print("data: ", UserDefaults.standard.bool(forKey: "sound"))
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
