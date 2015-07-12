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
    var audioRecorder : AVAudioRecorder?;
    
     func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0{
            if alertView.title == "Permission"{
                println("Second Alert View")
                audioRecorder?.delegate = self;
            } else {
                var alertView = UIAlertView(title: "Permission", message: "Visualic would like to use your microphone", delegate: self, cancelButtonTitle: "Ok")
                alertView.show()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var alertView = UIAlertView(title: "Notice", message: "Keep your phone out to become a part of the show!", delegate: self, cancelButtonTitle: "Ok");
        alertView.show();
       audioRecorder = AVAudioRecorder()
        //NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "changeColor", userInfo: nil, repeats: true);
    }
    func changeColor(){
        interval++;
//        switch(interval) {
//        case 1:
//            self.view.backgroundColor = UIColor.redColor();
//        case 2:
//            self.view.backgroundColor = UIColor.greenColor();
//        case 3:
//            self.view.backgroundColor = UIColor.blueColor();
//        case 4:
//            self.view.backgroundColor = UIColor.whiteColor();
//            interval = 0;
//        default:
//            self.view.backgroundColor = UIColor.blackColor();
//        }
        if(green>200){
            blue++;
            red--
        }
        if(red + green + blue)%2 == 0 {
            isHighDeci()
            green+=5;
        } else {
            self.view.backgroundColor = UIColor(red: (red)/255, green: (green++)/255, blue: (blue/255), alpha: CGFloat(1))
        }
        println("\(red)\(green)\(blue)")
    }
    func isHighDeci(){
        self.view.backgroundColor = UIColor.blackColor();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

