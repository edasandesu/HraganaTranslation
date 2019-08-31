//
//  TabBarController.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/06.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.orange
        tabBar.unselectedItemTintColor = UIColor.orange.withAlphaComponent(0.3)
    }
}
