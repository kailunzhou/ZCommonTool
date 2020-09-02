import UIKit

open class CTBaseCtrl: UIViewController {
    lazy open var CTBackBtn: UIBarButtonItem = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        btn.setImage(UIImage(named: "naviback_arrowblack", CTBaseCtrl.self), for: .normal)
        btn.addTarget(self, action: #selector(CTBackClick(_:)), for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 0, right: 0)
        return UIBarButtonItem(customView: btn)
    }()
    
    lazy open var CTWhiteBackBtn: UIBarButtonItem = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        btn.setImage(UIImage(named: "naviback_arrowwhite", CTBaseCtrl.self), for: .normal)
        btn.addTarget(self, action: #selector(CTBackClick(_:)), for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 0, right: 0)
        return UIBarButtonItem(customView: btn)
    }()
    
    @objc open func CTBackClick(_ sender: UIButton) {
        if self.navigationController?.viewControllers.first == self,
            let _ = self.presentationController{
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "F5F5FA")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexString: "333333"), .font: UIFont.systemFont(ofSize: 17)]
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    deinit{
    }
}
