//
//  RegisterViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/30.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    

    @IBOutlet weak var registerBtn: UIButton!
    @IBAction func registerClick(sender: AnyObject) {
        
        //获取电话号码
        let phoneNumber = phoneNumberTextField.text
        //如果电话号码的长度大于0!此处进行正则验证手机号
        if (phoneNumber?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
            //发送验证码
            NetService.init().manager.registerCode(phoneNumber!, successCallback: { (result) in
                //返回验证码
                print(result)
                }, errorCallback: { (error) in
                //填写验证码
                print(error)
            })
        }
}
    

    @IBAction func emailClick(sender: AnyObject) {
        //转变成邮箱注册
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //传递信息
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pushSMSCode" {
            let controller = segue.destinationViewController as! SMCodeViewController
            controller.phoneNumber = phoneNumberTextField.text
        }
    }
    
    //MARK:UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 {
            return true
        }
        //1.将NSRange转换成swiftRange
        let indexPositionOne = textField.text!.startIndex.successor()
        let swiftRange = indexPositionOne.advancedBy(range.location - 1) ..< indexPositionOne.advancedBy(range.location+range.length - 1)
        //需要改变的字符串的位置
        let text = textField.text?.stringByReplacingCharactersInRange(swiftRange, withString: string)
        //只有满足有效的电话号码才会允许注册
        if (RegularVerification.validate(text!, type: validateType.phoneNumber) == true) {
            registerBtn.alpha = 1
            registerBtn.enabled = true;
        }
        else{
            registerBtn.alpha = 0.5
            registerBtn.enabled = false;
        }
        return true
    }
    

}
