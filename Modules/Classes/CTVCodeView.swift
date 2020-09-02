import UIKit

open class CTVCodeView: UIView {
    public var inputFinishAction: ((_ inputCode: String)->())?
    
    public var numberColor = UIColor.white {
        didSet {
            if labels.count > 0 {
                for i in 0 ..< labels.count {
                    let label = labels[i]
                    label.textColor = numberColor
                }
            }
        }
    }
    public var lineColor = UIColor.white {
        didSet {
            if lines.count > 0 {
                for i in 0 ..< lines.count {
                    let line = lines[i]
                    line.backgroundColor = lineColor
                }
            }
        }
    }
    public var selectLineColor = UIColor.white
    
    public var code: String? {
        get {
            return self.textField.text
        }
    }
    
    fileprivate var item_count: Int
    fileprivate var item_margin: CGFloat
    fileprivate var textField: UITextField
    fileprivate var mask_view: UIControl
    fileprivate var labels: [UILabel]
    fileprivate var lines: [CTVCodeLineView]
    
    fileprivate var tempStr: String? = nil
    
    public init(count: Int, margin: CGFloat) {
        self.item_count = count
        self.item_margin = margin
        self.textField = UITextField()
        self.mask_view = UIButton()
        self.labels = [UILabel]()
        self.lines = [CTVCodeLineView]()
        
        super.init(frame: .zero)
        
        self.defaultConfig()
    }
    
    public func removeAllValue() {
        textField.text = nil
        /// 清空文字 -
        for i in 0..<item_count {
            let label = labels[i]
            label.text = nil
        }
    }
    
    fileprivate func defaultConfig() {
        backgroundColor = UIColor.clear
        textField.tintColor = UIColor.clear
        textField.textColor = UIColor.clear
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(self.tfChanged(tf:)), for: .editingChanged)
        addSubview(textField)
        
        // 小技巧：这个属性为true，可以强制使用系统的数字键盘，缺点是重新输入时，会清空之前的内容
        // clearsOnBeginEditing 属性并不适用于 secureTextEntry = true 时
        // textField.secureTextEntry = true
        
        // 小技巧：通过textField上层覆盖一个maskView，可以去掉textField的长按事件
        mask_view.backgroundColor = UIColor.clear
        mask_view.addTarget(self, action: #selector(self.clickMaskView), for: .touchUpInside)
        addSubview(mask_view)
        
        for i in 0..<item_count {
            // add label
            let label = UILabel()
            label.tag = i
            label.textAlignment = .center
            label.textColor = numberColor
            label.font = UIFont(name: "PingFangSC-Regular", size: 30.0)
            addSubview(label)
            labels.append(label)
            
            // add line
            let line = CTVCodeLineView()
            line.backgroundColor = lineColor
            addSubview(line)
            lines.append(line)
        }
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if labels.count != item_count {
            return
        }
        let all_width:CGFloat = bounds.size.width - item_margin * CGFloat(item_count-1)
        let per_width:CGFloat = all_width / CGFloat(item_count)
        var x:CGFloat = 0
        
        for i in 0..<labels.count {
            x = CGFloat(i) * (per_width + item_margin)
            // label 位置
            let label = labels[i]
            label.frame = CGRect(x: x, y: 0, width: per_width, height: bounds.size.height)
            
            // line 位置
            let line = lines[i]
            line.frame = CGRect(x: x, y: bounds.size.height - 1, width: per_width, height: 1)
        }
        
        textField.frame = bounds
        mask_view.frame = bounds
        
    }
    
    @objc fileprivate func tfChanged(tf: UITextField) {
        let selectedRange = tf.markedTextRange
        if selectedRange == nil {
            print("selectedRange is nil")
        }else if selectedRange!.isEmpty {
            print("selectedRange is empty")
        }
        if selectedRange == nil || selectedRange!.isEmpty {

            if let text = tf.text {
                
                // 去掉长度过多部分
                if text.count > item_count {
                    tf.text = text.substring(to: item_count)
                }
                
                // 样式 - 每个label, line
                for i in 0..<item_count {
                    let label = labels[i]
                    let line = lines[i]
                    
                    if i < text.count {
                        label.text = text.substring(from: i, length: 1)
                        line.backgroundColor = selectLineColor
                    } else {
                        label.text = nil
                        line.backgroundColor = lineColor
                    }
                }
                
                // 记录临时
                tempStr = text
                
                //输入完毕, 隐藏键盘
                if text.count >= item_count {
                    textField.resignFirstResponder()
                    inputFinishAction?(tf.text!)
                }
            } else {
                /// 没有文字 -
                for i in 0..<item_count {
                    let label = labels[i]
                    label.text = nil
                }
            }
        }
    }
    
    @objc fileprivate func clickMaskView() {
        textField.becomeFirstResponder()
    }
    
    fileprivate func animation(label: UILabel?) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.15
        animation.repeatCount = 1
        animation.fromValue = 0.1
        animation.toValue = 1
        label?.layer.add(animation, forKey: "zoom")
    }
    
    open override func endEditing(_ force: Bool) -> Bool {
        textField.endEditing(force)
        return super.endEditing(force)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CTVCodeLineView: UIView {
    public var color_view: UIView
    
    public func animation() {
        color_view.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.duration = 0.18
        animation.repeatCount = 1
        animation.fromValue = 1.0
        animation.toValue = 0.1
        color_view.layer.add(animation, forKey: "zoom.scale.x")
    }
    
    override init(frame: CGRect) {
        color_view = UIView()
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        addSubview(color_view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        color_view.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
