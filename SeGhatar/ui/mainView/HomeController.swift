//
//  ViewController.swift
//  SeGhatar
//
//  Created by MAC on 7/24/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeController: UIViewController,UIGestureRecognizerDelegate {
    
    let scoreCircleSize:CGFloat = 40
    let borderSize:CGFloat = 1
    let boardMargin:CGFloat = 24
    let loadingSize:CGFloat = 55
    var presenter:HomePresenterContract?
    lazy var redScore : UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.redColor
        text.clipsToBounds = true
        text.layer.borderWidth = 1
        text.text = "0"
        text.font = UIFont(name: fonts.iranSans, size: fonts.veryLarge)
        text.textColor = .white
        text.textAlignment = .center
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = (self.scoreCircleSize / 2)
        return text
    }()
    lazy var blueScore:UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.blueColor
        text.clipsToBounds = true
        text.layer.borderWidth = 1
        text.text = "0"
        text.font = UIFont(name: fonts.iranSans, size: fonts.veryLarge)
        text.textColor = .white
        text.textAlignment = .center
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = (self.scoreCircleSize / 2)
        return text
    }()
    lazy var options:gameOptions = {
        let option = gameOptions(delegate: self)
        option.translatesAutoresizingMaskIntoConstraints = false
        option.isUserInteractionEnabled = true
        return option
    }()
    lazy var firstLayer : BoardLayerController = {
        let board = BoardLayerController(delegate: self, layer: 3)
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    lazy var secondLayer : BoardLayerController = {
        let board = BoardLayerController(delegate: self, layer: 2)
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    lazy var thirdLayer : BoardLayerController = {
        let board = BoardLayerController(delegate: self, layer: 1)
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    let chatHolder : chatController = {
        let chat = chatController()
        chat.translatesAutoresizingMaskIntoConstraints = false
        return chat
    }()
    let loading : NVActivityIndicatorView = {
        let loading = NVActivityIndicatorView(frame: .zero, type: NVActivityIndicatorType.ballPulse, color: UIColor.purple, padding: CGFloat(0))
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()
    let findOpponent : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "در حال جستجو حریف"
        label.isHidden = true
        label.font = UIFont(name: fonts.iranSans, size: fonts.large)
        return label
    }()
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: options))! {
            return false
        }
        return true
    }
    let leftLine : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    let topLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    let rightLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    let bottomLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    let saveArea : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(delegate: self)
        setupView()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.dispose()
    }
    @objc func dissMissKeyBoard(){
        view.endEditing(true)
    }
    
    func setupView(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        let width = view.frame.width;
        let boardSize = CGFloat(-boardMargin + width - boardMargin)
        let boardGap:CGFloat = view.frame.width / 5
        view.backgroundColor = UIColor.appBackground
        
        
        view.addSubview(leftLine)
        view.addSubview(topLine)
        view.addSubview(rightLine)
        view.addSubview(bottomLine)
        view.addSubview(firstLayer)
        view.addSubview(secondLayer)
        view.addSubview(thirdLayer)
        view.addSubview(redScore)
        view.addSubview(blueScore)
        view.addSubview(chatHolder)
        view.addSubview(loading)
        view.addSubview(findOpponent)
        view.addSubview(saveArea)
        view.addSubview(options)
     
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([firstLayer.widthAnchor.constraint(equalToConstant:     boardSize),firstLayer.heightAnchor.constraint(equalToConstant:boardSize),firstLayer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: boardMargin),firstLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -boardMargin),firstLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: boardMargin)])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([firstLayer.widthAnchor.constraint(equalToConstant:     boardSize),firstLayer.heightAnchor.constraint(equalToConstant:boardSize),firstLayer.topAnchor.constraint(equalTo: view.topAnchor, constant: boardMargin),firstLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -boardMargin),firstLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: boardMargin)])
        }
        
        NSLayoutConstraint.activate([secondLayer.widthAnchor.constraint(equalToConstant: boardSize - boardGap),secondLayer.heightAnchor.constraint(equalToConstant: boardSize - boardGap),secondLayer.centerXAnchor.constraint(equalTo: firstLayer.centerXAnchor),secondLayer.centerYAnchor.constraint(equalTo: firstLayer.centerYAnchor)])
        
        NSLayoutConstraint.activate([thirdLayer.widthAnchor.constraint(equalToConstant: boardSize - 2*boardGap),thirdLayer.heightAnchor.constraint(equalToConstant: boardSize - 2*boardGap),thirdLayer.centerYAnchor.constraint(equalTo: secondLayer.centerYAnchor),thirdLayer.centerXAnchor.constraint(equalTo: secondLayer.centerXAnchor)])
        
        NSLayoutConstraint.activate([redScore.centerYAnchor.constraint(equalTo: firstLayer.centerYAnchor),redScore.centerXAnchor.constraint(equalTo:firstLayer.centerXAnchor,constant:-CGFloat(20)),redScore.widthAnchor.constraint(equalToConstant: scoreCircleSize),redScore.heightAnchor.constraint(equalToConstant: scoreCircleSize)])
        
        NSLayoutConstraint.activate([blueScore.centerYAnchor.constraint(equalTo: firstLayer.centerYAnchor),blueScore.centerXAnchor.constraint(equalTo: firstLayer.centerXAnchor,constant:CGFloat(10)),blueScore.widthAnchor.constraint(equalToConstant: scoreCircleSize),blueScore.heightAnchor.constraint(equalToConstant: scoreCircleSize)])
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([options.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),options.rightAnchor.constraint(equalTo: self.view.rightAnchor),options.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([options.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),options.rightAnchor.constraint(equalTo: self.view.rightAnchor),options.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
        }
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([chatHolder.topAnchor.constraint(equalTo: firstLayer.bottomAnchor, constant: margin.veryLarge),chatHolder.rightAnchor.constraint(equalTo: self.view.rightAnchor),chatHolder.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:0),chatHolder.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65)])
        } else {
            // Fallback on earlier versions
             NSLayoutConstraint.activate([chatHolder.topAnchor.constraint(equalTo: firstLayer.bottomAnchor, constant: margin.veryLarge),chatHolder.rightAnchor.constraint(equalTo: self.view.rightAnchor),chatHolder.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:0),chatHolder.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65)])
        }
        NSLayoutConstraint.activate([loading.centerXAnchor.constraint(equalTo: chatHolder.centerXAnchor),loading.centerYAnchor.constraint(equalTo: chatHolder.centerYAnchor),loading.heightAnchor.constraint(equalToConstant: loadingSize),loading.widthAnchor.constraint(equalToConstant: loadingSize)])
        NSLayoutConstraint.activate([findOpponent.topAnchor.constraint(equalTo: loading.bottomAnchor, constant: 4),findOpponent.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
        
        NSLayoutConstraint.activate([leftLine.leftAnchor.constraint(equalTo: firstLayer.leftAnchor),leftLine.centerYAnchor.constraint(equalTo: firstLayer.centerYAnchor),leftLine.rightAnchor.constraint(equalTo: thirdLayer.leftAnchor),leftLine.heightAnchor.constraint(equalToConstant: 1)])
        
        NSLayoutConstraint.activate([topLine.centerXAnchor.constraint(equalTo: firstLayer.centerXAnchor),topLine.topAnchor.constraint(equalTo: firstLayer.topAnchor),topLine.bottomAnchor.constraint(equalTo: thirdLayer.topAnchor),topLine.widthAnchor.constraint(equalToConstant: 1)])
        NSLayoutConstraint.activate([rightLine.centerYAnchor.constraint(equalTo: firstLayer.centerYAnchor),rightLine.rightAnchor.constraint(equalTo: firstLayer.rightAnchor),rightLine.leftAnchor.constraint(equalTo: thirdLayer.rightAnchor),rightLine.heightAnchor.constraint(equalToConstant: 1)])
        NSLayoutConstraint.activate([bottomLine.centerXAnchor.constraint(equalTo: firstLayer.centerXAnchor),bottomLine.bottomAnchor.constraint(equalTo: firstLayer.bottomAnchor),bottomLine.topAnchor.constraint(equalTo: thirdLayer.bottomAnchor),bottomLine.widthAnchor.constraint(equalToConstant: 1)])
     NSLayoutConstraint.activate([saveArea.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),saveArea.rightAnchor.constraint(equalTo: self.view.rightAnchor),saveArea.leftAnchor.constraint(equalTo: self.view.leftAnchor),saveArea.heightAnchor.constraint(equalToConstant: 30)])
        let shadowSize :CGFloat = 3.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.view.frame.width, height: shadowSize))
        options.layer.masksToBounds = false
        options.layer.shadowColor = UIColor.black.cgColor
        options.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        options.layer.shadowOpacity = 0.5
        options.layer.shadowPath = shadowPath.cgPath
        
    }
}

extension HomeController:HomeContract{
    func newMessageRecived(message: MessageModel) {
        self.chatHolder.newMessage(message: message)
    }
    
    func toggleGameOption() {
        self.options.menuTaped()
    }
    
    func resetTheBoard() {
        firstLayer.clear()
        secondLayer.clear()
        thirdLayer.clear()
    }
    
    func showChatBox() {
        self.options.showChatBox()
    }
    
    func hideChatBox() {
        self.options.hideChatBox()
    }
    
    func clearChat() {
        self.chatHolder.clear()
    }
    
    func showOpponentFinder() {
        loading.startAnimating()
        loading.isHidden = false
        findOpponent.isHidden = false
    }
    
    func hideOpponentFinder() {
        loading.stopAnimating()
        loading.isHidden = true
        findOpponent.isHidden = true

    }
    
    func gameIsEnded(title:String,message:String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.default, handler: nil))
          alert.addAction(UIAlertAction(title: "دوباره", style: UIAlertAction.Style.default, handler: {
            action in
            self.presenter?.resetSelected()
            self.options.menuTaped()
          }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func score(redScore: Int, blueScore: Int) {
        self.redScore.text = String(redScore)
        self.blueScore.text = String(blueScore)
    }
    
    func gameManagerNotSelected() {
        let alert  = UIAlertController(title: "خطا", message: "لطفا یک گزینه انتخاب کنید", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "باشه", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeColorAt(row: Int, col: Int, layer:Int,playerColor:Player) {
        switch layer {
        case 1:
            thirdLayer.itemSelectedAt(row: row, col: col,player: playerColor)
            break
        case 2:
            secondLayer.itemSelectedAt(row: row, col: col,player: playerColor)
            break
        case 3:
            firstLayer.itemSelectedAt(row: row, col: col,player: playerColor)
            break
        default:
            break
        }
    }
}

extension HomeController:boardInterface,SebzehInterface {
    func newMessageTapped(message: String) {
        presenter?.sendMessage(msg: message)
    }
    func cellTappedAt(row: Int, col: Int, layer:Int) {
        presenter?.cellTappedAt(row: row, col: col, layer: layer)
    }
    
    func isYourTurn() -> Bool {
        return presenter!.isYourTurn()
    }
    
    func layerat(layerNum: Int) {
    }
}

extension HomeController:gameOptionsProtocol{
    func twoPlayerSelected() {
        self.presenter?.twoPlayerSelected()
    }
    
    func onlineSelected() {
        self.presenter?.onlineGameSelected()
    }
    
    func resetSelected() {
        self.presenter?.resetSelected()
    }
    
    func botSelected() {
        self.presenter?.aiGameSelected()
    }
}


