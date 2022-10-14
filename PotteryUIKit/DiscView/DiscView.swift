//
//  DiscView.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 08/10/2022.
//

import UIKit

final class DiscView: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        rotate()
    }
    
    var discColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var brushColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var brushSize: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var rotationSpeed: CGFloat = 0.05
    
    private var previousTouchPoints: [[CGPoint]] = []
    private var currentTouchPoints: [CGPoint] = []
    private var currentPoint: CGPoint?
    private var rotationAngle: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.clear(bounds)
        drawCircle(context: context)
        drawTouches(context: context)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        previousTouchPoints.append(currentTouchPoints)
        currentTouchPoints = touches.map { $0.location(in: self) }
        currentPoint = touches.first?.location(in: nil)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        currentTouchPoints.append(contentsOf: touches.map { $0.location(in: self) })
        currentPoint = touches.first?.location(in: nil)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        currentTouchPoints.append(contentsOf: touches.map { $0.location(in: self) })
        currentPoint = nil
        setNeedsDisplay()
    }
    
    private func drawTouches(context: CGContext) {
        drawPreviousTouches(context: context)
        drawCurrentTouches(context: context)
        drawCurrentTouches(context: context)
    }
    
    private func drawPreviousTouches(context: CGContext) {
        for touchPoints in previousTouchPoints {
            drawTouches(touchPoints, context: context)
        }
    }
    
    private func drawTouches(_ touches: [CGPoint], context: CGContext) {
        guard let firstTouch = touches.first else { return }
        let path = UIBezierPath()
        path.move(to: firstTouch)
        for touch in touches {
            path.addLine(to: touch)
        }
        
        context.setStrokeColor(brushColor.cgColor)
        context.setLineWidth(brushSize)
        context.setLineCap(.round)
        context.addPath(path.cgPath)
        context.strokePath()
    }
    
    private func drawCurrentTouches(context: CGContext) {
        drawTouches(currentTouchPoints, context: context)
    }
    
    private func drawCircle(context: CGContext) {
        let path = UIBezierPath(ovalIn: centeredSquare())
        context.setFillColor(discColor.cgColor)
        context.addPath(path.cgPath)
        context.fillPath()
    }
    
    private func centeredSquare() -> CGRect {
        let sideLength = min(bounds.width, bounds.height)
        let y = (bounds.height - sideLength) / 2
        let x = (bounds.width - sideLength) / 2
        
        return CGRect(
            origin: .init(x: x, y: y),
            size: .init(width: sideLength, height: sideLength)
        )
    }
    
    private func rotate() {
        let displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback))
        displayLink.add(to: .main, forMode: .common)
    }
    
    @objc private func displayLinkCallback() {
        rotateDisc()
        sampleCurrentNonMovingTouch()
    }
    
    private func rotateDisc() {
        rotationAngle = (rotationAngle + rotationSpeed).truncatingRemainder(dividingBy: .pi * 2)
        transform = .init(rotationAngle: rotationAngle)
    }
    
    private func sampleCurrentNonMovingTouch() {
        guard let currentPoint = currentPoint else { return }
        let transformedPoint = convert(currentPoint, from: nil)
        currentTouchPoints.append(transformedPoint)
        setNeedsDisplay()
    }
}
