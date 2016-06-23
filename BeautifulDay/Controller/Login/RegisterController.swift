//
//  RegisterController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/6/17.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    var phone: String?
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "注册"
        if let phone = phone {
            phoneLabel.text = "手机号：\(phone)"
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - ACTION
    @objc private func dismissSelf() {
        if let nc = navigationController {
            nc.dismissViewControllerAnimated(true, completion: {
                
            })
        }
    }
    
    @IBAction func comfirm(sender: UIButton) {
        guard usernameTextField.text != nil else {
            SAIUtil.showMsg("请填写用户名")
            return
        }
        
        guard !usernameTextField.text!.isEmpty else {
            SAIUtil.showMsg("请填写用户名")
            return
        }
        
        SAIUtil.showLoading()
        
        postRegister(phone!, username: usernameTextField.text!, password: "888888", failure: { (error: NSError) in
            SAIUtil.showMsg(error.description)
            }) { [weak self] (userId, token) in
                currentUser.userId = userId
                currentUser.token = token
                currentUser.username = self!.usernameTextField.text!
                SAIUtil.showMsg("注册成功")
                self!.dismissSelf()
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
