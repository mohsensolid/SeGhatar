//
//  GameManagerDelegate.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
protocol GameManagerDelegate {
    func isYourTurn()->Bool
    func cellTappedAt(row:Int,col:Int,layer:Int)
    func dispose()
    func restart()
    func sendMessage(message:String)
}
