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
        // Do any additional setup after loading the view.
        tabBar.tintColor = UIColor.orange
        tabBar.unselectedItemTintColor = UIColor.orange.withAlphaComponent(0.3)
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
