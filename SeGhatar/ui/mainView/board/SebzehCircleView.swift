//
//  SebzehCircleView.swift
//  SeGhatar
//
//  Created by MAC on 7/24/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
protocol SebzehInterface {
    func cellTappedAt(row:Int,col:Int,layer:Int)
    func isYourTurn()->Bool
}
class SebzehCircleView: UIView {
    let circleSize:CGFloat = 20
    let activeCircleSize:CGFloat = 30
    let borderSize:CGFloat = 1
    var row:Int?
    var col:Int?
    var boardLayer:Int?
    var delegate:SebzehInterface?
    var player:Player = Player.None
    var isFill = false
    
    lazy var circle :UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = CGFloat(circleSize / 2)
        circle.clipsToBounds = true
        circle.layer.borderWidth = borderSize
        circle.layer.borderColor = UIColor.circleBorderColor.cgColor
        circle.backgroundColor = .white
        return circle
    }()
    var activeCircle :UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = CGFloat(30 / 2)
        circle.isUserInteractionEnabled = true
        circle.backgroundColor = UIColor.red
        circle.clipsToBounds = true
        return circle
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(row:Int,col:Int,boardLayer:Int,delegate:SebzehInterface){
        self.init(frame: .zero)
        self.row = row
        self.col = col
        self.boardLayer = boardLayer
        self.delegate = delegate
        setupView()
    }
    
    private func setupView(){
        addSubview(activeCircle)
        NSLayoutConstraint.activate([activeCircle.widthAnchor.constraint(equalToConstant: activeCircleSize),activeCircle.heightAnchor.constraint(equalToConstant: activeCircleSize),activeCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),activeCircle.centerYAnchor.constraint(equalTo:self.centerYAnchor)])
        addSubview(circle)
        NSLayoutConstraint.activate([circle.widthAnchor.constraint(equalToConstant: circleSize),circle.heightAnchor.constraint(equalToConstant: circleSize),circle.centerXAnchor.constraint(equalTo: self.centerXAnchor),circle.centerYAnchor.constraint(equalTo:self.centerYAnchor)])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        if player == Player.Red{
            self.activeCircle.backgroundColor = UIColor.redColor
        }else if player == Player.Blue {
            self.activeCircle.backgroundColor = UIColor.blueColor
        }else {
            self.activeCircle.backgroundColor = UIColor(white: 0.0, alpha: 0)
        }
    }
    
    @objc private func cellTapped(){
        if self.delegate!.isYourTurn() && !self.isFill{
            self.delegate?.cellTappedAt(row: self.row!, col: self.col!, layer: self.boardLayer!)
            self.isFill = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SebzehCircleView:SebzehDelegate{
    func clear() {
        self.isFill = false
        self.player = Player.None
        activeCircle.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    func changeItemAt(player: Player) {
        self.activeCircle.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        self.circle.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.2, animations: {
            if player == Player.Red{
                self.activeCircle.backgroundColor = .redColor
            }else{
                self.activeCircle.backgroundColor = .blueColor
            }
            self.activeCircle.transform = CGAffineTransform.identity
            self.circle.transform = CGAffineTransform.identity

        })
    }
}
