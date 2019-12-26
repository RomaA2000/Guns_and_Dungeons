//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIResponder {
    func parent<T>(implementing proto: T.Type) -> T? {
        return sequence(first: self) { $0.next }
            .dropFirst()
            .first { $0 is T } as? T
    }
}

class AboutLevels {
    var nowPanel : UInt64 = 0
}

class SinglePlayerViewController : UIViewController, Callable {
    var levelPanel : PanelsScrollView<PanelButton>!
    var backButton: UIButton = UIButton()
    static let stack = DataBaseController()
    var levelsPerPanel: UInt64 = 4
    var levelsNumber: UInt64 = 20
    private typealias SPVC = SinglePlayerViewController
    var background: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
        self.background = UIImageView(frame: self.view.frame)
        self.background?.image = UIImage(named: "iron_back")
        self.view.addSubview(background!)
        
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                    params: LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        backButton.setBackgroundImage(UIImage(named: "btnplay"), for: .normal)
        
        levelsNumber = 20
        levelsPerPanel = 4
        makePanelScrollView()
    }
    
    func makePanelScrollView() {
        levelPanel = PanelsScrollView(parrentBounds: view.bounds, panelsNumber: 5, elementsPerPanel: 4)
        view.addSubview(levelPanel)
        
        var statistics: [Statistics] = []
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: false)]
        do {
            statistics = try SPVC.stack.context.fetch(request)
        }
        catch {
            statistics = []
        }
        
        var buttonsParams : [PanelButtonParams] = []
        for number in 0..<levelsNumber {
            if (number < statistics.count) {
                buttonsParams.append(makeUnlockedButtonParams(number: number, stars: UInt64(statistics[Int(number)].stars)))
            }
            else if (number == statistics.count) {
                buttonsParams.append(makeUnlockedButtonParams(number: number, stars: UInt64(0)))
            }
            else {
                buttonsParams.append(makeLockedButtonParams())
            }
        }
        levelPanel.createElementsOnPanels(params: buttonsParams)
    }
    
    func makeLockedButtonParams() -> PanelButtonParams {
        let lockedImage = UIImage(named: "infoplacelocked")
        let location: LocationParameters = LocationParameters(centerPoint: CGPoint.zero, k: 1.5, square: 0.06)
        let buttonParams = ButtonParams(location: location, defaultTexture: lockedImage, pressedTexture: nil, label: "")
        return PanelButtonParams(buttonParams: buttonParams)
    }
    
    func makeUnlockedButtonParams(number: UInt64, stars: UInt64 = 0) -> PanelButtonParams {
        let unlockedImage = UIImage(named: "infoplace")
        let starImage = UIImage(named: "star")
        let location: LocationParameters = LocationParameters(centerPoint: CGPoint.zero, k: 1.5, square: 0.06)
        let buttonParams = ButtonParams(location: location, defaultTexture: unlockedImage, pressedTexture: nil)
        let panelButtonParams = PanelButtonParams(buttonParams: buttonParams, starTexture: starImage, number: number, stars: stars)
        return panelButtonParams
    }
    
    func updateLevelButton(number: UInt64, stars: UInt64 = 0) {
        levelPanel.setElement(number: number, params: makeUnlockedButtonParams(number: number, stars: stars))
    }
    
    func setStatistics(levelStatistics: LevelStatistics) {
        let statistics: [Statistics] = getStatistics()
        if (levelStatistics.levelNumber == statistics.count) {
            updateLevelButton(number: levelStatistics.levelNumber, stars: levelStatistics.stars)
            saveStatistics(levelStatistics: levelStatistics)
            updateLevelButton(number: levelStatistics.levelNumber + 1)
        }
        else if (levelStatistics.stars > statistics[Int(levelStatistics.levelNumber)].stars) {
            updateLevelButton(number: levelStatistics.levelNumber, stars: levelStatistics.stars)
            saveStatistics(levelStatistics: levelStatistics)
        }
    }
    
    func saveStatistics(levelStatistics: LevelStatistics) {
        SPVC.stack.context.perform {
            let updatedStatistics = Statistics(context: SPVC.stack.context)
            updatedStatistics.levelNumber = Int16(levelStatistics.levelNumber)
            updatedStatistics.stars = Int16(levelStatistics.stars)
            try! SPVC.stack.context.save()
        }
    }
    
    func getStatistics() -> [Statistics] {
        var statistics: [Statistics] = []
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "levelNumber", ascending: false)]
        statistics = try! SPVC.stack.context.fetch(request)
        return statistics
    }
    
    func call(number: UInt64) {
        (navigationController as! MainNavigationController).toGameSceneViewController(levelNumber: number)
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}

