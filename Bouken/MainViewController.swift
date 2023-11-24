//
//  MainViewController.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var gaugeView: GaugeView!
    @IBOutlet weak var monsterLabel: UILabel!
    @IBOutlet weak var displayView: DisplayView!
    @IBOutlet weak var atttackButton: Button!
    @IBOutlet weak var escapeButton: Button!
    
    let audio = Audio()
    
    var model = Main(playerName: "冒険者")
    var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atttackButton.addTarget(self, action: #selector(attackButtonTapped(_:)), for: .touchUpInside)
        self.escapeButton.addTarget(self, action: #selector(escapeButtonTapped(_:)), for: .touchUpInside)
        
        self.model.view = self
        self.model.loadEvent()
        
        self.gaugeView.delegete = self
        self.gaugeView.load()
        
        self.displayView.textButton.delegate = self
        self.displayView.delegete = self.gaugeView
        
        self.atttackButton.isEnabled = false
        self.escapeButton.isEnabled = false
        
        self.loadPlayer()
//        self.loadGameView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gaugeView.loadGauge(animate: false)
    }
    
    @objc private func attackButtonTapped(_ sender: UIButton) {
        self.audio.buttonTapped()
        self.model.playerAttack()
    }

    @objc private func escapeButtonTapped(_ sender: UIButton) {
        self.audio.buttonTapped()
        self.model.playerEscape()
    }
    
    private func loadMonster(){
        
        guard let monster = self.model.monster else{
            self.monsterLabel.text = "-"
            self.displayView.monsterImageView.alpha = 0
            return
        }
        
        let name = monster.name
        self.monsterLabel.text = name
        
        let image = monster.image
        self.displayView.monsterImageView.image = UIImage(named: image)
    }
    
    private func loadPlayer(){
        let player = self.model.player
        let name = player.name
        let lv = player.lv
        let playerText = "\(name) Lv. \(lv)"
        self.playerLabel.text = playerText
    }
}

extension MainViewController: ViewProtocol {
    func loadGameView() {

        self.loadMonster()
        
        let gameText = self.model.getGameText()
        let text = gameText.text
        self.displayView.textButton.setTitle(text, for: .normal)
        
        let event = gameText.event
        switch event{
        case .system(.last):
            self.dismiss(animated: true)
            break
        case .animate(.monster(.respawn)):
            self.displayView.monsterRespawnAnimate()
            self.atttackButton.isEnabled = true
            self.escapeButton.isEnabled = true
            break
        case .animate(.monster(.death)):
            self.atttackButton.isEnabled = false
            self.escapeButton.isEnabled = false
            self.displayView.monsterDeathAnimate()
            break
        case .animate(.monster(.attack)):
            self.atttackButton.isEnabled = false
            self.escapeButton.isEnabled = false
            self.displayView.monsterAttackAnimate()
            break
        case .animate(.player(.levelUP)):
            self.audio.playerLevelUP()
            self.loadPlayer()
            break
        case .animate(.player(.escape)):
            self.displayView.playerEscapeAnimate()
            break
        case .animate(.player(.death)):
            self.displayView.playerDeathAnimate()
            break
        default:
            break
        }
    }
}

extension MainViewController: TextButtonProtocol {
    func textButtonTapped() {
        self.model.loadEvent()
    }
}

extension MainViewController: GaugeViewProtocol{
    func loadValue() -> (Int, Int) {
        return (self.model.player.hp, self.model.player.maxHP)
    }
}
