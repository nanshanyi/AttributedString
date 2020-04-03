//
//  NSMutableAttributedString+Extension.swift
//  AttributeString
//
//  Created by liguohuai on 2020/4/3.
//  Copyright © 2020 liguohuai. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    /// 添加字符串并为此段添加对应的Attribute
    /// - Parameters:
    ///   - text: 要添加的String
    ///   - arrtibutes: Attribute特征
    /// - Returns: self
    @discardableResult
    func add(_ text: String, arrtibutes: ((inout Attributes) -> ())? = nil) -> NSMutableAttributedString {
        var arrtibute = Attributes()
        arrtibutes?(&arrtibute)
        let arrStr = NSMutableAttributedString(string: text, attributes: arrtibute.attributes)
        append(arrStr)
        return self
    }
    
    
    /// 添加Attribute作用于当前整体字符串，如果不包含传入的attribute，则增加当前特征
    /// - Parameter arrtibutes: Attribute的DIc
    @discardableResult
    func add(arrtibutes: (inout Attributes) -> ()) -> NSMutableAttributedString {
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        var attribute = Attributes()
        arrtibutes(&attribute)
        enumerateAttributes(in: range, options: .reverse) { (oldAttribute, range, _) in
            var newAtt = oldAttribute
            attribute.attributes.forEach { (newkey, value) in
                if !oldAttribute.keys.contains(newkey) {
                    newAtt[newkey] = value
                }
            }
            addAttributes(newAtt, range: range)
        }
        return self
    }
    
    /// 为AttributeString添加图片
    /// - Parameters:
    ///   - name: 图片名字
    ///   - bounds: 图片的bounds
    /// - Returns: self
    @discardableResult
    func addImage(_ name: String, _ bounds: CGRect) -> NSMutableAttributedString {
        let attch = NSTextAttachment()
        attch.image = UIImage(named: name)
        attch.bounds = bounds
        let attchAttri = NSAttributedString(attachment: attch)
        append(attchAttri)
        return self
    }
    
    /// 为AttributeString添加图片
    /// - Parameters:
    ///   - image: 图片
    ///   - bounds: 图片的bounds
    /// - Returns: self
    @discardableResult
    func addImage(_ image: UIImage?, _ bounds: CGRect) -> NSMutableAttributedString {
        let attch = NSTextAttachment()
        attch.image = image
        attch.bounds = bounds
        let attchAttri = NSAttributedString(attachment: attch)
        append(attchAttri)
        return self
    }
    
}


class Attributes {
    fileprivate var attributes = [NSAttributedString.Key : Any]()
    private lazy var paragraphStyle : NSMutableParagraphStyle = {
        return NSMutableParagraphStyle()
    }()
    
    @discardableResult
    public func font(_ size: CGFloat) -> Attributes {
        attributes[.font] = UIFont.systemFont(ofSize: size)
        return self
    }
    
    @discardableResult
    public func boldFont(_ size: CGFloat) -> Attributes {
        attributes[.font] = UIFont.boldSystemFont(ofSize: size)
        return self
    }
    
    @discardableResult
    public func customFont(_ size: CGFloat, _ name: String) -> Attributes {
        attributes[.font] = UIFont(name: name, size: size)
        return self
    }
    
    @discardableResult
    public func weightFont(_ size: CGFloat, _ weight: UIFont.Weight) -> Attributes {
        attributes[.font] = UIFont.systemFont(ofSize: size, weight: weight)
        return self
    }
    
    @discardableResult
    public func color(_ color: UIColor) -> Attributes {
        attributes[.foregroundColor] = color
        return self
    }
    
    //斜体
    @discardableResult
    public func oblique(_ value: Double) -> Attributes {
        attributes[.obliqueness] = NSNumber(value: value)
        return self
    }
    
    //加粗
    @discardableResult
    public func expansion(_ value: Double) -> Attributes {
        attributes[.expansion] = NSNumber(value: value)
        return self
    }
    
    //字间距
    @discardableResult
    public func kern(_ value: Double) -> Attributes {
        attributes[.kern] = NSNumber(value: value)
        return self
    }
    //删除线，颜色
    @discardableResult
    public func strike(_ color: UIColor, _ style: NSUnderlineStyle) -> Attributes {
        return strikeStyle(style).strikeColor(color)
    }
    //删除线
    @discardableResult
    public func strikeStyle(_ style: NSUnderlineStyle) -> Attributes {
        attributes[.strikethroughStyle] = style.rawValue
        return self
    }
    
    //删除线颜色
    @discardableResult
    public func strikeColor(_ color: UIColor) -> Attributes {
        attributes[.strikethroughColor] = color
        return self
    }
    
    //下划线类型，颜色
    @discardableResult
    public func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> Attributes {
        return underlineStyle(style).underlineColor(color)
    }
    //删除线
    @discardableResult
    public func underlineStyle(_ style: NSUnderlineStyle) -> Attributes {
        attributes[.underlineStyle] = style.rawValue
        return self
    }
    
    //删除线颜色
    @discardableResult
    public func underlineColor(_ color: UIColor) -> Attributes {
        attributes[.underlineColor] = color
        return self
    }
    
    @discardableResult
    public func baselineOffset(_ offset: CGFloat) -> Attributes {
        attributes[.baselineOffset] = offset
        return self
    }
    
    //居中方式
    @discardableResult
    public func alignment(_ ali: NSTextAlignment) -> Attributes {
        paragraphStyle.alignment = ali
        attributes[.paragraphStyle] = paragraphStyle
        return self
    }
    //行间距
    @discardableResult
    public func lineSpacing(_ lineSpacing: CGFloat) -> Attributes {
        paragraphStyle.lineSpacing = lineSpacing
        attributes[.paragraphStyle] = paragraphStyle
        return self
    }
    //最小行高
    @discardableResult
    public func lineMinHeight(_ lineMinHeight: CGFloat) -> Attributes {
        paragraphStyle.minimumLineHeight = lineMinHeight
        attributes[.paragraphStyle] = paragraphStyle
        return self
    }
}
