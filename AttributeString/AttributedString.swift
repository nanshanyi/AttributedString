//
//  AttributedString.swift
//  AttributedString
//
//  Created by liguohuai on 2020/4/3.
//  Copyright © 2020 liguohuai. All rights reserved.
//

import Foundation
import UIKit

struct AttributedString: CustomStringConvertible {
    let attributedString: NSAttributedString
    init(stringLiteral: String) {
        attributedString = NSMutableAttributedString(string: stringLiteral)
    }
    var description: String {
        return String(describing: attributedString)
    }
}


//MARK: - ExpressibleByStringInterpolation
extension AttributedString: ExpressibleByStringInterpolation {
    init(stringInterpolation: StringInterpolation) {
        self.attributedString = NSAttributedString(attributedString: stringInterpolation.attributedString)
    }
    
    struct StringInterpolation: StringInterpolationProtocol {
        var attributedString: NSMutableAttributedString
        
        init(literalCapacity: Int, interpolationCount: Int) {
            self.attributedString = NSMutableAttributedString()
        }
        
        func appendLiteral(_ literal: String) {
            let astr = NSAttributedString(string: literal)
            attributedString.append(astr)
        }
        
        func appendLiteral(_ literal: AttributedString) {
            attributedString.append(literal.attributedString)
        }
    }
}

//MARK: - appendInterpolation
extension AttributedString.StringInterpolation {
    
    func appendInterpolation(_ string: String, _ styles: AttributedString.Style...) {
        var attr = [NSAttributedString.Key : Any]()
        styles.forEach { attr.merge($0.attributes, uniquingKeysWith: {$1})}
        let astr = NSAttributedString(string: string, attributes: attr)
        self.attributedString.append(astr)
    }
    
//    func appendInterpolation(_ string: String, _ style: AttributeStyle) {
//        let astr = NSAttributedString(string: string, attributes: style.attributes)
//        self.attributedString.append(astr)
//    }

    func appendInterpolation(image: UIImage, bounds: CGRect) {
        let attch = NSTextAttachment()
        attch.image = image
        attch.bounds = bounds
        let attchAttri = NSAttributedString(attachment: attch)
        self.attributedString.append(attchAttri)
    }
}

//MARK: - Style
extension AttributedString {
    struct Style {
        fileprivate let attributes: [NSAttributedString.Key: Any]
        
        /// 增加ParagraphStyle
        /// - Parameter paragraphStyle: NSParagraphStyle
        /// - Returns:Style
        static func paragraphStyle(_ paragraphStyle: NSParagraphStyle) ->Style {
            return Style(attributes: [.paragraphStyle: paragraphStyle])
        }
        
        /// 增加ParagraphStyle支持，建议使用尾随闭包方式，直接跟paragraphStyle{$0. }
        /// - Parameter paragraph: paragraphClosure
        /// - Returns: Style
        static func paragraphStyle(_ paragraph: (inout NSMutableParagraphStyle) -> ()) ->Style {
            var pStyle = NSMutableParagraphStyle()
            paragraph(&pStyle)
            return Style(attributes: [.paragraphStyle: pStyle])
        }
        
        static func font(_ size: CGFloat) -> Style {
            return Style(attributes: [.font: UIFont.systemFont(ofSize: size)])
        }
        
        static func weithtFont(_ size: CGFloat, _ weight: UIFont.Weight) -> Style {
            return Style(attributes: [.font: UIFont.systemFont(ofSize: size, weight: weight)])
        }
        
        static func customFont(_ size: CGFloat, name: String) -> Style {
            guard let font = UIFont(name: name, size: size) else { return Style(attributes: [:]) }
            return Style(attributes: [.font: font])
        }
        
        static func color(_ color: UIColor) -> Style {
            return Style(attributes: [.foregroundColor: color])
        }
        
        static func backgroundColor(_ color: UIColor) -> Style {
            return Style(attributes: [.backgroundColor: color])
        }
        
        static func kern(_ kern: Float) -> Style {
            return Style(attributes: [.kern: kern])
        }
        
        static func stroke(_ color: UIColor, _ width: Float) -> Style {
            return Style(attributes: [.strokeColor: color, .strokeWidth: width])
        }
        
        static func strokeColor(_ color: UIColor) -> Style {
            return Style(attributes: [.strokeColor: color])
        }
        
        static func strokeWidth(_ width: Float) -> Style {
            return Style(attributes: [ .strokeWidth: width])
        }
        
        //删除线，颜色
        static func strike(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
            return Style(attributes:[.strikethroughColor: color, .strikethroughStyle: style.rawValue])
        }
        
        //删除线
        static func strikeStyle(_ style: NSUnderlineStyle) -> Style {
            return Style(attributes: [.strikethroughStyle: style.rawValue])
        }
        
        //删除线颜色
        static func strikeColor(_ color: UIColor) -> Style {
            return Style(attributes: [.strikethroughColor: color])
        }
        
        static func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
            return Style(attributes: [.underlineColor: color, .underlineStyle: style.rawValue])
        }
        
        static func underlineColor(_ color: UIColor) -> Style{
            return Style(attributes: [.underlineColor: color])
        }
        
        static func underlineStyle(_ style: NSUnderlineStyle) -> Style{
            return Style(attributes: [.underlineStyle: style])
        }
        
        static func link(_ link: String) -> Style {
            return .link(URL(string: link))
        }
        
        static func link(_ link: URL?) -> Style {
            guard let linkUrl = link else { return Style(attributes: [:]) }
            return Style(attributes: [.link: linkUrl])
        }
        
        static func obliqueness(_ obl: CGFloat) -> Style {
            return Style(attributes: [.obliqueness: obl])
        }
    }
    
}
//MARK: - NSMutableParagraphStyle 如有需要可自行扩展
extension NSMutableParagraphStyle {
        @discardableResult
        public func alignment(_ ali: NSTextAlignment) -> NSMutableParagraphStyle {
            alignment = ali
            return self
        }
    
        @discardableResult
        public func lineSpacing(_ lineSp: CGFloat) -> NSMutableParagraphStyle {
            lineSpacing = lineSp
            return self
        }
    
        @discardableResult
        public func lineMinHeight(_ lineMinHeight: CGFloat) -> NSMutableParagraphStyle {
            minimumLineHeight = lineMinHeight
            return self
        }
}

//class AttributeStyle {
//    fileprivate var attributes: [NSAttributedString.Key: Any] = [:]
//    private lazy var paragraphStyle : NSMutableParagraphStyle = {
//        let ps = NSMutableParagraphStyle()
//        return ps
//    }()
//
//    @discardableResult
//    public func font(_ size: CGFloat) -> AttributeStyle {
//        attributes[.font] = UIFont.systemFont(ofSize: size)
//        return self
//    }
//
//    @discardableResult
//    public func weightFont(_ size: CGFloat, _ weight: UIFont.Weight) -> AttributeStyle {
//        attributes[.font] = UIFont.systemFont(ofSize: size, weight: weight)
//        return self
//    }
//
//    @discardableResult
//    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> AttributeStyle {
//        attributes[.paragraphStyle] = paragraphStyle
//        return self
//    }
//
//    @discardableResult
//    public func color(_ color: UIColor) -> AttributeStyle {
//        attributes[.foregroundColor] = color
//        return self
//    }
//
//    @discardableResult
//    public func bgColor(_ color: UIColor) -> AttributeStyle {
//        attributes[.backgroundColor] = color
//        return self
//    }
//
//    @discardableResult
//    public func kern(_ kern: Float) -> AttributeStyle {
//        attributes[.kern] = kern
//        return self
//    }
//
//    @discardableResult
//    public func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> AttributeStyle {
//        underlineColor(color)
//        underlineStyle(style)
//        return self
//    }
//
//    @discardableResult
//    public func underlineColor(_ color: UIColor) -> AttributeStyle{
//        attributes[.underlineColor] = color
//        return self
//    }
//
//    @discardableResult
//    public func underlineStyle(_ style: NSUnderlineStyle) -> AttributeStyle{
//        attributes[.underlineStyle] = style
//        return self
//    }
//
//    @discardableResult
//    public func link(_ link: String) -> AttributeStyle {
//        self.link(URL(string: link))
//        return self
//    }
//
//    @discardableResult
//    public func link(_ link: URL?) -> AttributeStyle {
//        guard let linkUrl = link else { return self }
//        attributes[.link] = linkUrl;
//        return self
//    }
//
//    @discardableResult
//    public func alignment(_ ali: NSTextAlignment) -> AttributeStyle {
//        paragraphStyle.alignment = ali
//        attributes[.paragraphStyle] = paragraphStyle
//        return self
//    }
//
//    @discardableResult
//    public func lineSpacing(_ lineSpacing: CGFloat) -> AttributeStyle {
//        paragraphStyle.lineSpacing = lineSpacing
//        paragraphStyle(paragraphStyle)
//        return self
//    }
//
//    @discardableResult
//    public func lineMinHeight(_ lineMinHeight: CGFloat) -> AttributeStyle {
//        paragraphStyle.minimumLineHeight = lineMinHeight
//        paragraphStyle(paragraphStyle)
//        return self
//    }
//
//}
