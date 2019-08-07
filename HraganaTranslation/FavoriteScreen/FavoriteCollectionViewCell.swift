//
//  FavoriteCollectionViewCell.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/06.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                let shrink = CABasicAnimation(keyPath: "transform.scale")
                //アニメーションの間隔
                shrink.duration = 0.1
                //1.0 -> 0.95に小さくする
                shrink.fromValue = 1.0
                shrink.toValue = 0.97
                //自動で元に戻るか
                shrink.autoreverses = false
                //繰り返す回数を1回にする
                shrink.repeatCount = 1
                //アニメーションが終了した状態を維持する
                shrink.isRemovedOnCompletion = false
                shrink.fillMode = CAMediaTimingFillMode.forwards
                //アニメーションの追加
                self.layer.add(shrink, forKey: "shrink")
            } else {
                let expansion = CABasicAnimation(keyPath: "transform.scale")
                //アニメーションの間隔
                expansion.duration = 0.2
                //0.95 -> 1.0に大きくする
                expansion.fromValue = 0.97
                expansion.toValue = 1.0
                //自動で元に戻る
                expansion.autoreverses = false
                //繰り返す回数を1回にする
                expansion.repeatCount = 1
                //アニメーションが終了した状態を維持する
                expansion.isRemovedOnCompletion = false
                expansion.fillMode = CAMediaTimingFillMode.forwards
                //アニメーションの追加
                self.layer.add(expansion, forKey: "expansion")
            }
        }
    }
}
