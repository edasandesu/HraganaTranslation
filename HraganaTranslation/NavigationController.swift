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
        // Do any additional setup after loading the view.
        navigationBar.barTintColor = UIColor.white
        //itemの色を変更
        navigationBar.tintColor = UIColor.orange
        //タイトルの色を変更
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.orange
        ]
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
