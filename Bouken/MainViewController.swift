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
    
    var model = Model(playerName: "冒険者")
    var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atttackButton.addTarget(self, action: #selector(attackButtonTapped(_:)), for: .touchUpInside)
        self.escapeButton.addTarget(self, action: #selector(escapeButtonTapped(_:)), for: .touchUpInside)
        
        self.displayView.textButton.delegate = self
        self.model.view = self
        self.gameView.viewController = self
        self.gameView.model = self.model
        
        self.viewLoad()
    }
    
    override func viewWillLayoutSubviews() {
        let player = self.model.getPlayer()
        self.gaugeView.loadGauge(value: player.getHP(), maxValue: player.getMaxHP(), animate: false)
    }
    
    @objc private func attackButtonTapped(_ sender: UIButton) {
        self.model.playerAttack()
    }

    @objc private func escapeButtonTapped(_ sender: UIButton) {
        self.model.playerEscape()
    }
    
    private func eventAnimate(){
        let bool = self.model.getAnimateFlag()
        if !bool {
            return
        }
        let animateEvent = self.model.getAnimateEventType()
        switch animateEvent{
        case .animate(.no):
            break
        case .animate(.monster(.respawn)):
            self.displayView.respawnAnimate()
            break
        case .animate(.monster(.attack)):
            self.displayView.monsterAttckAnimate()
            break
        case .animate(.monster(.death)):
            self.displayView.monsterDeathAnimate()
            break
        case .animate(.player(.attack)):
            self.displayView.playerAttackAnimate()
            break
        case .animate(.player(.escape)):
            self.displayView.escapeAnimate()
            break
        case .animate(.player(.death)):
            self.displayView.playerDeathAnimate()
            break
        case .system(.last):
            self.dismiss(animated: true)
            break
        default:
            break
        }
    }
    
    private func loadMonster(){
        let monster = self.model.getMonster()
        let monsterName = monster.getName()
        self.monsterLabel.text = monsterName
        
        let image = self.model.getMonsterImage()
        self.displayView.monsterImageView.image = UIImage(named: image)
    }
}

extension MainViewController: ViewProtocol {
    func viewLoad() {
        let player = self.model.getPlayer()
        let name = player.getName()
        let lv = player.getLv()
        let playerText = "\(name) Lv. \(lv)"
        self.playerLabel.text = playerText
        
        self.gaugeView.loadGauge(value: player.getHP(), maxValue: player.getMaxHP())
        
        self.loadMonster()
        
        let text = self.model.getText()
        self.displayView.textButton.setTitle(text, for: .normal)
        
        self.eventAnimate()
    }
}

extension MainViewController: TextButtonProtocol {
    func textButtonTapped() {
        self.model.textLoad()
    }
}
