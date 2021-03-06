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

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(distanceX(to: point), 2) + pow(distanceY(to: point), 2))
    }
    
    func distanceX(to point: CGPoint) -> CGFloat {
        return abs(point.x - x)
    }
    
    func distanceY(to point: CGPoint) -> CGFloat {
        return abs(point.y - y)
    }
}

extension CGVector {
    init(p1 : CGPoint, p2 : CGPoint) {
        self.init()
        self.dx = p2.x - p1.x
        self.dy = p2.y - p1.y
    }
    
    func sign_sin(v1 : CGVector) -> CGFloat {
        return dx * v1.dy - dy * v1.dx
    }
    
    func sign_cos(v1 : CGVector) -> CGFloat {
        return (dx * v1.dx + dy * v1.dy)
    }
    
    func cos(v1 : CGVector) -> CGFloat {
        return sign_cos(v1: v1) / (length() + v1.length())
    }
    
    func length() -> CGFloat {
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
    
    func isInside(array : Array<CGVector>) -> Bool {
        var leftPart = false
        var rightPart = false
        var allBehind = true
        for i in array {
            if sign_cos(v1: i) > 0 {
                allBehind = false
            }
        }
        if allBehind {
            return false
        }
        for i in array {
                if sign_sin(v1: i) > 0 {
                    leftPart = true
                } else if sign_sin(v1: i) < 0 {
                    rightPart = true
                } else {
                    rightPart = true
                    leftPart = true
                }
                if (leftPart && rightPart) {
                    return true
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
    
    func getAngle(v: CGVector) -> CGFloat {
        var l : CGFloat = 1
        if (sign_sin(v1: v) > 0) {
            l = -1
        }
        return acos(cos(v1: v)) * l
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
    
    func intersect(p1 : CGPoint, p2 : CGPoint) -> Bool {
        if (isBetween(p1: p1, p2: p2)) {
            return true
        } else if isNear(p1 : p1, p2 : p2) {
            return false
        } else {
            let v : CGVector = CGVector(dx: p2.x - p1.x, dy: p2.y - p1.y)
            return intersect(p : p1, v : v)
        }
    }
    
    func isNear(p1 : CGPoint, p2 : CGPoint) -> Bool {
        let midX = (minX + maxX) / 2
        let midY = (minY + maxY) / 2
        return p1.distanceX(to: p2) < getDistX(p: p1) || p1.distanceY(to: p2) < getDistY(p: p1) ||
            (p2.x < p1.x && p1.x < midX) || (p2.x > p1.x && p1.x > midX) ||
            (p2.y < p1.y && p1.y < midY) || (p2.y > p1.y && p1.y > midY)
    }
    
    func isBetween(p1 : CGPoint, p2 : CGPoint) -> Bool {
        return isBetweenX(p1: p1, p2: p2) || isBetweenY(p1: p1, p2: p2)
    }
    
    func isBetweenY(p1 : CGPoint, p2 : CGPoint) -> Bool {
        return isInsideX(p: p1) && isInsideX(p: p2) && ((p1.y < minY && minY < p2.y) || (p1.y > minY && minY > p2.y))
    }
    
    func isInsideX(p: CGPoint) -> Bool {
        return (minX < p.x) && (p.x < maxX)
    }
    
    func isBetweenX(p1 : CGPoint, p2 : CGPoint) -> Bool {
        return isInsideY(p: p1) && isInsideY(p: p2) && ((p1.x < minX && minX < p2.x) || (p1.x > minX && minX > p2.x))
    }
    
    func isInsideY(p: CGPoint) -> Bool {
        return (minY < p.y) && (p.y < maxY)
    }
    
    func getDistX(p : CGPoint) -> CGFloat {
        return min(abs(p.x - minX), abs(p.x - maxX))
    }
    
    func getDistY(p : CGPoint) -> CGFloat {
        return min(abs(p.y - minY), abs(p.y - maxY))
    }
    
    func pointArray() -> Array<CGPoint> {
        let x = self.minX
        let y = self.maxY
        let w = self.width
        let h = self.height
        return [CGPoint(x: x,y: y), CGPoint(x: x + w,y: y),
                CGPoint(x: x + w,y: y - h), CGPoint(x: x, y: y - h)]
    }
}

func getVectorByAngle(angle: CGFloat) -> CGVector {
    return CGVector(dx: cos(angle), dy : sin(angle))
}
