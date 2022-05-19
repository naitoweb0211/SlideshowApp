//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 内藤有紀 on 2022/05/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageViewScale: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    // 配列に指定するindex番号を宣言
    var nowIndex:Int = 0

    // スライドショーに使用するタイマーを宣言
    var timer: Timer!
    
    var imageArray:[UIImage] = [
        UIImage(named: "slider_1")!,
        UIImage(named: "slider_2")!,
        UIImage(named: "slider_3")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (timer != nil){
            timer.invalidate()
        }
        backButton.isEnabled = true
        nextButton.isEnabled = true
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        resultViewController.imageArray[0] = imageArray[nowIndex]
    }

    @IBAction func imageViewScale(_ sender: Any) {
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        // indexを増やして表示する画像を切り替える
            nowIndex -= 1

        // indexが表示予定の画像の数と同じ場合
        if (nowIndex == -1) {
            // indexを一番最初の数字に戻す
            nowIndex = imageArray.count - 1
        }
        // indexの画像をstoryboardの画像にセットする
        imageView.image = imageArray[nowIndex]
    }
    
    @IBAction func playButton(_ sender: Any) {
        backButton.isEnabled = false
        nextButton.isEnabled = false
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // 再生時の処理を実装

            // タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)

            // ボタンの名前を停止に変える
            playButton.setTitle("停止", for: .normal)

        } else {
            backButton.isEnabled = true
            nextButton.isEnabled = true
            // 停止時の処理を実装
            // タイマーを停止する
            timer.invalidate()

            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil

            // ボタンの名前を再生に直しておく
            playButton.setTitle("再生", for: .normal)
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        changeImage()
    }
    
    @objc func changeImage() {
        // indexを増やして表示する画像を切り替える
        nowIndex += 1

        // indexが表示予定の画像の数と同じ場合
        if (nowIndex == imageArray.count) {
            // indexを一番最初の数字に戻す
            nowIndex = 0
        }
        // indexの画像をstoryboardの画像にセットする
        imageView.image = imageArray[nowIndex]
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

