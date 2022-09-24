//
//  MonthConfig.swift
//  CalenderWidgetExtension
//
//  Created by Vinayak Bector on 2022-09-24.
//

import Foundation
import SwiftUI

struct MonthConfig {
    let backgroundcolor: Color
    let emojiText: String
    let textColor: Color
    
    static func RandEmojGen() -> String {
        return String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    }

    static func complementColorGen(red: Double, green: Double, blue: Double) -> Color {
        // r' = max(r,b,g) + min(r,b,g) - r
        // b' = max(r,b,g) + min(r,b,g) - b
        // g' = max(r,b,g) + min(r,b,g) - g
        let axis : Double = max(red,blue,green) + min(red,blue,green)
        let redValue = axis - red
        let blueValue = axis - blue
        let greenValue = axis - blue
        return Color(red:redValue/255,green:greenValue/255,blue:blueValue/255)
        
    }
    static func determineMonthConfig() -> MonthConfig {
        let redValue = Double.random(in: 1...255)
        let blueValue = Double.random(in: 1...255)
        let greenValue = Double.random(in: 1...255)
        let baseColor =  Color(red:redValue/255,green:greenValue/255,blue:blueValue/255)
        let oppColor = complementColorGen(red: redValue,green: blueValue,blue: greenValue)
        return MonthConfig(backgroundcolor:baseColor,emojiText:RandEmojGen(),textColor:oppColor)


    }
}


