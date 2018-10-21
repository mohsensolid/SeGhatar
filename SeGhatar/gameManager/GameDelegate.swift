//
//  GameDelegate.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
protocol GameDelegate {
    func changeItemAt(row:Int,col:Int,layer:Int,player:Player)
    func newMessageRecive(message:String,player:Bool)
    func oppnentFinded();
    func userDisconnected(player:Player)
}
