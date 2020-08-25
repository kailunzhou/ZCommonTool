import Foundation

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
