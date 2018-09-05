//
//  SearchTittleViewController.swift
//  TittleDemoApp
//
//  Created by Jackie on 3/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

import UIKit
import TittleFramework

class SearchTittleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TittleLightControlDelegate {
    
    // init TittleLightControl
    let tittleLightCtrl = TittleLightControl()
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tittleListTableView: UITableView!
    
    var tittles: [TittleData] = []
    let cellReuseIdentifier = "tittleCell"
    
    var isSearching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tittleListTableView.delegate = self
        tittleListTableView.dataSource = self
        
        // delegate of TittleLightControl
        tittleLightCtrl.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tittleLightCtrl.stopSearchingTittles()
    }
    
    
    /*
     // MARK: - tableview
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tittles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TittleListCellTableViewCell = (self.tittleListTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TittleListCellTableViewCell?)!
        
        // set the text from the data model
        let tittle = self.tittles[(indexPath.row)]
        cell.nameLabel?.text = tittle.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tittleLightCtrl.stopSearchingTittles()
        isSearching = false
        searchButton.setTitle("Start Search", for: .normal)
        self.performSegue(withIdentifier: "ToFunctionPage", sender: self)
    }
    
    /*
     // MARK: - segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToFunctionPage" {
            let destinationVC = segue.destination as! FunctionsTableViewController
            let indexPath = self.tittleListTableView.indexPathForSelectedRow
            let tittle = self.tittles[(indexPath?.row)!]
            destinationVC.serverIP = tittle.ip
        }
    }
    
    @IBAction func unwindToSearchPage(segue:UIStoryboardSegue) { }
    
    /*
     // MARK: - button actions
     */
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if isSearching {
            tittleLightCtrl.stopSearchingTittles()
            isSearching = false
            searchButton.setTitle("Start Search", for: .normal)
        }else {
            tittles = [];
            tittleListTableView.reloadData()
            tittleLightCtrl.startSearchingTittles()
            isSearching = true
            searchButton.setTitle("Stop Search", for: .normal)
        }
        
    }
    
    /*
     // MARK: - TIttleLightControl delegate
     */
    func receivedNewTittle(_ tittle: TittleData?) {
        if tittle != nil {
            self.tittles.append(tittle!)
            self.tittleListTableView.reloadData()
        }
    }
    
}
