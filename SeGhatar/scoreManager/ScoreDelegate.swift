//
//  ScoreDelegate.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
protocol ScoreDelegate {
    func score(redScore:Int,blueScore:Int)
    func gameIsEnded(redScore:Int,blueScore:Int)
    
}
