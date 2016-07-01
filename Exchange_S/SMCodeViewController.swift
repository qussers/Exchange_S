//
//  SMCodeViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/30.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit
import SVProgressHUD

class SMCodeViewController: UIViewController {

    
    @IBOutlet weak var promptLabel: UILabel!
    
    
    @IBOutlet weak var codeTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //后台收到的验证码
    var SMBackgroundCode : String?
    
    //注册用户的手机号码
    var phoneNumber : String?
    
    
    
    
    @IBAction func submitClick(sender: AnyObject) {
        
    
        if codeTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            return
        }
        //验证有效性
        if RegularVerification.validate(passwordTextField.text!, type: validateType.password) == false {
            return
        }
        
        //注册用户
        NetService().manager.registerUser(passwordTextField.text!, SMSCode: codeTextField.text!, phoneNumber: phoneNumber!, successCallback: { (result) in
            //注册成功
            //跳转到登录界面
            self.navigationController?.popToRootViewControllerAnimated(true)
            }) { (error) in
            //注册失败
              SVProgressHUD.showErrorWithStatus(NSLocalizedString("REGISTER_FAILURE", comment: "注册失败"), maskType: SVProgressHUDMaskType.Clear)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func filterInfo(SMSCode:String?,phoneNumber:String?,password:String?)->Bool{
        
        
        
        
        return true
    }
 
}
