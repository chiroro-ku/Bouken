//
//  ViewController.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    let audio = Audio()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        self.audio.buttonTapped()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "main")
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
    }
    
}

