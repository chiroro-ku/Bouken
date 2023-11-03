//
//  MainViewController.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var gaugeView: GaugeView!
    @IBOutlet weak var displayView: DisplayView!
    @IBOutlet weak var atttackButton: Button!
    @IBOutlet weak var escapeButton: Button!
    
    var model = Model(playerName: "冒険者")
    var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atttackButton.addTarget(self, action: #selector(attackButtonTapped(_:)), for: .touchUpInside)
        self.escapeButton.addTarget(self, action: #selector(escapeButtonTapped(_:)), for: .touchUpInside)
        
        self.displayView.textButton.delegate = self
        
        self.model.view = self
        
        self.viewLoad()
    }
    
    @objc private func attackButtonTapped(_ sender: UIButton) {
        self.model.playerAttack()
    }

    @objc private func escapeButtonTapped(_ sender: UIButton) {
        self.model.playerEscape()
    }
    
    func loadGaugeView(){
        let player = self.model.getPlayer()
        self.gaugeView.loadGauge(value: player.getHP(), maxValue: player.getMaxHP())
    }
}

extension MainViewController: ViewProtocol {
    func viewLoad() {
        guard let text = self.model.getText() else {
            return
        }
        self.displayView.textButton.setTitle(text, for: .normal)
        let name = self.model.getMonsterImage()
        self.displayView.monsterImageView.image = UIImage(named: name)
        
        self.loadGaugeView()
    }
}

extension MainViewController: TextButtonProtocol {
    func nextText() -> String? {
        let name = self.model.getMonsterImage()
        self.displayView.monsterImageView.image = UIImage(named: name)
        
        self.loadGaugeView()
        
        return self.model.getText()
    }
}
