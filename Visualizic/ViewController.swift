//
//  ViewController.swift
//  Visualizic
//
//  Created by Marmik Shah on 11/07/15.
//  Copyright (c) 2015 Hackathon. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController,UIAlertViewDelegate,AVAudioRecorderDelegate {
    var interval = 0;
    var red : CGFloat = 255;
    var green : CGFloat = 0;
    var blue : CGFloat = 0;
    var audioRecorder = AVAudioRecorder();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var alertView = UIAlertView(title: "Notice", message: "Keep your phone out to become a part of the show!", delegate: self, cancelButtonTitle: "Ok");
        alertView.show();
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord();
        startAudioMetering();
        //NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "changeColor", userInfo: nil, repeats: true);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("Memory Overload");
    }
    func changeColor(){
        interval++;
        if(green>200){
            blue++;
            red--;
        }
        if(red + green + blue)%2 == 0 {
            isHighDeci()
            green+=5;
        } else {
            self.view.backgroundColor = UIColor(red: (red)/255, green: (green++)/255, blue: (blue/255), alpha: CGFloat(1))
        }
        println("\(red)\(green)\(blue)")
    }
    
    func getArtistList(){
        var url : String = "http://live-id-hack.elasticbeanstalk.com/api/v2/liveid/artists/"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            if (jsonResult != nil) {
                println("Yay!")
                println(jsonResult)
            } else {
                println("Didnt work! :(")
            }
            
            
        })
    }
    
    func isHighDeci(){
        self.view.backgroundColor = UIColor.blackColor();
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0{
            if alertView.title == "Permission"{
                println("Second Alert View")
                getArtistList()
                //audioRecorder?.delegate = self;
            } else {
                var alertView = UIAlertView(title: "Permission", message: "Visualic would like to use your microphone", delegate: self, cancelButtonTitle: "Ok")
                alertView.show()
            }
        }
    }
    func startAudioMetering(){
        audioRecorder.updateMeters();
        var dbLevel = audioRecorder.averagePowerForChannel(0);
        println(dbLevel)
        
    }
    
    
}

