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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SteamSpyService.getTopApps() { (result: [AppDataModel]) in
            print("AppData recieved")
            
            DispatchQueue.main.async {
                self.spinnerView.stopAnimating()
                self.appData = result
                self.populateAppList()
            }
            return
        }
        
        if let selectedRow = appTableView.indexPathForSelectedRow {
            appTableView.deselectRow(at: selectedRow, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let appDetail = segue.destination as? AppDetailView {
            let selectedIndex = appTableView.indexPathForSelectedRow!.row
            appDetail.appData = appData[selectedIndex]
        }
    }
    
    func populateAppList(){
        appData.sort{ $0.appNumberOfPlayers! > $1.appNumberOfPlayers! }
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
        
        cell?.appPlayerNumberLabel.text = data.appNumberOfPlayers?.description
        cell?.appHeaderImageView.sd_setImage(with: data.appImageURL, placeholderImage:#imageLiteral(resourceName: "SteamLogo"))
        cell?.appBackgroundImageView.sd_setImage(with: data.appBackgroundImageURL)
    
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.count
    }
}
