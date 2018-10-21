//
//  PresenterMock.swift
//  SeGhatarTests
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
@testable import SeGhatar

class mockObject : ScoreDelegate {
    
    init() {
        
    }
    var scoreMethodVerfiy:Bool = false
    var gameEndVeryfiy:Bool = false
    var redScore = 0
    var blueScore = 0
    var gameIsEnd:Bool = false
    func score(redScore: Int, blueScore: Int) {
        self.scoreMethodVerfiy = true
        self.blueScore = blueScore
        self.redScore = redScore
    }
    
    
    func gameIsEnded(redScore: Int, blueScore: Int) {
        self.gameEndVeryfiy = true
        self.blueScore = blueScore
        self.redScore = redScore
    }
    
}
