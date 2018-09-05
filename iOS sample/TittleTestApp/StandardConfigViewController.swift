//
//  StandardConfigViewController.swift
//  TittleDemoApp
//
//  Created by Jackie on 4/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

import UIKit
import TittleFramework

class StandardConfigViewController: UIViewController, TittleLightControlDelegate {
    
    @IBOutlet weak var wifiNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    // init TittleLightControl
    let tittleLightCtrl = TittleLightControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FunctionsTableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // delegate of TittleLightControl
        tittleLightCtrl.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /*
     // MARK: - Button actions
     */
    
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        tittleLightCtrl.connectTittleForStandardConfig()
        configTittle()
    }
    
    func configTittle() {
        let wifiName:String = wifiNameTextField.text!
        let password:String = passwordTextField.text!
        tittleLightCtrl.standardConfig(wifiName, password: password)
    }
    
    /*
     // MARK: - TIttleLightControl delegate
     */
    
    func socket(_ sock:GCDAsyncSocket, didConnectToHost host:String, port:UInt16) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Connected to Tittle"
        }
    }
    
    func socketDidDisconnect(_ sock:GCDAsyncSocket, withError err:Error?) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Please go to connect wifi 'Tittle-AP'"
        }
    }
    
    func didReceivedResponsed(fromStandardConfigMode ackCode: Int32) {
        if (ackCode != TITTLE_ACK_SUCCESS) {
            DispatchQueue.main.async{
                //resend
                self.configTittle()
                self.statusLabel.text = "Re-sending data to Tittle"
            }
        }else {
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "ToVerifyConfigPage", sender: self)
            }
        }
    }
    
}
