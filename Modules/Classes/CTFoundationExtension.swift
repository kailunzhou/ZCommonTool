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

public extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        return self.substring(from: start, to: to)
    }
}
