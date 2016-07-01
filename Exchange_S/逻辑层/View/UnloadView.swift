//
//  UnloadView.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

/// 未登录状态下的视图
import UIKit



protocol UnloadViewDelegate:NSObjectProtocol {
    
    func loginClick();
    func registerClick();
    
}



//不同类型的未登录状态
public enum UnloadViewType : Int {
    
    case profileUnload
    case MessageUnload
    case DiscoverUnload

}

class UnloadView: UIView {

    //MARK:--------定义成员变量-------
    var unloadType:UnloadViewType?
    
    weak var delegate:UnloadViewDelegate?
    
    //MARK:--------父类方法--------
    
   override init(frame: CGRect) {
    
        super.init(frame: frame)
    
        //1.添加子控件
        addSubview(iconView)
        addSubview(maskBGView)
        addSubview(homeIcon)
        addSubview(messageLabel)
        addSubview(loginbutton)
        addSubview(registerButton)
    
        //布局子控件
    
        //设置背景和小房子
        constrain(iconView,homeIcon) { (iconView,homeIcon) in
            
            iconView.center == iconView.superview!.center
            homeIcon.center == homeIcon.superview!.center
        }
        //设置文本
        constrain(messageLabel,iconView){ (messageLabel,iconView) in
            messageLabel.top == iconView.bottom
            messageLabel.centerX == iconView.centerX
            messageLabel.width == 224
        }
        //设置按钮
        constrain(registerButton,loginbutton, messageLabel) { (registerButton, loginbutton, messageLabel) in
            registerButton.size == loginbutton.size
            loginbutton.edges == inset(messageLabel.edges, 60,0,0,120)
            registerButton.edges == inset(messageLabel.edges, 60,120,0,0)
        }
        //设置蒙版平铺
        constrain(maskBGView) { (maskBGView) in
            maskBGView.size == maskBGView.superview!.size
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        //如果通过xib/storyboard创建该类,那么就会崩溃
        fatalError("init(code:) has not been implemented")
    }
    
    //MARK:--------自定义方法-------
    
    func loginClick()  {
        
        delegate?.loginClick()

    }
    func registerClick()  {
        delegate?.registerClick()
    }
    
    //动画
    private func startAnimation(){
    
        //1.创建动画
        let anim = CABasicAnimation (keyPath: "transform.rotation")
        //2.设置动画
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        
        //如果为true那么动画执行完成之后就会被移除
        anim.removedOnCompletion = false
        
        //3.将动画添加到图层上
        iconView.layer .addAnimation(anim, forKey: NSMetadataUbiquitousItemURLInLocalContainerKey)
    }
    
    //设置登录类型
    func setupVisitorInfo(viweType:UnloadViewType){
        
        
        switch viweType {
        case .profileUnload:
            startAnimation()
        default: break
            
        }
        
    }
    
    //MARK: - 懒加载控件
    //转盘
    private lazy var iconView: UIImageView = {
        let iv = UIImageView (image: UIImage (named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    
    //图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView (image: UIImage (named: "visitordiscover_feed_image_house"))
        return iv
    }()
    
    //文本
    private lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkGrayColor()
        label.text = "这句话以后要做国际化"
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
    //登录按钮
    private lazy var loginbutton: UIButton = {
        
        let btn = UIButton()

        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage (named: "common_button_white_disable"), forState: .Normal)
        btn.addTarget(self, action:#selector(self.loginClick) , forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage (named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(self.registerClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //蒙版背景
    private lazy var maskBGView: UIImageView = {
    
        let iv = UIImageView (image: UIImage (named: "visitordiscover_feed_mask_smallicon"))
        return iv
        
    }()
    
    
}
