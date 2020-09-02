import UIKit
import WebKit

open class CTPureH5Ctrl: UIViewController {
    lazy private var progressView: UIProgressView = {
        let view = UIProgressView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 2))
        view.tintColor = UIColor(hexString: "F95F10")//进度条颜色
        view.trackTintColor = UIColor.white//进度条背景色
        return view
    }()
    lazy private var goBackBtn: UIBarButtonItem = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        btn.setImage(UIImage(named: "other_arrow_left", CTPureH5Ctrl.self), for: .normal)
        btn.addTarget(self, action: #selector(backClick(_:)), for: .touchUpInside)
        btn.contentHorizontalAlignment = .left
        btn.tag = 1000
        return UIBarButtonItem(customView: btn)
    }()
    lazy private var cancelBtn: UIBarButtonItem = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        btn.setImage(UIImage(named: "other_cancel", CTPureH5Ctrl.self), for: .normal)
        btn.addTarget(self, action: #selector(backClick(_:)), for: .touchUpInside)
        btn.contentHorizontalAlignment = .left
        btn.tag = 1001
        return UIBarButtonItem(customView: btn)
    }()
    private let webView = WKWebView()
    private let estimatedProgressKeyPath = "estimatedProgress"
    private let titleKeyPath = "title"
    
    public var geturl: String = ""
    public var titletext: String = ""
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexString: "333333"), .font: UIFont.systemFont(ofSize: 17)]
    }
    
    private func buildUI() {
        title = titletext
        navigationItem.leftBarButtonItems = [goBackBtn, cancelBtn]
        
        webView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - NaviH - BottomSafeH)
        webView.backgroundColor = UIColor.white
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        
        view.addSubview(progressView)
        webView.addObserver(self, forKeyPath: estimatedProgressKeyPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: titleKeyPath, options: .new, context: nil)
        
        guard let url = URL(string: geturl) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    @objc private func backClick(_ sender: UIButton) {
        if sender.tag == 1000 {//webView.canGoBack == true
            webView.goBack()
        } else {
            if !((self.navigationController?.popViewController(animated: true)) != nil) {
                self.view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let theKeyPath = keyPath, object as? WKWebView == webView else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        if theKeyPath == estimatedProgressKeyPath {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        } else if theKeyPath == titleKeyPath {
            if titletext.count <= 0 {
                title = webView.title
            }
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: estimatedProgressKeyPath, context: nil)
    }
}

/*
d*##$.
zP"""""$e.           $"    $o
4$       '$          $"      $
'$        '$        J$       $F
'b        $k       $>       $
$k        $r     J$       d$
'$         $     $"       $~
'$        "$   '$E       $
$         $L   $"      $F ...
$.       4B   $      $$$*"""*b
'$        $.  $$     $$      $F
"$       R$  $F     $"      $
$k      ?$ u*     dF      .$
^$.      $$"     z$      u$$$$e
#$b             $E.dW@e$"    ?$
#$           .o$$# d$$$$c    ?F
$      .d$$#" . zo$>   #$r .uF
$L .u$*"      $&$$$k   .$$d$$F
$$"            ""^"$$$P"$P9$
JP              .o$$$$u:$P $$
$          ..ue$"      ""  $"
d$          $F              $
$$     ....udE             4B
#$    """"` $r            @$
^$L        '$            $F
RN        4N           $
*$b                  d$
$$k                 $F
$$b                $F
$""               $F
'$                $
$L               $
'$               $
$               $
*/
