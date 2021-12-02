//
//  ViewController.swift
//  EggTimer
//
//  Created by Alex Shumylo on 05/10/2021.
//  Copyright © 2021 ShumApps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if self.secondsPassed < self.self.totalTime {
                
                self.secondsPassed += 1
                progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)
                //                print(Float(self.secondsPassed) / Float(self.totalTime))
                
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "Done!"
                
                do {
                      try AVAudioSession.sharedInstance().setCategory(.playback)
                   } catch(let error) {
                       print(error.localizedDescription)
                   }
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
                
            }
        }
        
        
    }
    
}

