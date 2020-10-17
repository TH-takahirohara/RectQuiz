//
//  ViewController.swift
//  RectQuiz
//
//  Created by 原昂大 on 2020/10/18.
//  Copyright © 2020 takahiro.hara. All rights reserved.
//

import Cocoa

struct Point {
    let location: CGPoint
}

class ViewController: NSViewController {
    
    let points = ["1": Point(location: CGPoint(x: 0, y: 0)), "2": Point(location: CGPoint(x: 3, y: 3)), "3": Point(location: CGPoint(x: 2, y: -2)), "4": Point(location: CGPoint(x: -3, y: 6))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(boundsOriginal(points: points))
        print(boundsOneLine(points: points))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func boundsOriginal(points: [String: Point]) -> CGRect {
        var origin: CGPoint = points.first!.value.location
        var extend = origin
        for (_, point) in points {
            origin.x = min(origin.x, point.location.x)
            origin.y = min(origin.y, point.location.y)
            extend.x = max(extend.x, point.location.x)
            extend.y = max(extend.y, point.location.y)
        }
        return CGRect(origin: origin, size: CGSize(width: extend.x - origin.x, height: extend.y - origin.y))
    }
    
    func boundsOneLine(points: [String: Point]) -> CGRect {
        return points.reduce(NSRect(x: points.first!.value.location.x, y: points.first!.value.location.y, width: 0, height: 0), { (rect, point) -> NSRect in  NSUnionRect(NSRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height), NSRect(x: CGFloat.minimum(rect.origin.x, point.value.location.x), y: CGFloat.minimum(rect.origin.y,  point.value.location.y), width: abs(point.value.location.x - rect.origin.x), height: abs(point.value.location.y - rect.origin.y)))})
    }

}

