//
//  Geometry.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 26.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import SpriteKit

class Line {
    var a : CGFloat;
    var b : CGFloat;
    var c : CGFloat;
    init(a : CGFloat, b : CGFloat, c : CGFloat) {
        self.a = a;
        self.b = b;
        self.c = c;
        if (a != 0) {
            self.b /= a;
            self.c /= a;
        } else if b != 0 {
            self.c /= b;
        } else {
            // how to throw exceptions
        }
    }
    init(p1 : CGPoint, p2 : CGPoint) {
        if (p1.x == p2.x) {
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
        var less : Bool;
        var greater : Bool;
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

extension CGRect {
    func intersect(line : Line) -> Bool {
        var lines : Array<Line> = Array<Line>();
        let p = CGPoint(x: 0, y: line.a + line.c);
        for i in self.pointArray() {
            lines.append(Line(p1 : p, p2 : i));
        }
        return line.isInside(lines: lines);
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
