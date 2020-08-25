import Foundation
import MJRefresh
import MBProgressHUD
import BRPickerView

//MARK: ------------- MJRefresh
public struct RefreshManager {
    static func header(_ refresh: (() -> Void)?) -> MJRefreshNormalHeader? {
        let mj_header = MJRefreshNormalHeader {
            refresh?()
        }
        mj_header.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        mj_header.stateLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        mj_header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        mj_header.lastUpdatedTimeLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return mj_header
    }
    
    static func footer(_ refresh: (() -> Void)?) -> MJRefreshAutoNormalFooter? {
        let mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            refresh?()
        })
        mj_footer.setTitle("没有更多了", for: .noMoreData)
        mj_footer.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        mj_footer.stateLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return mj_footer
    }
}

//MARK: ------------- MBProgressHUD
public extension MBProgressHUD {
    static func rootView(_ view: UIView?) -> UIView {
        if let views = view {
            return views
        } else {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
            } else {
                return UIApplication.shared.keyWindow!
            }
        }
    }
    
    static func showLoading(_ view: UIView?, with title: String?) {
        let hud = MBProgressHUD.showAdded(to: rootView(view), animated: true)
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        hud.removeFromSuperViewOnHide = true
        if let text = title {
            hud.label.text = text
            hud.label.font = UIFont.systemFont(ofSize: 13)
        }
    }
    
    static func dismisHUD(_ view: UIView?) {
        MBProgressHUD.forView(rootView(view))?.hide(animated: true)
    }
    
    static func showMessage(_ view: UIView?,
                            with title: String,
                            complete handler: (() -> Void)?) {
        let hud = MBProgressHUD.showAdded(to: rootView(view), animated: true)
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.label.text = title
        hud.label.font = UIFont.systemFont(ofSize: 13)
        //hud.margin = 10
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            dismisHUD(view)
            handler?()
        }
    }
    
    private static func showHUD(_ view: UIView?,
                                with icon: UIImage?,
                                to title: String?,
                                complete handler: (() -> Void)?) {
        let hud = MBProgressHUD.showAdded(to: rootView(view), animated: true)
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        hud.removeFromSuperViewOnHide = true
        hud.mode = .customView
        let iconImgv = UIImageView(image: icon)
        hud.customView = iconImgv
        if let text = title {
            hud.label.text = text
            hud.label.numberOfLines = 0
            hud.label.font = UIFont.systemFont(ofSize: 13)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            dismisHUD(view)
            handler?()
        }
    }
    
    static func showSuccess(_ view: UIView?,
                            with title: String?,
                            complete handler: (() -> Void)?) {
        showHUD(view, with: UIImage(named: "state_right"), to: title, complete: handler)
    }
    
    static func showFailure(_ view: UIView?,
                            with title: String?,
                            complete handler: (() -> Void)?) {
        showHUD(view, with: UIImage(named: "state_cancel"), to: title, complete: handler)
    }
}

//MARK: ------------- BRPickerView
public extension BRStringPickerView {
    static func show(_ title: String, _ list: [String]?, _ defaultStr: String?, _ select: Int?, _ isAuto: Bool, _ resultBlock: @escaping (_ index: Int?, _ value: String?)->()) {
        guard let lists = list else {return}
        var defaultselect = lists.count - 1
        if let selects = select, selects < lists.count {
            defaultselect = selects
        } else {
            if let defaultStrs = defaultStr, let strIndex = lists.firstIndex(of: defaultStrs) {
                defaultselect = strIndex
            }
        }
        BRStringPickerView.showPicker(withTitle: title, dataSourceArr: list, select: defaultselect, isAutoSelect: isAuto) { (result) in
            resultBlock(result?.index, result?.value)
        }
    }
}

public extension BRDatePickerView {
    static func show(_ title: String, _ type: BRDatePickerMode, _ suffix: String?, _ defaultStr: String?, _ min: Date?, _ max: Date?, _ isAuto: Bool, _ resultBlock: @escaping (_ date: Date?, _ value: String?)->()) {
        BRDatePickerView.showDatePicker(with: type, title: title, selectValue: defaultStr, minDate: min, maxDate: max, isAutoSelect: isAuto) { (date, value) in
            if let suffixs = suffix, let selectvalue = value {
                var selectdate: Date?
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                selectdate = format.date(from: selectvalue + suffixs)
                resultBlock(selectdate, selectvalue)
            } else {
                resultBlock(date, value)
            }
        }
    }
}
