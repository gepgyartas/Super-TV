//
//  Channels.swift
//  Super TV
//
//  Created by Laci on 2017. 12. 07..
//  Copyright © 2017. Illés László. All rights reserved.
//

import Foundation


public class Channels {
    
    var id:Int
    var Title:String
    var TVProgram:Programm
    
    init(id:Int,Title:String,TVProgram:Programm) {
        self.id = id
        self.Title = Title
        self.TVProgram = TVProgram
    }
    
    
}

public class Programm {
    
    var episods = [ProgrammEpisod]()
    
    init(episods:[ProgrammEpisod]) {
        self.episods = episods
    }
    
}

public class ProgrammEpisod {
    
    var StarDate:String
    var EndDate:String
    var titel:String
    
    init(StarDate:String,EndDate:String,titel:String) {
        self.StarDate = StarDate
        self.EndDate = EndDate
        self.titel = titel
    }
    
    
}
