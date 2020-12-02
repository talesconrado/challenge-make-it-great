//
//  AchievementsCoordinator.swift
//  MakeItGreat
//
//  Created by Tales Conrado on 20/11/20.
//

import UIKit

class AchievementsCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        return achievementsViewController
    }
    
    var achievementsViewController: AchievementsViewController
    
    init() {
        achievementsViewController = AchievementsViewController()
    }
}
