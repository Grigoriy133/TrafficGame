//
//  GameConstants.swift
//  Traffic2
//
//  Created by Гриша  on 13.12.2023.
//

import Foundation
import UIKit

public class GameConstants {
    static var share = GameConstants()
    var leftTreesEdgeCoordinate: (CGFloat, CGFloat) {
        let x = UIScreen.main.bounds.width / 16
        let y = UIScreen.main.bounds.height * -0.1
        return (x,y)
    }
    var treesSizes: CGFloat {
        let h = UIScreen.main.bounds.width / 16
        return h
    }
    var leftRoadEdgeCoordinate: (CGFloat, CGFloat) {
        let x = UIScreen.main.bounds.width * 1 / 4
        let y = UIScreen.main.bounds.height * -1
        return (x,y)
    }
    var rightRoadEdgeCoordinate: (CGFloat, CGFloat) {
        let x = UIScreen.main.bounds.width * 3 / 4
        let y = UIScreen.main.bounds.height * -1
        return (x,y)
    }
    var roadEdgesSizes: (CGFloat, CGFloat) {
        let h = UIScreen.main.bounds.height
        let w = CGFloat(10)
        return (h,w)
    }
    var centerRoadH = CGFloat(30)
    var centerX: CGFloat{
        return  UIScreen.main.bounds.width / 2
    }
    var rightTreesEdgeCoordinate: (CGFloat, CGFloat) {
        let x = UIScreen.main.bounds.width * 14 / 16
        let y = UIScreen.main.bounds.height * -0.1
        return (x,y)
    }
    var carSizes: (CGFloat, CGFloat){
        let w = UIScreen.main.bounds.width / 4 * 0.75
        let h = UIScreen.main.bounds.height * 0.2
        return (w,h)
    }
    var carStartCoodinates: (CGFloat, CGFloat) {
        let x = UIScreen.main.bounds.width * 0.5 + UIScreen.main.bounds.width / 4 * 0.2
        let y = UIScreen.main.bounds.height * 0.7
        return (x,y)
    }
    var otherCarStartCoordinates: (CGFloat, CGFloat) {
        let x1 = UIScreen.main.bounds.width * 0.5 + UIScreen.main.bounds.width / 4 * 0.2
        let y1 = CGFloat(0) - UIScreen.main.bounds.height * 0.7
        return (x1, y1)
    }
    var distanseToMove: CGFloat{
        let distance = UIScreen.main.bounds.width / 4
        return distance
    }
}
