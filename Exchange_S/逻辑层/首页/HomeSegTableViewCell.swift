//
//  HomeSegTableViewCell.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/1.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class HomeSegTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
    
    @IBAction func segButtonClick(sender: AnyObject) {
        
    }
    
    class func makeCell(tableView:UITableView) -> HomeSegTableViewCell
    {
        let identifier = "HomeSegTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeSegTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed(identifier, owner: nil, options: nil).last as? HomeSegTableViewCell
        }
        return cell!
    }
    
    
    

}
