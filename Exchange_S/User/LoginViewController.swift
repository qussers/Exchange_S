//
//  LoginViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/19.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginClick(sender: AnyObject) {
        
        //检测输入有效性
        if RegularVerification.validate(userNameTextField.text!, type: validateType.userName) == false || RegularVerification.validate(passwordTextField.text!, type: validateType.password) == false {
            
            SVProgressHUD.showErrorWithStatus(NSLocalizedString("LOGINFAILURE", comment: "用户名或密码错误"), maskType: SVProgressHUDMaskType.Clear)
            return
        }
        //登录跳转
        NetService().manager.loginUser(userNameTextField.text!, password: passwordTextField.text!, successCallback: { (result) in
            
                //登录成功.
            SVProgressHUD.showSuccessWithStatus("登录成功")
            UIApplication.sharedApplication().delegate?.window??.rootViewController = MainViewController()
            
            
            }) { (error) in
                SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: SVProgressHUDMaskType.Clear)
        }
        
        
        
        
    }



}
