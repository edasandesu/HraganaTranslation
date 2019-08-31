//
//  DetailViewController.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/07.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var inputModalView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputModalView: UIView!
    @IBOutlet weak var outputTextView: UITextView!
    
    var inputText: String?
    var outputText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputModalView.layer.cornerRadius = 10
        inputModalView.layer.masksToBounds = true
        outputModalView.layer.cornerRadius = 10
        outputModalView.layer.masksToBounds = true
        inputTextView.text = inputText
        outputTextView.text = outputText
    }
    
    //modalView以外の場所を触ったら前の画面に戻る
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            if touch.view?.tag == 1 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
