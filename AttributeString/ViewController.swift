//
//  ViewController.swift
//  AttributeString
//
//  Created by liguohuai on 2020/4/3.
//  Copyright © 2020 liguohuai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let str: AttributedString = "\("回忆", .weithtFont(20, .semibold), .color(.cyan), .stroke(.blue, 3))是抓不到的月光，\("握紧就变黑暗", .font(20), .color(.red), .paragraphStyle{$0.alignment(.center)}, .strike(.black, .double))，让\("虚假", .font(20), .kern(5), .obliqueness(-0.2), .color(.orange))的背影消失于\("晴朗", .font(20), .underline(.blue, .double))，阳光在\(image: UIImage(named: "Lock"), bounds: CGRect(x: 0, y: -20, width: 50, height: 50))身上流转，等所有业障被原谅"
        
        textLabel.attributedText  = str.attributedString
        
        let attr = NSMutableAttributedString()
        attr.add("回忆是抓不到的月光，")
            .add("握紧就变黑暗") {$0.font(20).color(.red)}
            .add("，让虚假的背影消失于晴朗，阳光在")
            .addImage("Lock", CGRect(x: 0, y: -20, width: 50, height: 50))
            .add("身上流转，等所有业障被原谅")
            .add {$0.color(.blue)}
        textLabel2.attributedText = attr
        
        let attrS = NSMutableAttributedString(string: "回忆是抓不到的月光，")
        let att1 = NSAttributedString(string: "握紧就变黑暗", attributes: [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.red ])
        attrS.append(att1)
        attrS.append(NSAttributedString(string: "，让虚假的背影消失于晴朗，阳光在"))
        let attch = NSTextAttachment()
        attch.image = UIImage(named: "Lock")
        attch.bounds = CGRect(x: 0, y: -20, width: 50, height: 50)
        attrS.append(NSAttributedString(attachment: attch))
        attrS.append(NSAttributedString(string: "身上流转，等所有业障被原谅"))
    }


}

