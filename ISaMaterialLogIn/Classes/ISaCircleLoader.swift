//
//  ISaCircleLoader.swift
//  Pods
//
//  Created by Francesco on 01/12/16.
//
//

import Foundation
import UIKit

@IBDesignable

 public class ISaCircleLoader: UIView  {
    
    public override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }
    
    override public class var layerClass: AnyClass { return CAShapeLayer.self }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 1.5
        setPath()
    }
    
    public override func didMoveToWindow() {
        animate()
    }
    
    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }
    
    struct Delay {
        let secondsSincePriorDelay: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorDelay: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorDelay = secondsSincePriorDelay
            self.start = start
            self.length = length
        }
    }
    
    var delays: [Delay] {
            return [
                Delay(0.0, 0.000, 0.7),
                Delay(0.2, 0.500, 0.5),
                Delay(0.2, 1.000, 0.3),
                Delay(0.2, 1.500, 0.1),
                Delay(0.2, 1.875, 0.1),
                Delay(0.2, 2.250, 0.3),
                Delay(0.2, 2.625, 0.5),
                Delay(0.2, 3.000, 0.7),
            ]
    }
    
    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let totalSeconds = self.delays.reduce(0) { $0 + $1.secondsSincePriorDelay }
        
        for Delay in self.delays {
            time += Delay.secondsSincePriorDelay
            times.append(time / totalSeconds)
            start = Delay.start
            rotations.append(start * 2 * CGFloat(M_PI))
            strokeEnds.append(Delay.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        
        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
        
        //animateStrokeHueWithDuration(duration: totalSeconds * 5)
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = kCAAnimationLinear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
    
    func animateStrokeHueWithDuration(duration: CFTimeInterval) {
        let count = 36
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        let keyTimes = (0 ... count).map { CFTimeInterval($0) / CFTimeInterval(count) }
        animation.keyTimes = keyTimes as [NSNumber]?
        animation.values = (0 ... count).map {
            UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        animation.duration = duration
        animation.calculationMode = kCAAnimationLinear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
}
