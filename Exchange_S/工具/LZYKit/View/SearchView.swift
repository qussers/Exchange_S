//
//  SearchView.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/22.
//  Copyright © 2016年 izijia. All rights reserved.
//  导航搜索控件

import UIKit

@objc protocol SearchViewDelegate:NSObjectProtocol {
    
    //开始编辑
    optional func searchView_textFieldDidBeginEditing(searchView: SearchView)
    //结束编辑
    optional  func searchView_textFieldDidEndEditing(searchView: SearchView)
    //编辑中改变了其内容
    optional func searchView_textFieldDidEditing(editText: String?)
}


class SearchView: UIView, UITextFieldDelegate {

    var searchText: String?
    var searchPlaceholder: String?
    var leftViewImageName: String?
    var rightViewImageName: String?
    var leftViewCons: NSLayoutConstraint?
    var rightViewCons: NSLayoutConstraint?
    weak var delegate: SearchViewDelegate?
    
    //上下文
    private var myContext = 0
    
    private var tempEditText: String? = ""
    
    
    
    //创建搜索框
    static func createSearchView(closure:(searchView: SearchView)->()) -> SearchView
    {
        let searchView = SearchView()
        closure(searchView: searchView)
        //布局子控件
        return searchView
    }
    
    //重写布局子控件
    override func layoutSubviews() {
        //添加子控件
        addSubview(textField)
        textField.delegate = self
        textField.frame = self.bounds
        textField.backgroundColor = UIColor.whiteColor()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.textAlignment = NSTextAlignment.Center
        //存在左视图
        if leftViewImageName != nil {
            textField.leftView = leftBtn
        }
        if rightViewImageName != nil {
            textField.rightView = rightBtn
        }
        textField.placeholder = searchPlaceholder
        //对内容做监听
        textField.addTarget(self, action: #selector(SearchView.textEditChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    //MARK:UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {

        delegate?.searchView_textFieldDidBeginEditing?(self)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.searchView_textFieldDidEndEditing?(self)
    }
    //文字输入改变
    func textEditChanged(textField:UITextField){
        if textField.text != tempEditText {
            delegate?.searchView_textFieldDidEditing!(textField.text)
            tempEditText = textField.text
        }
    }
    
    //MARK:lazy
    lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton()
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        return rightBtn
    }()
    
    
    
    
    
    
}
