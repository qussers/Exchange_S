//
//  BaseViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: -------自定义方法--------
    
    //MARK:-设置导航条
    
    //设置左标题
    func setLeftNavTitle(leftTitle:String){
        
        //如果存在这张图片
        if ((UIImage (named: leftTitle) ) != nil) {
            navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem(leftTitle, target: self, action: #selector(self.leftNavClick))
        }
        else{
            navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: leftTitle, style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.leftNavClick))
        }
    }
    //设置右标题
    func setRightNavTitle(rightTitle:String){
        
        //如果存在这张图片
        if ((UIImage (named: rightTitle) ) != nil) {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem(rightTitle, target: self, action: #selector(self.rightNavClick))
        }
        else{
            
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: rightTitle, style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.rightNavClick))
        }
        
    }
    
    //设置左右标题
    func setNavTitle(leftTitle:String, rightTitle:String)
    {
        
        setLeftNavTitle(leftTitle)
        setRightNavTitle(rightTitle)
    }
    
    
    
    
    
    //MARK:-左导航条按钮被点击
    func leftNavClick(){
        
        print(#function)
        
    }
    //右导航按钮被点击
    func rightNavClick(){
        
        print(#function)
        
    }

    
}
