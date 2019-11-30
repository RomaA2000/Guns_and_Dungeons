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
    case notLine;
}

class Line {
    var a : CGFloat;
    var b : CGFloat;
    var c : CGFloat;
    init(a : CGFloat, b : CGFloat, c : CGFloat) throws {
        self.a = a;
        self.b = b;
        self.c = c;
        if (a != 0) {
            self.b /= a;
            self.c /= a;
        } else if b != 0 {
            self.c /= b;
        } else {
            throw GeometryExeption.notLine;
        }
    }
    init(p1 : CGPoint, p2 : CGPoint) throws {
        if (p1 == p2) {
            throw GeometryExeption.notLine;
        } else if (p1.x == p2.x) {
            self.a = 0.0;
            self.b = 1.0;
            self.c = p1.x;
        } else if p1.y == p2.y {
            self.a = 1.0;
            self.b = 0.0;
            self.c = p1.y;
        }
        let dx = (p2.y - p1.y);
        let dy = (p2.x - p1.x);
        self.a = 1.0 / dy;
        self.b = -1.0 / dx;
        self.c = p1.x / dx - p1.y / dy;
        self.b /= a;
        self.c /= a;
    }
    
    func distance(p1 : CGPoint) -> CGFloat {
        return (a * p1.x + b * p1.y + c) / sqrt(a * a + b * b);
    }
    
    func isInside(lines : Array<Line>) -> Bool {
        var less : Bool = false;
        var greater : Bool = false;
        for i in lines {
            if (self < i) {
                greater = true;
            } else if (self > i) {
                less = true;
            }
            if (less && greater) {
                return true;
            }
        }
        return false;
    }
}

class Circle {
    var c : CGPoint;
    var r : CGFloat;
    init(c : CGPoint, r : CGFloat) {
        self.c = c;
        self.r = r;
    }
    func intersect(l : Line) -> Bool {
        return l.distance(p1: c) < r;
    }
}

func toLineArray(p : CGPoint, array : Array<CGPoint>) throws -> Array<Line> {
    var ans : Array<Line> =  Array<Line>();
    for i in array {
        try ans.append(Line(p1: p, p2: i));
    }
    return ans;
}

extension Line {
    static func < (line1 : Line, line2 : Line) -> Bool {
        if (line1.a == 0 || line2.a == 0) {
            return line1.a != 0;
        } else {
            return line1.b > line2.b;
        }
    }
    
    static func > (line1 : Line, line2 : Line) -> Bool {
        return line2 < line1;
    }
    
    static func == (line1 : Line, line2 : Line) -> Bool {
        return (line1.a == line2.a) && (line1.b == line2.b) && (line1.c == line2.c);
    }
    
    static func != (line1 : Line, line2 : Line) -> Bool {
        return !(line1 == line2);
    }
    
    static func >= (line1 : Line, line2 : Line) -> Bool {
        return (line1 > line2) || (line2 == line1);
    }
    
    static func <= (line1 : Line, line2 : Line) -> Bool {
        return (line1 < line2) || (line2 == line1);
    }
}

extension CGRect {
    func intersect(line : Line) throws -> Bool {
        let p = CGPoint(x: 0, y: line.a + line.c);
        return try line.isInside(lines: toLineArray(p: p, array: pointArray()));
    }
    
    func intersect(p1 : CGPoint, p2 : CGPoint) throws -> Bool {
        let line = try Line(p1: p1, p2: p2);
        return line.isInside(lines:
            try toLineArray(p: p1,
                            array: pointArray()));
    }

    func pointArray() -> Array<CGPoint> {
        let x = self.origin.x;
        let y = self.origin.y;
        let w = self.width;
        let h = self.height;
        return [CGPoint(x: x,y: y), CGPoint(x: x + w,y: y),
                CGPoint(x: x + w,y: y - h), CGPoint(x: x,y: y - h)]
    }
}
