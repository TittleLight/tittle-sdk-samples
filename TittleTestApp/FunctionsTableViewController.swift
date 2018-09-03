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
// So your controller needs to implement GCDAsyncSocketDelegate


class FunctionsTableViewController: UITableViewController, GCDAsyncSocketDelegate {
    
    @IBOutlet weak var colorRTextField: UITextField!
    @IBOutlet weak var colorGTextField: UITextField!
    @IBOutlet weak var colorBTextField: UITextField!
    @IBOutlet weak var intensityTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    // init TittleLightControl
    let tittleLightCtrl = TittleLightControl()
    var lightModePackage: Data?
    
    var clientSocket:GCDAsyncSocket!
    var serverPort:UInt16 = 0
    var serverIP: String = "192.168.31.142"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let helloLogger = HelloLogger()
        helloLogger.hello(withText: "World")
        
        //        connectToTittle(ip: serverIP, port: serverPort)
        statusLabel.text = "Connecting Tittle"
        connectToTittle(ip: serverIP)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        tittleLightCtrl.connectTittle(withController: self, ip: ip)
    }
    
    func setLightMode(isOn: Bool!) {
        
        // get color RGB and intensity from text fields ot set to switch off
        let colorR: Int32! = isOn ? Int32(colorRTextField.text!) ?? 0 : 0
        let colorG: Int32! = isOn ? Int32(colorGTextField.text!) ?? 0 : 0
        let colorB: Int32! = isOn ? Int32(colorBTextField.text!) ?? 0 : 0
        let intensity: Int32! = isOn ? Int32(intensityTextField.text!) ?? 0 : 0
        
        statusLabel.text = "sending data"
        // Using Tittle SDK to send the data
        tittleLightCtrl.setLightModeInController(self, r: colorR, g: colorG, b: colorB, intensity: intensity)
    }
    
    
    // MARK: GCDAsyncSocketDelegate
    
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
    
    
    func socket(_ sock:GCDAsyncSocket, didRead data:Data, withTag tag:Int) {
        //        print("received data - ", data as NSData)
        let ackCode = tittleLightCtrl.getAckCode(from: data);
        if (tag == TITTLE_COMMAND_LIGHT_MODE) {
            if (ackCode != TITTLE_ACK_SUCCESS) {
                DispatchQueue.main.async{
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
    
    
    
}
