//
//  ViewController.swift
//  Code Sample
//
//  Created by Conor on 13/02/2017.
//  Copyright © 2017 Conor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTableView: UITableView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    var appData : [AppDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SteamSpyService.getTopApps() { (result: [AppDataModel]) in
            print("AppData recieved")
            self.appData = result
            self.populateAppList()
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func populateAppList(){
        appData.sort{ $0.appNumberOfPlayers! > $1.appNumberOfPlayers! }
        spinnerView.stopAnimating()
        appTableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "appCell") as? AppCellView
        
        if cell == nil {
            cell = AppCellView()
        }
        
        let data = appData[indexPath.row]
        
        cell?.appNameLabel.text = data.appNameLiteral
        cell?.appDeveloperLabel.text = data.appDeveloperLiteral
        cell?.appPlayerNumberLabel.text = data.appNumberOfPlayers?.description
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.count
    }
}
