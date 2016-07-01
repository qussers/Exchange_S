//
//  BaseTableViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    //MARK: -------- 父类方法--------
    override func loadView() {
        //当用户未登录,并且该控制器重写了设置未登录界面
        User.getCurrentUser() == false ? view = setUnloadView() : super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
    
    //设置未登录页面样式,没有设置的话将默认选择一个样式进行设置
    func setUnloadView()->UIView{
        //默认情况下返回加载后的view
        super.loadView()
        return view;
    }
    
   
}
