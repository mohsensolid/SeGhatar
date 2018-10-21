//
//  gameOptions.swift
//  SeGhatar
//
//  Created by MAC on 7/26/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
protocol gameOptionsProtocol {
    func twoPlayerSelected()
    func onlineSelected()
    func resetSelected()
    func botSelected()
    func newMessageTapped(message:String)
}
class gameOptions: UIView,UITextViewDelegate {
    let menuIconSize:CGFloat = 35
    let backgroundSize:CGFloat = 60
    let backgroundExpandedSize:CGFloat = 170
    let itemSize:CGFloat = 110
    let sendMessageSize:CGFloat = 35
    let messageMargin:CGFloat = 10
    let msgExtSize:CGFloat = 40
    let defualtMargin:CGFloat = 10
    let smallMargin:CGFloat = 5
    var expanded:Bool = true
    var backgroundHeightConstraint : NSLayoutConstraint?
    var deleagete:gameOptionsProtocol?
    
    let background :UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let menuBtn : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "menu")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let sendBtn :UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "send")
        image.isUserInteractionEnabled = true
        image.isHidden = true
        image.transform = image.transform.rotated(by: CGFloat(Double.pi))
        return image
    }()
    
    lazy var messageExt : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "پیام..."
        text.font = UIFont(name: fonts.iranSans, size: fonts.large)
        text.isHidden = true
        text.delegate = self
        text.textColor = UIColor.lightGray
        text.keyboardType = .default
        text.textAlignment = .right
        return text
    }()
    let divider:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    lazy var items:OptionsItems = {
        let cv = OptionsItems(delegate: self)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    convenience init(delegate:gameOptionsProtocol){
        self.init(frame:.zero)
        self.deleagete = delegate
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "...پیام"
            textView.textColor = UIColor.lightGray
        }
    }
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {

            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.menuBtn.isUserInteractionEnabled = true
                self.backgroundHeightConstraint?.constant = backgroundSize
            } else {
                self.menuBtn.isUserInteractionEnabled = false
                self.backgroundHeightConstraint?.constant = (endFrame?.size.height)! + backgroundSize
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.layoutIfNeeded() },
                           completion: nil)
        }
    }
    func setupView(){
         
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        addSubview(background)
        addSubview(menuBtn)
        addSubview(sendBtn)
        addSubview(messageExt)
        addSubview(divider)
        addSubview(items)
        
        backgroundHeightConstraint = background.heightAnchor.constraint(equalToConstant: backgroundExpandedSize)
        
        NSLayoutConstraint.activate([background.topAnchor.constraint(equalTo: topAnchor),background.rightAnchor.constraint(equalTo: rightAnchor),background.leftAnchor.constraint(equalTo: leftAnchor),background.bottomAnchor.constraint(equalTo: bottomAnchor),backgroundHeightConstraint!])
        
        NSLayoutConstraint.activate([menuBtn.topAnchor.constraint(equalTo: topAnchor,constant:10),menuBtn.rightAnchor.constraint(equalTo: rightAnchor,constant:-10),menuBtn.heightAnchor.constraint(equalToConstant: menuIconSize),menuBtn.widthAnchor.constraint(equalToConstant: menuIconSize)])
        
        NSLayoutConstraint.activate([sendBtn.topAnchor.constraint(equalTo: topAnchor, constant: messageMargin),sendBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: messageMargin),sendBtn.heightAnchor.constraint(equalToConstant: sendMessageSize),sendBtn.widthAnchor.constraint(equalToConstant: sendMessageSize)])
        
        NSLayoutConstraint.activate([messageExt.topAnchor.constraint(equalTo: topAnchor, constant: defualtMargin),messageExt.heightAnchor.constraint(equalToConstant: msgExtSize),messageExt.rightAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: -smallMargin),messageExt.leftAnchor.constraint(equalTo: sendBtn.rightAnchor, constant: smallMargin)])
        
        NSLayoutConstraint.activate([divider.topAnchor.constraint(equalTo: topAnchor, constant: backgroundSize),divider.heightAnchor.constraint(equalToConstant: 1),divider.rightAnchor.constraint(equalTo: rightAnchor),divider.leftAnchor.constraint(equalTo: leftAnchor)])
        
        NSLayoutConstraint.activate([items.topAnchor.constraint(equalTo: divider.bottomAnchor),items.heightAnchor.constraint(equalToConstant: itemSize),items.rightAnchor.constraint(equalTo: rightAnchor),items.leftAnchor.constraint(equalTo: leftAnchor)])
        
        
        let menuTapp = UITapGestureRecognizer(target: self, action: #selector(menuTaped))
        
        menuBtn.addGestureRecognizer(menuTapp)
        
        let sendBtnTap = UITapGestureRecognizer(target: self, action: #selector(sendMessage))
        sendBtn.isUserInteractionEnabled = true
        sendBtn.addGestureRecognizer(sendBtnTap)
    }
    @objc func sendMessage(){
        guard let messageTxt = messageExt.text else {
            return
        }
        endEditing(true)
        self.deleagete?.newMessageTapped(message: messageTxt)
        self.messageExt.text = ""
    }
    @objc func menuTaped(){
        layoutIfNeeded()
        UIView.animate(withDuration: 0.4,delay: 0,usingSpringWithDamping: 0.6,initialSpringVelocity : 0,options:.curveEaseIn, animations: {
            if self.expanded{
                    self.backgroundHeightConstraint?.constant = CGFloat(self.backgroundSize)
                self.expanded = false
            }else{
                    self.backgroundHeightConstraint?.constant = CGFloat(self.backgroundExpandedSize)
                self.expanded = true
            }
            self.layoutIfNeeded()
        })
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func showChatBox(){
        self.messageExt.isHidden = false
        self.sendBtn.isHidden = false
    }
    func hideChatBox(){
        self.messageExt.isHidden = true
        self.sendBtn.isHidden = true
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
extension gameOptions:optionProtocol{
    func itemClicked(title: String) {
        switch title {
        case gameOptionsString.bot:
            self.deleagete?.botSelected()
            break
        case gameOptionsString.reset:
            self.deleagete?.resetSelected()
            break
        case gameOptionsString.online:
            self.deleagete?.onlineSelected()
            break
        case gameOptionsString.twoPlayer:
            self.deleagete?.twoPlayerSelected()
            break
        default:
            break
        }
    }
}
