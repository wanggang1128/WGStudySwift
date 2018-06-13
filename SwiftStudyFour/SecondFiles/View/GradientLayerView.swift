//
//  GradientLayerView.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/13.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class GradientLayerView: UIView, CAAnimationDelegate {

    private let gradientLayer = CAGradientLayer()
    private let masterLayer = CALayer()
    var progress: CGFloat = 0.0 {
        didSet {
            changeMaskFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBaseView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBaseView() {
        let backLayer = CALayer()
        backLayer.backgroundColor = UIColor.yellow.cgColor
        backLayer.frame = bounds
        backLayer.cornerRadius = bounds.height * 0.5
        backLayer.borderColor = UIColor.white.cgColor
        backLayer.borderWidth = 1
        layer.addSublayer(backLayer)
        
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.height * 0.5
        gradientLayer.borderColor = UIColor.white.cgColor
        gradientLayer.borderWidth = 1
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.cyan.cgColor]
        gradientLayer.locations = [0.2, 0.4, 0.6, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
        
        performAnimation()
    }
    
    func changeMaskFrame() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: progress * bounds.width, height: bounds.height)
    }
    
    private func performAnimation() {
        var colors = gradientLayer.colors
        let color = colors?.popLast() as! CGColor
        colors?.insert(color, at: 0)
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = colors
        animation.duration = 0.08
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        gradientLayer.add(animation, forKey: "gradient")
        
        gradientLayer.colors = colors
    }
    //动画停止后继续动画
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performAnimation()
    }
}
