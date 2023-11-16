//
//  GaugeView.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/03.
//

import UIKit

@IBDesignable
final class GaugeView: UIView {
    
    @IBInspectable var gageColor: UIColor?
    
    private var defalutColor = UIColor.green
    private var gaugeView: UIView = UIView()
    private var valueLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gaugeViewInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.gaugeViewInit()
    }
    
    private func gaugeViewInit() {
        self.addSubview(self.gaugeView)
        self.gaugeView.backgroundColor = self.gageColor ?? defalutColor
        self.gaugeView.frame = self.bounds
        
        self.addSubview(self.valueLabel)
        self.valueLabel.font = UIFont(name: "JF-Dot-k12x10", size: 20)
    }
    
    func loadGauge(value: Int, maxValue: Int, animate: Bool = true) {
        let ration: Float = Float(value) / Float(maxValue)
        let width = self.bounds.width * CGFloat(ration)
        
        if animate {
            UIView.animate(withDuration: 1.0, animations: {
                self.gaugeView.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.height)
            })
        }else{
            self.gaugeView.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.height)
        }
        
        let valueText = "\(value) / \(maxValue)"
        self.valueLabel.text = valueText
        self.valueLabel.frame = CGRect(x: 10, y: 0, width: self.frame.width, height: self.frame.height)
    }
}
