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
        setUpDiscLayer()
        rotate()
    }
    
    var discColor: UIColor = .white {
        didSet {
            updateDiscLayerColor()
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
    
    private var currentTouchPoints: [CGPoint] = []
    private var currentPoint: CGPoint?
    private var rotationAngle: CGFloat = 0
    private var discLayer: CAShapeLayer!
    private var currentPathLayer: CAShapeLayer?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        currentTouchPoints = touches.map { $0.location(in: self) }
        currentPoint = touches.first?.location(in: nil)
        drawTouches()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        currentTouchPoints.append(contentsOf: touches.map { $0.location(in: self) })
        currentPoint = touches.first?.location(in: nil)
        drawTouches()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        currentTouchPoints.append(contentsOf: touches.map { $0.location(in: self) })
        currentPoint = nil
        currentPathLayer = nil
        drawTouches()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redrawDisc()
    }
    
    private func redrawDisc() {
        let discLayerFrame = centeredSquare()
        discLayer.frame = discLayerFrame
        discLayer.path = makeDiscPath(frame: discLayerFrame)
    }
    
    private func makeDiscPath(frame: CGRect) -> CGPath {
        UIBezierPath(ovalIn: frame).cgPath
    }
    
    private func setUpDiscLayer() {
        discLayer = CAShapeLayer()
        layer.addSublayer(discLayer)
        updateDiscLayerColor()
    }
    
    private func updateDiscLayerColor() {
        discLayer.fillColor = discColor.cgColor
    }
    
    private func drawTouches() {
        drawTouches(currentTouchPoints)
    }
    
    private func drawTouches(_ touches: [CGPoint]) {
        guard let firstTouch = touches.first else { return }
        let path = UIBezierPath()
        path.move(to: firstTouch)
        for touch in touches {
            path.addLine(to: touch)
        }
        
        let shapeLayer = currentPathLayer ?? CAShapeLayer()
        shapeLayer.strokeColor = brushColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = brushSize
        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath
        if currentPathLayer == nil {
            layer.addSublayer(shapeLayer)
            currentPathLayer = shapeLayer
        }
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
        drawTouches()
    }
}
