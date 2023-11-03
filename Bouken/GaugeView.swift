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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gaugeViewInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.gaugeViewInit()
    }
    
    private func gaugeViewInit() {
        self.addSubview(gaugeView)
        self.gaugeView.backgroundColor = self.gageColor ?? defalutColor
        self.gaugeView.frame = self.bounds
    }
    
    func loadGauge(value: Int, maxValue: Int) {
        let ration: Float = Float(value) / Float(maxValue)
        let width = self.bounds.width * CGFloat(ration)
        self.gaugeView.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.height)
    }
}
