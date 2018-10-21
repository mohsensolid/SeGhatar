//
//  loading.swift
//  SeGhatar
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
import UIKit
class Loading: UIView {
    let circleSize:CGFloat = 20
    let circleGap:CGFloat = 2
    let replicator : CAReplicatorLayer = {
       let rep = CAReplicatorLayer()
        rep.instanceCount = 3
        return rep
    }()
    lazy var circle :CALayer = {
       let circle = CALayer()
        circle.frame.size = CGSize(width: circleSize , height: circleSize)
        circle.cornerRadius = circleSize / 2
        circle.backgroundColor = UIColor.purple.cgColor
        return circle
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    func setupView(){
        layer.addSublayer(replicator)
        replicator.addSublayer(circle)
        replicator.instanceCount = 3
        replicator.instanceTransform = CATransform3DMakeTranslation(circleSize + circleGap, 0, 0)
        replicator.instanceDelay = 0.28
        let turn_key_path = "transform.scale.xy"
        let scaleAnimation = CABasicAnimation(keyPath: turn_key_path)
        let currentScale = replicator.presentation()?.value(forKeyPath: "transform.scale") ?? 0.0
        scaleAnimation.speed = 0.8
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.3
        scaleAnimation.duration  = 0.8
        scaleAnimation.fillMode = .backwards
        scaleAnimation.isRemovedOnCompletion = true
        scaleAnimation.repeatCount = Float.infinity

        circle.add(scaleAnimation, forKey: turn_key_path)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
