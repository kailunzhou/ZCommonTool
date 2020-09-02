import Foundation
import UIKit

public extension UIStoryboard {
    class func createControllerWithName(_ name: String, identifier id: String) -> UIViewController {
       return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id)
    }
}

public extension UIWindow {
    /// 获取UIWindow的最上层控制器
    // fixme: 考虑如果presented的是UIAlertController时该如何处理
    var topMostVC: UIViewController? {
        guard var findVC = self.rootViewController else {
            return nil
        }
        
        while true {
            if let nav = findVC as? UINavigationController, let topVC = nav.topViewController {
                findVC = topVC
            } else if let tab = findVC as? UITabBarController, let selVC = tab.selectedViewController {
                findVC = selVC
            } else if let pre = findVC.presentedViewController{
                findVC = pre
            } else {
                break
            }
        }
        return findVC
    }
}

public extension UIAlertController {
    class func alertShow(_ vCtrl: UIViewController, _ title: String?, _ message: String?, _ cancelStr: String?, _ okStr: String?, cancelAction: @escaping ()->(), okAction: @escaping ()->()) {
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelStr != nil {
            alertCtrl.addAction(UIAlertAction(title: cancelStr, style: .cancel, handler: { (_) in
                cancelAction()
            }))
        }
        if okStr != nil {
            alertCtrl.addAction(UIAlertAction(title: okStr, style: .default, handler: { (_) in
                okAction()
            }))
        }
        vCtrl.present(alertCtrl, animated: true, completion: nil)
    }
}

public extension UIView {
    ///圆角
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.masksToBounds = (newValue > 0)
            layer.cornerRadius = newValue
        }
    }
    ///边线宽度
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    ///边线颜色
    @IBInspectable var borderColor: UIColor {
        get {
            return layer.borderUIColor
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
}

public extension CALayer {
    ///设置边线颜色
    var borderUIColor: UIColor {
        get {
            return UIColor(cgColor: self.borderColor!)
        } set {
            self.borderColor = newValue.cgColor
        }
    }
}

public extension CAGradientLayer {
    /*
    用法
    let newlayer = CAGradientLayer().gradientLayer("34D9A2", "1196A9", true)
    newlayer.frame = view.bounds
    view.layer.insertSublayer(newlayer, at: 0)
    */
    ///渐变色
    func gradientLayer(_ start: String, _ end: String, _ isV: Bool) -> CAGradientLayer {
        //定义渐变的颜色
        let gradientColors = [UIColor(hexString: start).cgColor,
                              UIColor(hexString: end).cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        self.locations = gradientLocations
        //设置渲染的起始结束位置
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = isV ? CGPoint(x: 0, y: 1.0) : CGPoint(x: 1.0, y: 0)
        return self
    }
}

public extension UIColor {
    convenience init(hexString: String) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "").replacingOccurrences(of: "0X", with: "")
        if let hexInt = Int(hexString, radix: 16) {
            let r = CGFloat((hexInt & 0xff0000) >> (4*4))
            let g = CGFloat((hexInt & 0x00ff00) >> (4*2))
            let b = CGFloat((hexInt & 0x0000ff) >> (4*0))
            
            self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        } else {
            self.init()
        }
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "").replacingOccurrences(of: "0X", with: "")
        if let hexInt = Int(hexString, radix: 16) {
            let r = CGFloat((hexInt & 0xff0000) >> (4*4))
            let g = CGFloat((hexInt & 0x00ff00) >> (4*2))
            let b = CGFloat((hexInt & 0x0000ff) >> (4*0))
            
            self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
        } else {
            self.init()
        }
    }
}

public extension UIImage {
    convenience init?(named: String, _ c: AnyClass) {
        self.init(named: named, in: Bundle(for: c), compatibleWith: nil)
    }
}

open class XHTextField: UITextField {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .none
        self.clearButtonMode = .whileEditing
        self.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        self.textColor = UIColor(hexString: "333333")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let clearBtn = self.value(forKey: "_clearButton") as? UIButton
        clearBtn?.setImage(UIImage(named: "textfield_clearbtn", XHTextField.self), for: .normal)
    }
    
    open override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        super.clearButtonRect(forBounds: bounds)
        return CGRect(x: self.bounds.size.width - 24.0, y: self.bounds.size.height * 0.5 - 12.0, width: 24.0, height: 24.0)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
