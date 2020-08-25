import UIKit
import Foundation
///屏幕宽
public let ScreenW = UIScreen.main.bounds.size.width
///屏幕高
public let ScreenH = UIScreen.main.bounds.size.height
///状态栏高
public let NaviBarH: CGFloat = {//UIApplication.shared.statusBarFrame.height
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.delegate?.window, let windows = window, windows.safeAreaInsets.left > 0 || windows.safeAreaInsets.bottom > 0 {
            return 44.0
        }
    }
    return 20.0
}()
///导航栏高度
public let NaviH: CGFloat = {
    return NaviBarH + 44.0
}()
///底部安全高度
public let BottomSafeH: CGFloat = {
    return NaviBarH == 20.0 ? 0 : 34.0
}()
///底部抽屉栏高度
public let TabbarH: CGFloat = {
    return NaviBarH == 20.0 ? 49.0 : (49.0 + 34.0)
}()
