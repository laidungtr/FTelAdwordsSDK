//
//  AdwordsView.swift
//  FptAdwords
//
//  Created by ttiamap on 6/1/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import UIKit
import AVFoundation

public protocol AdwordsViewDelegate {
   func adwords_didRemoveFromView()
}

public enum AdwordsPartner: String{
    case nokia = "http://d4.adsplay.net/get?uuid={uuid}&placement={placementId}&adtype={adtype}"
    
    func makeUri(_placementType: AdwordsPlacementType, _adType: AdwordsType) -> String{
        
        var _string = self.rawValue.replacingOccurrences(of: "{uuid}", with: Utils.getDeviceId())
        _string = _string.replacingOccurrences(of: "{placementId}", with: _placementType.rawValue)
        _string = _string.replacingOccurrences(of: "{adtype}", with: _adType.rawValue)
        
        return _string
    }
}

public enum AdwordsPlacementType: String{
    case WorldCup = "314"
    case ChampionsLeague = "316"
}

public enum AdwordsType: String{
    case nokiaVideo = "11"
}

public class AdwordsView: UIView {
    
    private var myWebView: UIWebView?
    private var btnCancelAdwords: UIButton?

    public var imageCancelButton: UIImage? = nil {
        didSet{
            self.setBtnCancelImage()
        }
    }
    
    public var fontCancelButton: UIFont =  UIFont.systemFont(ofSize: 12.0){
        didSet{
            self.btnCancelAdwords?.titleLabel?.font = self.fontCancelButton
        }
    }
    
    public var hiddenCancelButton : Bool = false {
        didSet{
            self.btnCancelAdwords?.isHidden = self.hiddenCancelButton
        }
    }
    public var delegate: AdwordsViewDelegate?

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.addNotification()
    }
    
    init() {
        super.init(frame: CGRect())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addNotification()
    }
    
    //MARK: - Setup
    private func setupWebView(){
        
        if self.myWebView == nil {
            self.myWebView = UIWebView.init()
        }
        
        if self.btnCancelAdwords == nil {
            self.btnCancelAdwords = UIButton.init()

            self.btnCancelAdwords?.isUserInteractionEnabled = true
            self.btnCancelAdwords?.addTarget(self, action: #selector(self.adwordsRemove), for: .touchUpInside)
            self.btnCancelAdwords?.setTitleColor(UIColor.white, for: .normal)
            self.btnCancelAdwords?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
        
        self.addSubview(self.myWebView!)
        self.bringSubview(toFront: self.myWebView!)
        
        self.addSubview(self.btnCancelAdwords!)
        self.bringSubview(toFront: self.btnCancelAdwords!)
        
        self.setBtnCancelImage()

        self.btnCancelAdwords?.addTrailingConstraint(toView: self)
        self.btnCancelAdwords?.addTopConstraint(toView: self)
        self.btnCancelAdwords?.addHeightConstraint(toView: nil, relation: .equal, constant: 30.0)
        self.btnCancelAdwords?.addWidthConstraint(toView: nil, relation: .equal, constant: 62.0)
        
        // addconstraint
        self.myWebView!.addLeadingConstraint(toView: self)
        self.myWebView!.addTrailingConstraint(toView: self)
        self.myWebView!.addTopConstraint(toView: self)
        self.myWebView!.addBottomConstraint(toView: self)

        self.myWebView!.delegate = self
        self.myWebView!.allowsInlineMediaPlayback = true
        self.myWebView!.mediaPlaybackRequiresUserAction = false
        
        self.layoutIfNeeded()
    }
    
    private func setBtnCancelImage(){
        if self.imageCancelButton != nil {
            self.btnCancelAdwords?.setTitle("", for: .normal)
            self.btnCancelAdwords?.setImage(self.imageCancelButton, for: .normal)
        }else{
            self.btnCancelAdwords?.titleLabel?.font = self.fontCancelButton
            self.btnCancelAdwords?.setTitle("Bỏ qua", for: .normal)
        }
    }
    
    private func releaseWebView(){
        self.myWebView?.loadRequest(URLRequest.init(url: URL.init(string: "about:blank")!))
        self.myWebView?.reload()
        
        self.myWebView?.delegate = nil
        self.myWebView?.removeFromSuperview()
        self.myWebView = nil
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self,selector: #selector(self.videoDidEnd),name:
            Notification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
    }
    
    //MARK: - handler
    @objc private func videoDidEnd(){
        print("adwords video did end")
        self.adwordsRemove()
    }
    
    func adwordsRemove(){
        self.btnCancelAdwords?.removeFromSuperview()
        self.btnCancelAdwords = nil
        
        self.releaseWebView()
        self.delegate?.adwords_didRemoveFromView()
    }
    
    
    // MARK: - methods
    public func showAdwordsWith(partner: AdwordsPartner, _placementType: AdwordsPlacementType, _adtype: AdwordsType){
        
        self.setupWebView()
        
        let requestUrlString = partner.makeUri(_placementType: _placementType, _adType: _adtype)
        guard let url = NSURL(string: requestUrlString) else {
            return
        }
        let request = NSMutableURLRequest.init(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 3600)
        self.myWebView?.loadRequest(request as URLRequest)
    }
}

extension AdwordsView: UIWebViewDelegate{
    
}
