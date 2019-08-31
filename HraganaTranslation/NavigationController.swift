//
//  NavigationController.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/06.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Barの色を変更
        navigationBar.barTintColor = UIColor.white
        //itemの色を変更
        navigationBar.tintColor = UIColor.orange
        //タイトルの色を変更
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.orange
        ]
    }
}
