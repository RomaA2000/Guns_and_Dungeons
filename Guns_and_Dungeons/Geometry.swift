//
//  Geometry.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 26.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

enum GeometryExeption : Error {
    case notLine
}

class Line {
    var a : CGFloat
    var b : CGFloat
    var c : CGFloat
    init(a : CGFloat, b : CGFloat, c : CGFloat) throws {
        self.a = a
        self.b = b
        self.c = c
        if (a != 0) {
            self.b /= a
            self.c /= a
        } else if b != 0 {
            self.c /= b
        } else {
            throw GeometryExeption.notLine
        }
    }
    init(p1 : CGPoint, p2 : CGPoint) throws {
        if (p1 == p2) {
            throw GeometryExeption.notLine
        } else if (p1.x == p2.x) {
            self.a = 0.0
            self.b = 1.0
            self.c = p1.x
        } else if p1.y == p2.y {
            self.a = 1.0
            self.b = 0.0
            self.c = p1.y
        }
        let dx = (p2.y - p1.y)
        let dy = (p2.x - p1.x)
        self.a = 1.0 / dy
        self.b = -1.0 / dx
        self.c = p1.x / dx - p1.y / dy
        self.b /= a
        self.c /= a
    }
    
    func distance(p1 : CGPoint) -> CGFloat {
        return (a * p1.x + b * p1.y + c) / sqrt(a * a + b * b)
    }
}



class Circle {
    var c : CGPoint
    var r : CGFloat
    init(c : CGPoint, r : CGFloat) {
        self.c = c
        self.r = r
    }
    func intersect(l : Line) -> Bool {
        return l.distance(p1: c) < r
    }
}

func toLineArray(p : CGPoint, array : Array<CGPoint>) throws -> Array<Line> {
    var ans : Array<Line> =  Array<Line>()
    for i in array {
        try ans.append(Line(p1: p, p2: i))
    }
    return ans
}

func toVectorArray(p : CGPoint, array : Array<CGPoint>) -> Array<CGVector> {
       var ans : Array<CGVector> =  Array<CGVector>()
       for i in array {
            ans.append(CGVector(p1: p, p2: i))
       }
       return ans
}

extension CGVector {
    init(p1 : CGPoint, p2 : CGPoint) {
        self.init()
        self.dx = p2.x - p1.x
        self.dy = p2.y - p1.y
    }
    
    static func sign_sin(v1 : CGVector, v2 : CGVector) -> CGFloat {
        return v1.dx * v2.dy - v1.dy * v2.dx
    }
    
    static func sign_cos(v1 : CGVector, v2 : CGVector) -> CGFloat {
        return v1.dx * v2.dx + v1.dy * v2.dy
    }
    
    func isInside(array : Array<CGVector>) -> Bool {
        var leftPart = false
        var rightPart = false
        for i in array {
            if CGVector.sign_cos(v1: self, v2: i) > 0 {
                if CGVector.sign_sin(v1: self, v2: i) > 0 {
                    leftPart = true
                } else if CGVector.sign_sin(v1: self, v2: i) < 0 {
                    rightPart = true
                }
                if (leftPart && rightPart) {
                    return true
                }
            }
        }
        return false
    }
    
    mutating func multiply(_ multiplier: CGFloat) -> CGVector {
        self.dx *= multiplier
        self.dy *= multiplier
        return self
    }
    
    mutating func setDirection(_ leadingVector: CGVector) -> CGVector {
        self.dx *= leadingVector.dx
        self.dy *= leadingVector.dy
        return self
    }
}

extension Line {
    static func < (line1 : Line, line2 : Line) -> Bool {
        if (line1.a == 0 || line2.a == 0) {
            return line1.a != 0
        } else {
            return line1.b > line2.b
        }
    }
    
    static func > (line1 : Line, line2 : Line) -> Bool {
        return line2 < line1
    }
    
    static func == (line1 : Line, line2 : Line) -> Bool {
        return (line1.a == line2.a) && (line1.b == line2.b) && (line1.c == line2.c)
    }
    
    static func != (line1 : Line, line2 : Line) -> Bool {
        return !(line1 == line2)
    }
    
    static func >= (line1 : Line, line2 : Line) -> Bool {
        return (line1 > line2) || (line2 == line1)
    }
    
    static func <= (line1 : Line, line2 : Line) -> Bool {
        return (line1 < line2) || (line2 == line1)
    }
}

extension CGRect {
    func intersect(p : CGPoint, v : CGVector) -> Bool {
        let array : Array<CGVector> = toVectorArray(p : p, array : pointArray())
        return v.isInside(array: array)
    }
    
    func pointArray() -> Array<CGPoint> {
        let x = self.origin.x
        let y = self.origin.y
        let w = self.width
        let h = self.height
        return [CGPoint(x: x,y: y), CGPoint(x: x + w,y: y),
                CGPoint(x: x + w,y: y + h), CGPoint(x: x,y: y + h)]
    }
}

func getVectorByAngle(angle: CGFloat) -> CGVector {
    return CGVector(dx: cos(angle), dy : sin(angle))
}
