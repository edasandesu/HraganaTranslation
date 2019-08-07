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
        
        //長押しのgestureを使えるようにする
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(sender:)))
        //長押しの時間を決める
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(longPressRecognizer)
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
    @objc func cellLongPressed(sender: UILongPressGestureRecognizer) {
        // 押された位置のcellを取得
        let point = sender.location(in: collectionView)
        //cellのindexPathを取得
        let indexPath = collectionView.indexPathForItem(at: point)
        if indexPath == nil {
            //長押しされた場所にcellが無いときは何もしない
        } else if sender.state == UIGestureRecognizer.State.ended  {
            // 長押しされた場合の処理
            let alert = UIAlertController(title: "削除しますか？", message: "", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "削除", style: UIAlertAction.Style.default, handler: {
                //ボタンが押された時の処理を書く(クロージャ実装)
                (action: UIAlertAction!) -> Void in
                //配列にあるinput,outputのデータを削除
                self.inputArray.remove(at: indexPath!.row)
                self.outputArray.remove(at: indexPath!.row)
                //UserDefaultsにあるデータを削除
                UserDefaults.standard.removeObject(forKey: "inputArray")
                UserDefaults.standard.removeObject(forKey: "outputArray")
                self.collectionView.reloadData()
                //UserDefaultsに再度保存
                UserDefaults.standard.set(self.inputArray, forKey: "inputArray")
                UserDefaults.standard.set(self.outputArray, forKey: "outputArray")
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                print("cancel")
            }
            alert.addAction(OKAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelect")
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    //上のcellとの隙間を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    //横のcellとの隙間を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    //collectionViewのsectionの周りの隙間を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if inputArray.count == 0 {
            return UIEdgeInsets(top: collectionView.frame.height / 2 - 16, left: 16, bottom: 16, right: 16)
        } else {
            return UIEdgeInsets(top: 20.0, left: 16, bottom: 16.0, right: 16)
        }
    }
    //cellのsizeを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if inputArray.count == 0 {
            return CGSize(width: view.frame.width - 32, height: 60)
        } else {
            return CGSize(width: view.frame.width - 32, height: 60)
        }
    }
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
            cell.layer.shadowColor = UIColor.white.cgColor
            cell.isUserInteractionEnabled = false
            cell.inputLabel.text = "お気に入りを保存するとここに表示されます。"
            cell.outputLabel.text = ""
            return cell
        } else {
            //cellの角を丸めて、影をつける
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 2
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 2
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.masksToBounds = false
            cell.isUserInteractionEnabled = true
            cell.inputLabel.text = inputArray[indexPath.row]
            cell.outputLabel.text = outputArray[indexPath.row]
            return cell
        }
    }
}
extension FavoriteViewController: UIGestureRecognizerDelegate {
    
}
extension FavoriteViewController: UINavigationBarDelegate {
    //navigationBarのPositionをステータスバーまで伸ばす
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
