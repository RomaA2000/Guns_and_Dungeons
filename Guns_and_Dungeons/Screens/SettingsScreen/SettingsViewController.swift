//
//  SettingsViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class SettingsViewController : UIViewController, SwitcherDelegate {
    
    var backButton: UIButton!
    var saveButton: UIButton!
    var switchView: UISwitch!
    var titleView: UILabel!
    
    var soundLabel: UILabel!
    var soundSwitch: Switcher!
    var soundIcon: UIIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let yPos: CGFloat = 0.9
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: yPos), k: 1.25, square: 0.005)
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        let saveButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.3, y: yPos), k: 1.25, square: 0.005)
        saveButton = self.view.addButton(label: "Save", target: self, selector: #selector(saveSettings), params: saveButtonParams)
        saveButton.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        let titleLocationParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.1), k: 5, square: 0.08)
        titleView = UILabel(frame: getRect(parentFrame: self.view.bounds, params: titleLocationParams))
        titleView.text = "Settings"
        titleView.textAlignment = .center
        self.view.addSubview(titleView)
        
        self.createSoundSection()
    }
    
    func createSoundSection() {
        let yPos: CGFloat = 0.5
        
        let soundLabelParams = LocationParameters(centerPoint: CGPoint(x: 0.3, y: yPos), k: 2, square: 0.01)
        let soundLabelFrame = self.view.getRectInSelf(location: soundLabelParams)
        soundLabel = UILabel(frame: soundLabelFrame)
        soundLabel.text = "Sound"
        soundLabel.textAlignment = .center
        self.view.addSubview(soundLabel)
        
        let switcherParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: yPos), k: 2, square: 0.01)
        let switcherFrame = self.view.getRectInSelf(location: switcherParams)
        soundSwitch = Switcher(frame: switcherFrame, backgroundImage: UIImage(named: "btnplay"), buttonImage: UIImage(named: "selecter"))
        self.view.addSubview(soundSwitch)
        
        soundSwitch.delegate = self
        
        let soundIconParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: yPos), k: 1, square: 0.01)
        let soundIconFrame = self.view.getRectInSelf(location: soundIconParams)
        soundIcon = UIIndicator(frame: soundIconFrame, imageOn: UIImage(named: "indic_on"), imageOff: UIImage(named: "indic_off"))
        self.view.addSubview(soundIcon)
        
        let isSoundEnabled: Bool = UserDefaults.standard.bool(forKey: "sound")
        print("state: ", isSoundEnabled)
        soundSwitch.setState(state: isSoundEnabled)
    }
        
    func stateChanged(_ sender: Switcher) {
        self.soundIcon.switchState(toState: sender.state)
    }
    
    @objc func saveSettings() {
        let soundState: Bool = soundSwitch.state
        let userDefaults = UserDefaults.standard
        userDefaults.set(soundState, forKey: "sound")
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}
