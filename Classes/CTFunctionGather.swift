import Foundation
import UIKit

///打印报文
public func delog(filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "      " + "/\(rowCount)行" + "\n")
    #endif
}
///打印报文
public func delog<T>(_ message: T, filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "      " + "/\(rowCount)行" + "      \(message)" + "\n")
    #endif
}
///判断是否代理
public func CTProxyStatus() -> Bool {
    let dic = CFNetworkCopySystemProxySettings()!.takeUnretainedValue()
    let arr = CFNetworkCopyProxiesForURL(URL(string: "https://www.baidu.com")! as CFURL, dic).takeUnretainedValue()
    let obj = (arr as [AnyObject])[0]
//    let host = obj.object(forKey: kCFProxyHostNameKey) ?? "null"
//    let port = obj.object(forKey: kCFProxyPortNumberKey) ?? "null"
//    let type = obj.object(forKey: kCFProxyTypeKey) ?? "null"
//    delog("host = \(host)\nport = \(port)\ntype = \(type)")
    if obj.object(forKey: kCFProxyTypeKey) == kCFProxyTypeNone {
        return false//没有设置代理
    }else {
        return true//设置代理了
    }
}
///获取固定宽度（高度）的标签在指定的文本下需要多少高度（宽度）
public func getWidthOrHeight(_ str: String?, _ font: UIFont, _ isW: Bool, _ length: CGFloat) -> CGFloat {
    let size: CGSize = isW ? CGSize(width: length, height: CGFloat(MAXFLOAT)) : CGSize(width: CGFloat(MAXFLOAT), height: length)
    let text: NSString = NSString(string: (str ?? ""))
    let rect: CGRect = text.boundingRect(with: size, options: [.usesFontLeading, .truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [.font : font], context: nil)
    return isW ? rect.size.height : rect.size.width
}
///获取固定宽度（高度）的标签在指定的文本下需要多少高度（宽度）
public func getWOrH(_ str: String?, _ font: UIFont, _ isW: Bool, _ length: CGFloat) -> CGFloat {
    let label = UILabel()
    label.text = str
    label.font = font
    label.numberOfLines = 0
    let zeroRect: CGRect = isW ? CGRect(x: 0, y: 0, width: length, height: CGFloat(MAXFLOAT)) : CGRect(x: 0, y: 0, width: CGFloat(MAXFLOAT), height: length)
    let rect: CGRect = label.textRect(forBounds: zeroRect, limitedToNumberOfLines: 0)
    return isW ? rect.size.height : rect.size.width
}
