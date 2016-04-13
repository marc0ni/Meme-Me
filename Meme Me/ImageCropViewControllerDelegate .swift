//
//  ImageCropViewControllerDelegate .swift
//  Meme Me
//
//  Created by Mark Lindamood on 4/6/16.
//  Copyright © 2016 udacity. All rights reserved.
//

/*import UIKit
import Foundation

protocol ImageCropViewControllerDelegate :class {
    
    // Drag-zoom enabled rectangle to select a area.
    init(origin: CGPoint, width: CGFloat,   height: CGFloat) {
    super.init(frame: CGRectMake(0.0, 0.0, width, height))
    _cropoptions = CROP_OPTIONS()
    _cropoptions.Center = origin
    let insetRect = CGRectInset(self.bounds,lineWidth,lineWidth)
    self.path = UIBezierPath(roundedRect: insetRect, cornerRadius: 0.0)
    self.center = origin
    self.fillColor = UIColor(red: 0.09, green: 0.56, blue: 0.8, alpha: 0.2)
    _cropoptions.Width = self.bounds.width
    _cropoptions.Height = self.bounds.height
    self.backgroundColor = UIColor.clearColor()
    addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "panning:"))
    addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "pinching:"))
    }
    
    func panning(panGR: UIPanGestureRecognizer) {
    self.superview!.bringSubviewToFront(self)
    var translation = panGR.translationInView(self)
    translation = CGPointApplyAffineTransform(translation, self.transform)
    self.center.x += translation.x
    self.center.y += translation.y
    panGR.setTranslation(CGPointZero, inView: self)
    _cropoptions.Center = self.center
    }
    
    func pinching(pinchGR: UIPinchGestureRecognizer) {
    self.superview!.bringSubviewToFront(self)
    let scale = pinchGR.scale
    self.transform = CGAffineTransformScale(self.transform, scale, scale)
    _cropoptions.Height = self.frame.height
    _cropoptions.Width = self.frame.width
    pinchGR.scale = 1.0
    }
    
    func drawRect(rect: CGRect) {
    self.fillColor.setFill()
    self.path.fill()
    self.path.lineWidth = self.lineWidth
    UIColor.whiteColor().setStroke()
    self.path.stroke()
    }
    
    // Get the same area from the image as well.
    struct xy {
        var x: CGFloat!
        var y: CGFloat!
        mutating func xy(_x: CGFloat , _y: CGFloat){
            self.x = _x
            self.y = _y
        }
    }
    enum CROP_TYPE{
        case square, rect3x2,  rect2x3,  rect3x4,  rect4x3,  rect2x5,  rect5x2
        static let divs = [square : 1, rect3x2 : 5, rect2x3 : 5,rect3x4 : 7, rect4x3 : 7, rect2x5 : 7,rect5x2 : 7]
        static let muls = [square : xy(x: 0.5, y: 0.5), rect3x2 : xy(x: 3/5, y: 2/5), rect2x3 : xy(x: 2/5, y: 2/5),rect3x4 : xy(x: 3/7, y: 4/7), rect4x3 : xy(x: 4/7, y: 3/7), rect2x5 : xy(x: 2/7, y: 5/7),rect5x2 : xy(x: 5/7, y: 2/7)]
        static let names = [square : " 1:1 ", rect3x2 : " 3:2 ", rect2x3 : " 2:3 ",rect3x4 : " 3:4 ", rect4x3 : " 4:3 ", rect2x5 : " 2:5 ",rect5x2 : " 5:2 "]
        func Div()-> Int{
            if let ret = CROP_TYPE.divs[self]{
                return ret
            }else{
                return -1
            }
        }
        func Muls()-> xy{
            if let ret = CROP_TYPE.muls[self]{
                return ret
            }else{
                return xy(x: 0.5,y: 0.5)
            }
        }
        func Name()-> String{
            if let ret = CROP_TYPE.names[self]{
                return ret
            }else{
                return "n.a."
            }
        }
    }
    struct CROP_OPTIONS {
        var Height: CGFloat!
        var Width: CGFloat!
        var Center: CGPoint!
    }
    struct FRAME {
        var Height: CGFloat!
        var Width: CGFloat!
    }
    var  _cropoptions: CROP_OPTIONS!
    var _frame: CROP_OPTIONS!
    var croptype: CROP_TYPE!
    
    
    // Show some pre-defined output image ratio.
    
    
    // Show the result
    
    
    // Saving/ re-selecting image
    
}*/


