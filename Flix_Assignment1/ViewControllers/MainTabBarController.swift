//
//  MainTabBarController.swift
//  Flix_Assignment1
//
//  Created by Mike Chu on 7/24/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
        let nowPlayingController = NowPlayingViewController()
        let nowPlayingNavController = UINavigationController(rootViewController: nowPlayingController)
        nowPlayingController.tabBarItem.image = #imageLiteral(resourceName: "now_playing_tabbar_item")
        nowPlayingController.title = "Now Playing"
        
        let layout = UICollectionViewFlowLayout()
        let galleryViewController = GalleryViewController(collectionViewLayout: layout)
        let galleryNavController = UINavigationController(rootViewController: galleryViewController)
        galleryNavController.tabBarItem.image = #imageLiteral(resourceName: "superhero_tabbar_item")
        galleryNavController.title = "Gallery"
        
        tabBar.tintColor = .black
        viewControllers = [nowPlayingNavController, galleryNavController]
        
    }
}
