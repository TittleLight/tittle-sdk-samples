//
//  FunctionsTableViewController.swift
//  TittleDemoApp
//
//  Created by Jackie on 30/8/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

import UIKit
import TittleFramework
// TittleFramework is using CocoaAsyncSocket for socket connections.


class FunctionsTableViewController: UITableViewController, TittleLightControlDelegate {
    
    @IBOutlet weak var colorRTextField: UITextField!
    @IBOutlet weak var colorGTextField: UITextField!
    @IBOutlet weak var colorBTextField: UITextField!
    @IBOutlet weak var intensityTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    // init TittleLightControl
    let tittleLightCtrl = TittleLightControl()
    var serverIP: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FunctionsTableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // delegate of TittleLightControl
        tittleLightCtrl.delegate = self
        
        statusLabel.text = "Connecting Tittle"
        connectToTittle(ip: serverIP!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tittleLightCtrl.disconnectTittle()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    // MARK: - Button Actions
    @IBAction func changeColorButtonDidPressed(_ sender: UIButton) {
        setLightMode(isOn: true)
    }
    
    @IBAction func changeIntensityButtonPressed(_ sender: UIButton) {
        setLightMode(isOn: true)
    }
    
    @IBAction func lightSwitchValueChanged(_ sender: UISwitch) {
        setLightMode(isOn: sender.isOn)
    }
    
    // MARK: Tittle framework
    func connectToTittle(ip: String) {
        tittleLightCtrl.connectTittle(withIP: ip)
    }
    
    func setLightMode(isOn: Bool!) {
        
        // get color RGB and intensity from text fields ot set to switch off
        let colorR: UInt8! = isOn ? UInt8(colorRTextField.text!) ?? 0 : 0
        let colorG: UInt8! = isOn ? UInt8(colorGTextField.text!) ?? 0 : 0
        let colorB: UInt8! = isOn ? UInt8(colorBTextField.text!) ?? 0 : 0
        let intensity: UInt8! = isOn ? UInt8(intensityTextField.text!) ?? 0 : 0
        statusLabel.text = "sending data"
        // Using Tittle SDK to send the data
        tittleLightCtrl.lightMode(withR: colorR, g: colorG, b: colorB, intensity: intensity)
    }
    
    
    // MARK: TittleLightControl delegate
    
    func socket(_ sock:GCDAsyncSocket, didConnectToHost host:String, port:UInt16) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Connected to Tittle"
        }
    }
    
    func socketDidDisconnect(_ sock:GCDAsyncSocket, withError err:Error?) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Disconnected to Tittle"
        }
    }
    
    
    func didReceivedResponsed(fromLightMode ackCode: Int32) {
        if (ackCode != TITTLE_ACK_SUCCESS) {
            DispatchQueue.main.async{
                //resend
                self.setLightMode(isOn: true)
                self.statusLabel.text = "Re-sending data to Tittle"
            }
        }else {
            DispatchQueue.main.async{
                self.statusLabel.text = "Received data from Tittle"
            }
        }
    }
    
    
}
