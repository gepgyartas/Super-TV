//
//  ViewController.swift
//  Super TV
//
//  Created by Laci on 2017. 12. 07..
//  Copyright © 2017. Illés László. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIScrollViewDelegate {
    
    var ViewWidth:CGFloat = 0.0
    var ViewHeight:CGFloat = 0.0
    var TVChannelHeigth = 70.0
    var ChannelArray = [Channels]()
    var ScrollView = UIScrollView()
    var ScrollView2 = UIScrollView()
    var xPozTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        ViewWidth = self.view.frame.width
        ViewHeight = self.view.frame.height
        
        ScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ViewWidth, height: ViewHeight))
        ScrollView.contentSize.width = 4200
        self.view.addSubview(ScrollView)
        ScrollView.delegate = self
        
        ScrollView2 = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: ViewHeight))
        ScrollView2.contentSize.width = 100
        self.view.addSubview(ScrollView2)
        
        

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateStart = dateFormatter.date(from: "2017-01-16T00:00:00Z")
        xPozTime = Int(dateStart!.timeIntervalSince1970)
        
       
        let parser1 = ParserClass()
        ChannelArray = parser1.StartPars()
        
      
        if ChannelArray.count > 0{
            ScrollView.contentSize.height = CGFloat(ChannelArray.count*70)
            CreatUseInterface(number:ChannelArray.count)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    public func CreatUseInterface(number:Int){
        
        
        for index in stride(from: 0, to: number, by: 1){
            
            let ypos = Double(index)*TVChannelHeigth
            
            let TextBox = UILabel(frame: CGRect(x: 0, y: ypos, width: 100, height: TVChannelHeigth))
            TextBox.backgroundColor = .black
            let a = ChannelArray[index].Title
            TextBox.textColor = UIColor.white
            TextBox.font = TextBox.font.withSize(16)
            TextBox.text = "\(a)"
            ScrollView2.addSubview(TextBox)
            
            let CEnumber = ChannelArray[index].TVProgram.episods.count
            
            for index2 in stride(from: 0, to: CEnumber, by: 1){
                
                let EpisodText = ChannelArray[index].TVProgram.episods[index2].titel
                let start = ChannelArray[index].TVProgram.episods[index2].StarDate
                let end = ChannelArray[index].TVProgram.episods[index2].EndDate
                let xPoz:[Double] = getTime(a: start, b: end)
                
                
                let TextBox = UILabel(frame: CGRect(x: xPoz[0], y: ypos, width: xPoz[1], height: TVChannelHeigth - 10))
                TextBox.backgroundColor = .black
                TextBox.textColor = UIColor.white
                TextBox.font = TextBox.font.withSize(16)
                TextBox.text = "\(EpisodText)"
                ScrollView.addSubview(TextBox)
                
                
                let index1 = start.index(start.startIndex, offsetBy: 11)
                let index2 = start.index(start.startIndex, offsetBy: 12)
                let index3 = start.index(start.startIndex, offsetBy: 14)
                let index4 = start.index(start.startIndex, offsetBy: 15)
                let time1 = String(start[index1])
                let time2 = String(start[index2])
                let time3 = String(start[index3])
                let time4 = String(start[index4])
                let Time = "\(time1)\(time2):\(time3)\(time4) "
                
                let TextBoxTime = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: TVChannelHeigth - 50))
                TextBoxTime.backgroundColor = .black
                TextBoxTime.textColor = UIColor.white
                TextBoxTime.font = TextBox.font.withSize(10)
                TextBoxTime.text = "\(Time)"
                TextBox.addSubview(TextBoxTime)
            }
            
        }
        
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ScrollView2.contentOffset.y = ScrollView.contentOffset.y
        
    }
    
    
    private func getTime(a:String,b:String) -> ([Double]){
        
        var array = [Double]()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateStart = dateFormatter.date(from: a)
        let dateEnd = dateFormatter.date(from: b)
        
        let start = Int(dateStart!.timeIntervalSince1970)
        let end = Int(dateEnd!.timeIntervalSince1970)
        
        let result = (Double(start - xPozTime)/20)
        let width = (Double(end - start)/20) - 5.0
        array.append(result)
        array.append(width)
        
        return array
    }
    
   
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async() {
            self.ScrollView.removeFromSuperview()
            self.ScrollView2.removeFromSuperview()
            self.ViewWidth = self.view.frame.width
            self.ViewHeight = self.view.frame.height
            
            self.ScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.ViewWidth, height: self.ViewHeight))
            self.ScrollView.contentSize.width = 4200
            self.view.addSubview(self.ScrollView)
            self.ScrollView.delegate = self
            
            self.ScrollView2 = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: self.ViewHeight))
            self.ScrollView2.contentSize.width = 100
            self.view.addSubview(self.ScrollView2)
            
            if self.ChannelArray.count > 0{
                self.ScrollView.contentSize.height = CGFloat(self.ChannelArray.count*70)
                self.CreatUseInterface(number:self.ChannelArray.count)
            }
        }
    }
    
    
    /*
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

