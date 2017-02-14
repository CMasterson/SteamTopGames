//
//  AppDetailView.swift
//  Code Sample
//
//  Created by Conor on 14/02/2017.
//  Copyright © 2017 Conor. All rights reserved.
//

import UIKit
import SDWebImage



class AppDetailView :UIViewController {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appBackgroundImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var developerNameLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var appPriceLabel: UILabel!
    
    
    var appData:AppDataModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let appData = appData {
            appNameLabel.text = appData.appNameLiteral
            developerNameLabel.text = appData.appDeveloperLiteral
            publisherNameLabel.text = appData.appPublisherLiteral
            
            if let price = appData.appPrice {
                if price == 0 {
                    appPriceLabel.text = "Free To Play"
                }
                else {
                    appPriceLabel.text = "$\((Float(price) / 100.0).description) USD" ;
                }
            }
            
            appImageView.sd_setImage(with: appData.appImageURL, placeholderImage:#imageLiteral(resourceName: "SteamLogo"))
            appBackgroundImageView.sd_setImage(with: appData.appBackgroundImageURL)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func storeButtonTap(_ sender: Any) {
        
        if let appID = appData?.appID {
            
            if let url = URL(string: "https://store.steampowered.com/app/\(appID)/") {
                
                UIApplication.shared.open(url)
            }
        }
    }
}
