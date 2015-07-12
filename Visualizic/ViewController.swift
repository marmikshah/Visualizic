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

class ViewController: UIViewController,AVAudioRecorderDelegate {
    var interval = 0;
    var red : CGFloat = 255;
    var green : CGFloat = 0;
    var blue : CGFloat = 0;
    var audioRecorder : AVAudioRecorder!;
    var recordSettings = [
        AVFormatIDKey: kAudioFormatAppleLossless,
        AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
        AVEncoderBitRateKey : 320000,
        AVNumberOfChannelsKey: 2,
        AVSampleRateKey : 44100.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "changeColor", userInfo: nil, repeats: true);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("Memory Overload");
    }
    func record(){
        
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var str =  documents.stringByAppendingPathComponent("recordTest.caf")
        var url = NSURL.fileURLWithPath(str as String)
        
        var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:1,AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
            
        ]
        
        println("url : \(url)")
        var error: NSError?
        
        audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings as [NSObject : AnyObject], error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            audioRecorder.meteringEnabled = true;
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startAudioMetering", userInfo: nil, repeats: true);
        }
        
        
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
    func startAudioMetering(){
        audioRecorder.updateMeters();
        var dbLevel = audioRecorder.averagePowerForChannel(0);
        
        println(dbLevel)
        
    }
    
    
}

