//
//  ViewController.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var gaugeView: GaugeView!
    @IBOutlet weak var monsterLabel: UILabel!
    @IBOutlet weak var displayView: DisplayView!
    @IBOutlet weak var startButton: Button!
    @IBOutlet weak var editButton: Button!
    
    let audio = Audio()
    
    let playerName = "冒険者"
    let playerLv = "最高 Lv."
    let text = "▷逃げる▷攻撃する,をダウンロードしていただき,ありがとう!,こんにちは！,スライムだよ！,「攻撃」か「逃げる」の,どちらか選ぶだけの,お手軽冒険！,特殊能力を持った,モンスターもいるから,気を付けてね！,初見殺しもたくさん！"
    var textListIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gaugeView.delegete = self
        self.displayView.textButton.delegate = self
        
        self.playerLabel.text = "\(playerName) \(playerLv) \(self.getPlayerMaxLv())"
        self.monsterLabel.text = "-"
        self.displayView.monsterImageView.image = UIImage(named: "pipo-enemy009")
        self.displayView.monsterImageView.alpha = 1
        
//        self.startButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startButtonTapped(_:))))
        self.startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        
        // よく理解していない
        if #available(iOS 15.0, *) {
            self.editButton.configuration = nil
        }
        self.editButton.titleLabel?.font = UIFont(name: "JF-Dot-k12x10", size: 20)
        self.editButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.editButton.titleLabel?.numberOfLines = 0
        self.editButton.setTitle("設定\n開発中!", for: .normal)
        
        self.textButtonTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textListIndex = 0
        self.textButtonTapped()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gaugeView.loadGauge(animate: false)
        self.displayView.monsterImageView.alpha = 1
        self.playerLabel.text = "\(playerName) \(playerLv) \(self.getPlayerMaxLv())"
    }
    
    func getPlayerMaxLv() -> Int{
        var maxLv = UserDefaults.standard.integer(forKey: "maxLv")
        if maxLv == 0{
            maxLv = 1
        }
        return maxLv
    }
    
    @objc func _startButtonTapped(_ sender: UITapGestureRecognizer) {
        self.audio.buttonTapped()
        self.performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    @objc func startButtonTapped(_ sender: UIButton){
        self.audio.buttonTapped()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "main")
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: false)
    }

    @IBAction func __startButtonTapped(_ sender: Any) {
        self.audio.buttonTapped()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "main")
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
    }
    
}

extension ViewController: TextButtonProtocol {
    func textButtonTapped() {
        let textList = text.components(separatedBy: ",")
//        self.displayView.textButton.titleLabel?.text = textList[self.textListIndex]
        self.displayView.textButton.setTitle(textList[self.textListIndex], for: .normal)
        if textList.count - 1 == self.textListIndex{
            self.textListIndex = 0
        }else{
            self.textListIndex += 1
        }
    }
}

extension ViewController: GaugeViewProtocol{
    func loadValue() -> (Int, Int) {
        return (100, 100)
    }
}
