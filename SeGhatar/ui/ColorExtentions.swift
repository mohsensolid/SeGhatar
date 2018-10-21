//
//  Extentions.swift
//  SeGhatar
//
//  Created by MAC on 7/24/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit
import Foundation

extension UIColor{
    convenience init(red:Int,green:Int,blue:Int){
        self.init(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    }
    convenience init(rgb: Int,alpha:CGFloat = 1.0){
        self.init(red: CGFloat((rgb>>16) & 0xFF), green: CGFloat((rgb >> 8) & 0xFF), blue: CGFloat(rgb & 0xFF), alpha: alpha)
    }
   class var appBackground : UIColor {
        return UIColor(white: 0.92, alpha: 1)
    }
    class var borderColor : UIColor {
        return UIColor(white: 0.82, alpha: 1)
    }
    class var circleBorderColor:UIColor{
        return UIColor(white: 0.70, alpha: 1)
    }
    class var redColor:UIColor{
        return UIColor.red
    }
    class var blueColor:UIColor{
        return UIColor.blue
    }
}


