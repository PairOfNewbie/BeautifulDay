//
//  LoginMainController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/6/17.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class LoginMainController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        let left = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(LoginMainController.dismissSelf))
        navigationItem.leftBarButtonItem = left
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Action
    @objc private func dismissSelf() {
        if let nc = navigationController {
            nc.dismissViewControllerAnimated(true, completion: { 
                
            })
        }
    }
    @IBAction func comfirm(sender: UIButton) {
        guard SAIUtil.validateMobile(phoneTextField.text) else {
             SAIUtil.showMsg("手机格式不正确")
            return
        }
        SAIUtil.showLoading()
        // todo login API
        SAIUtil.hideHUD()
        performSegueWithIdentifier("showRegister", sender: nil)
//        postRegister(phoneTextField.text!, password: "", failure: { (error) in
//            
//            }) { (success, token) in
//                if success {
//                    currentUser.token = token
//                    currentUser.userid = "11"
//                }
//        }
        
    }
    
    @IBAction func WeiboLogin(sender: UIButton) {
        // todo
    }
    
    @IBAction func wechatLogin(sender: UIButton) {
        // todo
    }
    
    @IBAction func QQLogin(sender: UIButton) {
        // todo
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? RegisterController {
            vc.phone = phoneTextField.text!
        }
    }
}
