//
//  HomeCoordinator.swift
//  MakeItGreat
//
//  Created by Tales Conrado on 20/11/20.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        return homeViewController
    }
    
    var homeViewController: HomeViewController
    var tabBarCoordinator: TabBarCoordinator?
    
    init() {
        let viewModel = HomeViewModel()
        homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.homeCoordinator = self
        // seta aqui quem é o viewModel da home,
        // que deve ser passado, podendo ser inicializado aqui ou passado pelo init
    }
    
    func reloadCalendarUponCompletingTask() {
        tabBarCoordinator?.reloadCalendar()
    }
    func reloadBadgesDataUponCompletingTask() {
        tabBarCoordinator?.reloadBadges()
    }
}
