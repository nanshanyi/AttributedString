# AttributedString
###在Swift中方便的创建特征字符串<br>
使用方式

```
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
```