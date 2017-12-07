//
//  Parser.swift
//  Super TV
//
//  Created by Laci on 2017. 12. 07..
//  Copyright © 2017. Illés László. All rights reserved.
//

import Foundation

public class ParserClass {
    
    var ChannelsArray = [Channels]()
    
    var URLlink = "https://gist.githubusercontent.com/reden87/ad856e7994b8ea93ac27503ecb051347/raw/050c539749f3d253a01ad685983ebc8503ea7872/example.json"
    
    
    public func StartPars() -> [Channels] {
        
        if let url = URL(string: "\(URLlink)") {
            do {
                let contents = try Data(contentsOf: url)
                print(contents)
                
                do {
                    if let data:Data = contents,
                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let channels = json["channels"] as? [[String: Any]] {
                        for channel in channels {
                            
                            var TVtitle:String = ""
                            var TVid:Int = 0
                            var episods = [ProgrammEpisod]()
                            
                            if let name = channel["title"] as? String {
                                TVtitle = name
                            }
                            if let name2 = channel["id"] as? Int {
                                TVid = name2
                            }
                            
                            if let name3 = channel["programme"] as? [[String:Any]] {
                               
                                for index in stride(from: 0, to: name3.count, by: 1){
                                    
                                    let title = name3[index]["title"] as! String
                                    let start = name3[index]["start_date"] as! String
                                    let end = name3[index]["end_date"] as! String
                                   
                                    let prepi = ProgrammEpisod(StarDate: start, EndDate: end, titel: title)
                                    episods.append(prepi)
                                }
                              
                            }
                            
                            let PProgram = Programm(episods: episods)
                            let PChanel = Channels(id: TVid, Title: TVtitle, TVProgram: PProgram)
                            ChannelsArray.append(PChanel)
                            
                        }
                        
                        return ChannelsArray
                    }
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        
        return ChannelsArray
    }
    
}
