//
//  SteamSpyService.swift
//  Code Sample
//
//  Created by Conor on 13/02/2017.
//  Copyright © 2017 Conor. All rights reserved.
//

import UIKit

class SteamSpyService
{
    class func getTopApps(completion: @escaping (_ result: [AppDataModel]) -> Void)
    {
        
        let urlString = "https://steamspy.com/api.php?request=top100in2weeks"
        var steamAppArray = Array<AppDataModel>()
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    
                    for appID in parsedData.keys
                    {
                        guard let appDataDict = parsedData[appID] as? [String:Any] else{
                            print("Unwrap Error")
                            return
                        }
                        
                        var appDataStruct = AppDataModel()
                        
                        appDataStruct.appID = appID
                        appDataStruct.appNameLiteral = appDataDict["name"] as? String
                        appDataStruct.appDeveloperLiteral = appDataDict["developer"] as? String
                        appDataStruct.appPublisherLiteral = appDataDict["publisher"] as? String
                        appDataStruct.appNumberOfPlayers = appDataDict["players_2weeks"] as? Int

                        if let priceString = appDataDict["price"] as? String
                        {
                            appDataStruct.appPrice = Int(priceString)
                        }
                        
                        appDataStruct.appImageURL = URL(string: "http://cdn.akamai.steamstatic.com/steam/apps/\(appID)/header.jpg")
                        appDataStruct.appBackgroundImageURL = URL(string: "http://cdn.akamai.steamstatic.com/steam/apps/\(appID)/page_bg_generated_v6b.jpg")
                        
                        steamAppArray.append(appDataStruct)
                        
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            completion(steamAppArray)
            
            }.resume()
        
    }
}
