//
//  InputOutputViewController.swift
//  HraganaTranslation
//
//  Created by 今枝弘樹 on 2019/08/06.
//  Copyright © 2019 Hiroki Imaeda. All rights reserved.
//

import UIKit

class InputOutputViewController: UIViewController {
    
    @IBOutlet weak var japaneseView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var japaneseInputView: UIView!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var hiraganaView: UIView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var hiraganaOutputView: UIView!
    
    let gooAPI = "＊＊＊＊＊＊＊"//APIキーを入力
    let gooRequestURL = "https://labs.goo.ne.jp/api/hiragana"
    let outputType = "hiragana"
    
    var inputArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputTextView.delegate = self
        viewCreate()
        buttonGenerate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputTextView.text = "ここに日本語を入力してください。"
        inputTextView.textColor = UIColor.lightGray
        inputTextView.delegate = self
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        writeBorderLine()
    }
    //画面をタッチした時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if inputTextView.isFirstResponder {
            gooHiraganaRequest(inputText: self.inputTextView.text!)
            inputTextView.resignFirstResponder()
        }
    }
    
    func viewCreate() {
        japaneseView.backgroundColor = UIColor.white
        japaneseView.layer.cornerRadius = 8
        japaneseView.layer.shadowOpacity = 0.2
        japaneseView.layer.shadowRadius = 8
        japaneseView.layer.shadowColor = UIColor.black.cgColor
        japaneseView.layer.shadowOffset = CGSize(width: 1, height: 1)
        japaneseView.layer.masksToBounds = false
        japaneseInputView.layer.cornerRadius = 8
        japaneseInputView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        hiraganaView.backgroundColor = UIColor.white
        hiraganaView.layer.cornerRadius = 8
        hiraganaView.layer.shadowOpacity = 0.2
        hiraganaView.layer.shadowRadius = 8
        hiraganaView.layer.shadowColor = UIColor.black.cgColor
        hiraganaView.layer.shadowOffset = CGSize(width: 1, height: 1)
        hiraganaView.layer.masksToBounds = false
        hiraganaOutputView.layer.cornerRadius = 8
        hiraganaOutputView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    func writeBorderLine() {
        let japaneseBorderLine = CALayer()
        japaneseBorderLine.frame = CGRect(x: 0, y: 0, width: japaneseView.frame.size.width, height: 0.5)
        japaneseBorderLine.backgroundColor = UIColor.lightGray.cgColor
        japaneseInputView.layer.addSublayer(japaneseBorderLine)
        let hiraganaBorderLine = CALayer()
        hiraganaBorderLine.frame = CGRect(x: 0, y: 0, width: hiraganaView.frame.size.width, height: 0.5)
        hiraganaBorderLine.backgroundColor = UIColor.lightGray.cgColor
        hiraganaOutputView.layer.addSublayer(hiraganaBorderLine)
    }
    func buttonGenerate() {
        inputButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        inputButton.backgroundColor = UIColor.orange
        inputButton.layer.borderColor = UIColor.orange.cgColor
        inputButton.layer.cornerRadius = 16
        inputButton.layer.shadowOpacity = 0.5
        inputButton.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    //日本語をルビに直す
    func gooHiraganaRequest(inputText: String) {
        //URLRequestを設定
        var request = URLRequest(url: URL(string: self.gooRequestURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //データをrequestに渡す
        let postData = PostData(app_id: self.gooAPI, request_id: "record003", sentence: inputText, output_type: self.outputType)
        guard let uploadData = try? JSONEncoder().encode(postData) else {
            print("json生成に失敗しました")
            return
        }
        request.httpBody = uploadData
        //responseを受け取る
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            //クライアントサイドのエラーが出た場合
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                //dataとresponseが取得できなかった時の処理
                print("no data or no response")
                return
            }
            if response.statusCode == 200 {
                //レスポンスが成功した時
                print(data)
            } else {
                //レスポンスのステータスコードが200でない場合はサーバサイドのエラー
                print("serverError statusCode: \(response.statusCode)")
            }
            guard let jsonData = try? JSONDecoder().decode(Rubi.self, from: data) else {return}
            DispatchQueue.main.async {
                self.outputTextView.text = jsonData.converted
            }
        }
        task.resume()
    }
    @IBAction func didTouchDownButton() {
        //ボタンを縮こませる
        UIView.animate(withDuration: 0.2) {
            self.inputButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @IBAction func didTouchDragExitButton() {
        //縮こまったボタンを元のサイズに戻す
        UIView.animate(withDuration: 0.2) {
            self.inputButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    //buttonが押された時の処理
    @IBAction func inputButton(_ sender: Any) {
        //ボタンが押されたらバウンドさせる処理
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 8,
                       options: .curveEaseOut,
                       animations: { () -> Void in
                        
                        self.inputButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        if inputTextView.text.isEmpty {
            //文字列がない時の処理
            let alert = UIAlertController(title: "文字がないとひらがなにできません！", message: "", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {
                //ボタンが押された時の処理を書く(クロージャ実装)
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
        } else {
            gooHiraganaRequest(inputText: self.inputTextView.text!)
            //文字列が入力されていた時の処理
            inputTextView.resignFirstResponder()
        }
    }
    @IBAction func japaneseDeleteButton(_ sender: Any) {
        //textFieldの中身をクリア
        inputTextView.text = ""
        //textViewの中身をクリア
        outputTextView.text = ""
        //placeholderを表示する
        if inputTextView.text.isEmpty {
            inputTextView.text = "ここに日本語を入力してください。"
            inputTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if self.inputTextView.text!.isEmpty, self.outputTextView.text.isEmpty {
            //inputTextFieldに文字列がない時の処理
            let alert = UIAlertController(title: "文字がないと保存できません！", message: "", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {
                //ボタンが押された時の処理を書く(クロージャ実装)
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
        } else {
            if UserDefaults.standard.object(forKey: "inputArray") != nil {
                self.inputArray = UserDefaults.standard.array(forKey: "inputArray") as! [String]
                self.outputArray = UserDefaults.standard.array(forKey: "outputArray") as! [String]
                //お気に入りに保存する
                self.inputArray.append(self.inputTextView.text!)
                self.outputArray.append(self.outputTextView.text!)
                UserDefaults.standard.set(self.inputArray, forKey: "inputArray")
                UserDefaults.standard.set(self.outputArray, forKey: "outputArray")
            } else {
                //お気に入りに保存する
                self.inputArray.append(self.inputTextView.text!)
                self.outputArray.append(self.outputTextView.text!)
                UserDefaults.standard.set(self.inputArray, forKey: "inputArray")
                UserDefaults.standard.set(self.outputArray, forKey: "outputArray")
            }
            let alert = UIAlertController(title: "結果を保存しました！", message: "", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {
                //ボタンが押された時の処理を書く(クロージャ実装)
                (action: UIAlertAction!) -> Void in
                
            })
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
}
extension InputOutputViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if inputTextView.textColor == UIColor.lightGray {
            inputTextView.text = nil
            inputTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text.isEmpty {
            inputTextView.text = "ここに日本語を入力してください。"
            inputTextView.textColor = UIColor.lightGray
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            gooHiraganaRequest(inputText: self.inputTextView.text!)
            inputTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
struct PostData: Codable {
    var app_id: String
    var request_id: String
    var sentence: String
    var output_type: String
}
struct Rubi:Codable {
    var converted: String
    var output_type: String
    var request_id: String
}
