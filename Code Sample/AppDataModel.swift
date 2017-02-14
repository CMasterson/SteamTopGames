//
//  AppDataModel.swift
//  Code Sample
//
//  Created by Conor on 13/02/2017.
//  Copyright © 2017 Conor. All rights reserved.
//

import Foundation

struct AppDataModel {
    var appID : String?
    var appNameLiteral : String?
    var appDeveloperLiteral : String?
    var appPublisherLiteral : String?
    var appNumberOfPlayers : Int?
    
    init()
    {
        appID = nil
        appNameLiteral = nil
        appDeveloperLiteral = nil
        appPublisherLiteral = nil
        appNumberOfPlayers = nil
    }
}
