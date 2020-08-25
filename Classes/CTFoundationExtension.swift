import Foundation

///将字典转换成字符串展示，可用于网络请求中展示请求数据和返回数据
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var showJsonString: String {
        do {
            var dic: [String: Any] = [String: Any]()
            for (key, value) in self {
                dic["\(key)"] = value
            }
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)

            if let data = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? {
                return data
            } else {
                return "{}"
            }
        } catch {
            return "{}"
        }
    }
}
///通知扩展
public extension NotificationCenter {
    static func addNotification(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?) {
        self.default.addObserver(observer, selector: aSelector, name: aName, object: nil)
    }
    static func removeNotification(_ observer: Any, name aName: NSNotification.Name? = nil) {
        if aName != nil {
            self.default.removeObserver(self, name: aName, object: nil)
        } else{
            self.default.removeObserver(self)
        }
    }
    static func postNotification(name: NSNotification.Name, userInfo: [AnyHashable : Any]?) {
        self.default.post(name: name, object: nil, userInfo: userInfo)
    }
}
