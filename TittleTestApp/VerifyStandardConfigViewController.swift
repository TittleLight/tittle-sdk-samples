//
//  VerifyStandardConfigViewController.swift
//  TittleDemoApp
//
//  Created by Jackie on 4/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

import UIKit
import TittleFramework

class VerifyStandardConfigViewController: UIViewController, TittleLightControlDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmHintLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    // init TittleLightControl
    let tittleLightCtrl = TittleLightControl()
    var tittle: TittleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate of TittleLightControl
        tittleLightCtrl.delegate = self
        
        //this should be call imediately after the didReceivedResponsed callback return. so put in the viewDidLoad
        tittleLightCtrl.verifyStandardConfig()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - button actions
     */
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.statusLabel.isHidden = false
        tittleLightCtrl.confirmStandardConfig(self.tittle?.ip)
    }
    
    /*
     // MARK: - TIttleLightControl delegate
     */
    func standardConfigVerified(_ tittle: TittleData?) {
        if tittle != nil {
            self.tittle = tittle
            self.confirmHintLabel.isHidden = false;
            self.confirmButton.isHidden = false;
        }
    }
    
    func standardConfigDone(_ ackCode: Int32) {
        self.performSegue(withIdentifier: "unwindToSearchPage", sender: self)
    }
    
    /*
     // MARK: - segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToSearchPage" {
            let destinationVC = segue.destination as! SearchTittleViewController
            destinationVC.tittles = [self.tittle] as! [TittleData]
            destinationVC.tittleListTableView.reloadData()
        }
    }
    
    
    
}
