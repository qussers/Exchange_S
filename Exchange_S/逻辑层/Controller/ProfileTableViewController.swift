//
//  ProfileTableViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController,UnloadViewDelegate {

    //MARK:------父类方法-------    
    //存在未登录界面 则重写这个方法
    override func setUnloadView() -> UIView {
        let unloadView = UnloadView()
        unloadView .setupVisitorInfo(UnloadViewType.profileUnload)
        unloadView.delegate = self
        return unloadView
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
    
    //MARK: ------自定义方法--------
    
    
    
    //MARK:------UnloadViewDelegate----
    func loginClick() {
        
        let sb = UIStoryboard (name: "UserCenterInit", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LoginViewController")
        navigationController?.pushViewController(vc, animated: true)
        
        
     
    }
    func registerClick() {
        
    }


}
