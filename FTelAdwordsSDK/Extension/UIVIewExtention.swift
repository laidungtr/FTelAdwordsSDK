//
//  UIVIewExtention.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/9/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import Foundation
import UIKit

//MARK: UIView
extension UIView{
    
    //MARK: Gradient
    func gradientFromTopLeftToBottomRight(_ topColor: CGColor, bottomColor: CGColor, gradientFrame: CGRect){
        
        let gradient :GradientColors = GradientColors.init()
        gradient.setGradientFrame(gradientFrame)
        gradient.setColor(topColor, colorBottom: bottomColor)
        
        self.layer.insertSublayer(gradient.gradientTopLeftToBottomRight(), at: 0)
    }
    
    func gradientFromTopToBottom(_ topColor: CGColor, bottomColor: CGColor, gradientFrame: CGRect){
        let gradient :GradientColors = GradientColors.init()
        gradient.setGradientFrame(gradientFrame)
        gradient.setColor(topColor, colorBottom: bottomColor)
        
        
        self.layer.insertSublayer(gradient.gradientTopToBottom(), at: 0)
    }
    
    func renderLayoutShouldRasterize() {
        //return
        self.layer.masksToBounds = true;
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        
    }
    
    //MARK: Border Radius
    func borderWithRadius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func borderWithRadius(_ radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func shadownMake(_ color: UIColor , height: CGFloat = -5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: height)
        layer.shadowRadius = abs(height)
        layer.shadowOpacity = 1
    }
    
    func drawTriangle(_ size: CGFloat, x: CGFloat, y: CGFloat, up:Bool) {
        
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0 , y: 0))
        trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
        trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
        trianglePath.close()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.white.cgColor
        triangleLayer.anchorPoint = CGPoint.zero
        triangleLayer.position = CGPoint(x: x, y: y)
        triangleLayer.name = "triangle"
        self.layer.addSublayer(triangleLayer)
    }
    
    func createDashedBorder(_ borderColor: UIColor) -> CAShapeLayer  {
        let color = borderColor.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - 1, height: frameSize.height - 1)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.borderWithRadius(5)
        
        return shapeLayer
    }
    
    func createDashedBorder(_ borderColor: UIColor, lineWidth:CGFloat, lineDashPattern: [Int], borderRadius: CGFloat) -> CAShapeLayer  {
        let color = borderColor.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - 1, height: frameSize.height - 1)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = lineDashPattern as [NSNumber]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.borderWithRadius(borderRadius)
        
        return shapeLayer
    }

}


//MARK: - gradient Color Make
class GradientColors {
    
    var colorTop: CGColor
    var colorBottom: CGColor
    var gradient :CAGradientLayer
    
    init(){
        colorTop = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0).cgColor
        colorBottom = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1).cgColor
        gradient = CAGradientLayer()
    }
    
    func setColor(_ colorTop: CGColor, colorBottom: CGColor){
        self.colorTop = colorTop
        self.colorBottom = colorBottom
    }
    
    func gradientTopLeftToBottomRight()->CAGradientLayer{
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [colorTop,colorBottom]
        //        gradient.locations = [0.0,1.0]
        
        return gradient
    }
    
    func gradientTopToBottom()->CAGradientLayer{
        gradient.colors = [colorTop,colorBottom]
        
        return gradient
    }
    
    func setGradientFrame(_ frame: CGRect){
        gradient.frame = frame
    }
}

/**
 *  UIView extension to ease creating Auto Layout Constraints
 */
extension UIView {
    
    
    // MARK: - Fill
    
    /**
     Creates and adds an array of NSLayoutConstraint objects that relates this view's top, leading, bottom and trailing to its superview, given an optional set of insets for each side.
     
     Default parameter values relate this view's top, leading, bottom and trailing to its superview with no insets.
     
     @note The constraints are also added to this view's superview for you
     
     :param: edges An amount insets to apply to the top, leading, bottom and trailing constraint. Default value is UIEdgeInsetsZero
     
     :returns: An array of 4 x NSLayoutConstraint objects (top, leading, bottom, trailing) if the superview exists otherwise an empty array
     */
    @discardableResult
    public func fillSuperView(_ edges: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        
        var constraints: [NSLayoutConstraint] = []
        
        if let superview = superview {
            
            let topConstraint = addTopConstraint(toView: superview, constant: edges.top)
            let leadingConstraint = addLeadingConstraint(toView: superview, constant: edges.left)
            let bottomConstraint = addBottomConstraint(toView: superview, constant: -edges.bottom)
            let trailingConstraint = addTrailingConstraint(toView: superview, constant: -edges.right)
            
            constraints = [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
        }
        
        return constraints
    }
    
    
    // MARK: - Leading / Trailing
    
    /**
     Creates and adds an `NSLayoutConstraint` that relates this view's leading edge to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's leading edge to be equal to the leading edge of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's leading edge to e.g. the other view's trailing edge. Default value is `NSLayoutAttribute.Leading`
     
     :param: relation  The relation of the constraint. Default value is `NSLayoutRelation.Equal`
     
     :param: constant  An amount by which to offset this view's left from the other view's specified edge. Default value is 0
     
     :returns: The created `NSLayoutConstraint` for this leading attribute relation
     */
    @discardableResult
    public func addLeadingConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .leading, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .leading, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    /**
     Creates and adds an `NSLayoutConstraint` that relates this view's trailing edge to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's trailing edge to be equal to the trailing edge of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's leading edge to e.g. the other view's trailing edge. Default value is `NSLayoutAttribute.Trailing`
     
     :param: relation  The relation of the constraint. Default value is `NSLayoutRelation.Equal`
     
     :param: constant  An amount by which to offset this view's left from the other view's specified edge. Default value is 0
     
     :returns: The created `NSLayoutConstraint` for this trailing attribute relation
     */
    @discardableResult
    public func addTrailingConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .trailing, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .trailing, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Left
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's left to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's left to be equal to the left of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's left side to e.g. the other view's right. Default value is NSLayoutAttribute.Left
     
     :param: relation  The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant  An amount by which to offset this view's left from the other view's specified edge. Default value is 0
     
     :returns: The created NSLayoutConstraint for this left attribute relation
     */
    @discardableResult
    public func addLeftConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .left, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .left, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Right
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's right to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's right to be equal to the right of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's right to e.g. the other view's left. Default value is NSLayoutAttribute.Right
     
     :param: relation  The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant  An amount by which to offset this view's right from the other view's specified edge. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this right attribute relation
     */
    @discardableResult
    public func addRightConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .right, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .right, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Top
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's top to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's right to be equal to the right of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's top to e.g. the other view's bottom. Default value is NSLayoutAttribute.Bottom
     
     :param: relation  The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant  An amount by which to offset this view's top from the other view's specified edge. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this top edge layout relation
     */
    @discardableResult
    public func addTopConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .top, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .top, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Bottom
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's bottom to some specified edge of another view, given a relation and offset.
     Default parameter values relate this view's right to be equal to the right of the other view.
     
     @note The new constraint is added to this view's superview for you
     
     :param: view      The other view to relate this view's layout to
     
     :param: attribute The other view's layout attribute to relate this view's bottom to e.g. the other view's top. Default value is NSLayoutAttribute.Botom
     
     :param: relation  The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant  An amount by which to offset this view's bottom from the other view's specified edge. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this bottom edge layout relation
     */
    @discardableResult
    public func addBottomConstraint(toView view: UIView?, attribute: NSLayoutAttribute = .bottom, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .bottom, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Center X
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's center X attribute to the center X attribute of another view, given a relation and offset.
     Default parameter values relate this view's center X to be equal to the center X of the other view.
     
     :param: view     The other view to relate this view's layout to
     
     :param: relation The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant An amount by which to offset this view's center X attribute from the other view's center X attribute. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this center X layout relation
     */
    @discardableResult
    public func addCenterXConstraint(toView view: UIView?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .centerX, toView: view, attribute: .centerX, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Center Y
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's center Y attribute to the center Y attribute of another view, given a relation and offset.
     Default parameter values relate this view's center Y to be equal to the center Y of the other view.
     
     :param: view     The other view to relate this view's layout to
     
     :param: relation The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant An amount by which to offset this view's center Y attribute from the other view's center Y attribute. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this center Y layout relation
     */
    @discardableResult
    public func addCenterYConstraint(toView view: UIView?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .centerY, toView: view, attribute: .centerY, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Width
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's width to the width of another view, given a relation and offset.
     Default parameter values relate this view's width to be equal to the width of the other view.
     
     :param: view     The other view to relate this view's layout to
     
     :param: relation The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant An amount by which to offset this view's width from the other view's width amount. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this width layout relation
     */
    @discardableResult
    public func addWidthConstraint(toView view: UIView?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .width, toView: view, attribute: .width, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Height
    
    /**
     Creates and adds an NSLayoutConstraint that relates this view's height to the height of another view, given a relation and offset.
     Default parameter values relate this view's height to be equal to the height of the other view.
     
     :param: view     The other view to relate this view's layout to
     
     :param: relation The relation of the constraint. Default value is NSLayoutRelation.Equal
     
     :param: constant An amount by which to offset this view's height from the other view's height amount. Default value is 0.0
     
     :returns: The created NSLayoutConstraint for this height layout relation
     */
    @discardableResult
    public func addHeightConstraint(toView view: UIView?, relation: NSLayoutRelation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        
        let constraint = createConstraint(attribute: .height, toView: view, attribute: .height, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        
        return constraint
    }
    
    
    // MARK: - Private
    
    /// Adds an NSLayoutConstraint to the superview
    fileprivate func addConstraintToSuperview(_ constraint: NSLayoutConstraint) {
        
        translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(constraint)
    }
    
    /// Creates an NSLayoutConstraint using its factory method given both views, attributes a relation and offset
    fileprivate func createConstraint(attribute attr1: NSLayoutAttribute, toView: UIView?, attribute attr2: NSLayoutAttribute, relation: NSLayoutRelation, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attr1,
            relatedBy: relation,
            toItem: toView,
            attribute: attr2,
            multiplier: 1.0,
            constant: constant)
        
        return constraint
    }
}
