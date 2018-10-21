//
//  chatController.swift
//  SeGhatar
//
//  Created by MAC on 7/27/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class chatController: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let messageFrameSize:CGFloat = 280
    let messageMargin:CGFloat = 8
    let bubbleMargin:CGFloat = 20
    var items:[MessageModel]=[]
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = items[indexPath.row].message
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let size = CGSize(width: messageFrameSize, height: 1000)
        let estmiteFrame = NSString(string: message).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fonts.medium)], context: nil)
        return CGSize(width:frame.width , height: estmiteFrame.height + bubbleMargin)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! MessageItemCell
        cell.messageWrapped = self.items[indexPath.row]
        
        
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let size = CGSize(width: messageFrameSize, height: 1000)
        let estmiteFrame = NSString(string: self.items[indexPath.row].message).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fonts.medium)], context: nil)
        if self.items[indexPath.row].sender{
             cell.messageTxt.frame = CGRect(x: frame.width - messageMargin, y: 0, width: -estmiteFrame.width - bubbleMargin, height: estmiteFrame.height + bubbleMargin )
        }else{
           cell.messageTxt.frame = CGRect(x: messageMargin, y: 0, width: estmiteFrame.width + bubbleMargin , height: estmiteFrame.height + bubbleMargin )
        }
       
        return cell
    }
    
    
    lazy var  cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.alwaysBounceVertical =  true
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        return cv
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView(){
        addSubview(cv)
        cv.register(MessageItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        NSLayoutConstraint.activate([cv.topAnchor.constraint(equalTo: self.topAnchor),cv.bottomAnchor.constraint(equalTo: self.bottomAnchor),cv.rightAnchor.constraint(equalTo: self.rightAnchor),cv.leftAnchor.constraint(equalTo: self.leftAnchor)])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func newMessage(message:MessageModel){
        items.append(message)
        cv.reloadData()
        if items.count > 2{
            let lastItemIndex = IndexPath(item: items.count - 1, section: 0)
            cv.scrollToItem(at: lastItemIndex, at: .bottom, animated: true)
        }
       
    }
    func clear(){
        items = []
        cv.reloadData()
    }
}
class MessageItemCell: UICollectionViewCell {
    
    let messageTxt :UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red
        label.textAlignment = .right
        label.layer.cornerRadius = CGFloat(18)
        label.font = UIFont.systemFont(ofSize: fonts.medium)
        return label
    }()
    var messageWrapped:MessageModel?{
        didSet{
            guard  let message = messageWrapped else {
                return
            }
            messageTxt.text = message.message
            if message.sender {
                messageTxt.textAlignment = .right
                messageTxt.backgroundColor = UIColor(white: 0.98, alpha: 1)
            }else{
                messageTxt.textAlignment = .left
                messageTxt.backgroundColor = UIColor(white: 0.7, alpha: 1)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    func setupView(){
        addSubview(messageTxt)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
