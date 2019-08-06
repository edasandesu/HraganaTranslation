//
//  FavoriteViewController.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/06.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var inputArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "FavoriteCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "FavoriteCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationBar.delegate = self
        navigationBarSetting()
        
        UserDefaults.standard.removeObject(forKey: "inputArray")
        UserDefaults.standard.removeObject(forKey: "outputArray")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //お気に入りに保存されたものを取得する
        if UserDefaults.standard.object(forKey: "inputArray") != nil,
            UserDefaults.standard.object(forKey: "outputArray") != nil {
            inputArray = UserDefaults.standard.array(forKey: "inputArray") as! [String]
            outputArray = UserDefaults.standard.array(forKey: "outputArray") as! [String]
            collectionView.reloadData()
        } else {
            
        }
    }
    
    func navigationBarSetting() {
        //navigationBarの色を設定
        navigationBar.barTintColor = UIColor.white
        //navigationBarのitemの色を変更
        navigationBar.tintColor = UIColor.orange
        //navigationBarのタイトルの色を変更
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.orange
        ]
    }
}
extension FavoriteViewController: UICollectionViewDelegate {
    
}
extension FavoriteViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inputArray.count == 0 {
            return 1
        } else {
            return inputArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        if inputArray.count == 0 {
            cell.inputLabel.text = "お気に入りを保存するとここに表示されます。"
            cell.outputLabel.text = ""
            return cell
        } else {
            cell.inputLabel.text = inputArray[indexPath.row]
            cell.outputLabel.text = outputArray[indexPath.row]
            return cell
        }
    }
}
extension FavoriteViewController: UINavigationBarDelegate {
    //navigationBarのPositionをステータスバーまで伸ばす
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
