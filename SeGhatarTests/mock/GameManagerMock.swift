//
//  GameManagerMock.swift
//  SeGhatarTests
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
@testable import SeGhatar
class GameManagerMock: GameManagerDelegate {
    var cellTappedVerify:Bool = false
    var disposeVerfiy:Bool = false
    var restartVerfiy:Bool = false
    var sendMessageVerify:Bool = false
    var isYourTurnVerify:Bool = false
    init() {
        
    }
    func isYourTurn() -> Bool {
        isYourTurnVerify = true
        return true
    }
    
    func cellTappedAt(row: Int, col: Int, layer: Int) {
        cellTappedVerify = true
    }
    
    func dispose() {
        disposeVerfiy = true
    }
    
    func restart() {
        restartVerfiy  = true
    }
    
    func sendMessage(message: String) {
        sendMessageVerify = true
    }
    
    
}
