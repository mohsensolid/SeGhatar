//
//  BoardLayerController.swift
//  SeGhatar
//
//  Created by MAC on 7/24/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
protocol boardInterface {
    func layerat(layerNum:Int)
}
class BoardLayerController: UIView {
   
    let boardItemSize : CGFloat = 30
    let borderSize:CGFloat = 1
    var delegate : boardInterface?
    var boardLayer:Int?
    var sebzehDelegate:[String:SebzehDelegate]=[:]
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews as[UIView]{
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled &&
                subview.point(inside: convert(point, to: subview), with: event){
                return true
            }
        }
        return false
    }
    lazy var border :UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.layer.borderWidth = borderSize
        border.layer.borderColor = UIColor.borderColor.cgColor
        return border
    }()
    lazy var topLeft :SebzehCircleView = {
        let circle = SebzehCircleView(row: 0, col: 0, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        sebzehDelegate["00"]=circle
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
        
    }()
    lazy var topCenter :SebzehCircleView = {
        let circle = SebzehCircleView(row: 0, col: 1, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        sebzehDelegate["01"]=circle
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
        
    }()
   
    lazy var topRight :SebzehCircleView = {
        let circle = SebzehCircleView(row: 0, col: 2, boardLayer: self.boardLayer!, delegate:delegate as! SebzehInterface)
        sebzehDelegate["02"]=circle
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.isUserInteractionEnabled = true
        return circle
        
    }()
    lazy var midLeft :SebzehCircleView = {
        let circle = SebzehCircleView(row: 1, col: 0, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        sebzehDelegate["10"]=circle
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
        
    }()
    lazy var midRight :SebzehCircleView = {
        let circle = SebzehCircleView(row: 1, col: 2, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        circle.translatesAutoresizingMaskIntoConstraints = false
        sebzehDelegate["12"]=circle
        return circle
        
    }()
    lazy var bottomLeft :SebzehCircleView = {
        let circle = SebzehCircleView(row: 2, col: 0, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        circle.translatesAutoresizingMaskIntoConstraints = false
        sebzehDelegate["20"]=circle
        return circle
        
    }()
    lazy var bottomCenter :SebzehCircleView = {
        let circle = SebzehCircleView(row: 2, col: 1, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        circle.translatesAutoresizingMaskIntoConstraints = false
        sebzehDelegate["21"]=circle
        return circle
        
    }()
    lazy var bottomRight :SebzehCircleView = {
        let circle = SebzehCircleView(row: 2, col: 2, boardLayer: self.boardLayer!, delegate: delegate as! SebzehInterface)
        circle.translatesAutoresizingMaskIntoConstraints = false
        sebzehDelegate["22"]=circle
        return circle
        
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    convenience init(delegate:boardInterface,layer:Int){
        self.init(frame:.zero)
        self.delegate = delegate
        self.boardLayer = layer
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        let borderCenter :CGFloat = 0;

        addSubview(border)
        NSLayoutConstraint.activate([border.topAnchor.constraint(equalTo: topAnchor, constant:borderCenter),border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: borderCenter),border.rightAnchor.constraint(equalTo: rightAnchor, constant: borderCenter),border.leftAnchor.constraint(equalTo: leftAnchor, constant: borderCenter)])
        
        addSubview(topLeft)
        NSLayoutConstraint.activate([topLeft.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -CGFloat(boardItemSize/2)),topLeft.topAnchor.constraint(equalTo: self.topAnchor, constant: -CGFloat(boardItemSize/2)),topLeft.widthAnchor.constraint(equalToConstant: boardItemSize),topLeft.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(topCenter)
        NSLayoutConstraint.activate([topCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor),topCenter.topAnchor.constraint(equalTo: self.topAnchor, constant: -CGFloat(boardItemSize/2)),topCenter.widthAnchor.constraint(equalToConstant: boardItemSize),topCenter.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(topRight)
        NSLayoutConstraint.activate([topRight.rightAnchor.constraint(equalTo: self.rightAnchor,constant: CGFloat(boardItemSize/2)),topRight.topAnchor.constraint(equalTo: self.topAnchor, constant: -CGFloat(boardItemSize/2)),topRight.widthAnchor.constraint(equalToConstant: boardItemSize),topRight.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(midLeft)
        NSLayoutConstraint.activate([midLeft.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -CGFloat(boardItemSize/2)),midLeft.centerYAnchor.constraint(equalTo: self.centerYAnchor),midLeft.widthAnchor.constraint(equalToConstant: boardItemSize),midLeft.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(midRight)
        NSLayoutConstraint.activate([midRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(boardItemSize/2)),midRight.centerYAnchor.constraint(equalTo: self.centerYAnchor),midRight.widthAnchor.constraint(equalToConstant: boardItemSize),midRight.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(bottomLeft)
        NSLayoutConstraint.activate([bottomLeft.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -CGFloat(boardItemSize/2)),bottomLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(boardItemSize/2)),bottomLeft.widthAnchor.constraint(equalToConstant: boardItemSize),bottomLeft.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(bottomCenter)
        NSLayoutConstraint.activate([bottomCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor),bottomCenter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(boardItemSize/2)),bottomCenter.widthAnchor.constraint(equalToConstant: boardItemSize),bottomCenter.heightAnchor.constraint(equalToConstant: boardItemSize)])
        
        addSubview(bottomRight)
        NSLayoutConstraint.activate([bottomRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(boardItemSize/2)),bottomRight.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(boardItemSize/2)),bottomRight.widthAnchor.constraint(equalToConstant: boardItemSize),bottomRight.heightAnchor.constraint(equalToConstant: boardItemSize)])
    }
    func clear(){
        for item in sebzehDelegate{
            item.value.clear()
        }
    }
    public func itemSelectedAt(row:Int,col:Int,player:Player){
        
            self.sebzehDelegate[String(row)+String(col)]?.changeItemAt(player: player)
    }
}
