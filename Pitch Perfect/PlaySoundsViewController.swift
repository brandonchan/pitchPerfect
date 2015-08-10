//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brandon on 8/5/15.
//  Copyright (c) 2015 bc. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioPlayer2:AVAudioPlayer!
    
    var audioEngine:AVAudioEngine!
    var audioEngine2:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()


        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer2.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioEngine2 = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetPlayer() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer2.stop()
        audioEngine2.stop()
        audioEngine2.reset()
    }
    
    func rateSounds(rate: Float) {
        resetPlayer()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    @IBAction func snailSound(sender: UIButton) {
        rateSounds(0.5)
    }
    
    @IBAction func rabbitSound(sender: UIButton) {
        rateSounds(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
   
    func playAudioWithVariablePitch(pitch: Float){
        resetPlayer()
        
        //        LinkedList
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEcho(sender: UIButton) {
        rateSounds(1.0)
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioEngine2.stop()
        audioEngine2.reset()
        audioPlayer2.currentTime = 0.0
        audioPlayer2.playAtTime(playtime)
    }
  
    @IBAction func stopButton(sender: UIButton) {
        resetPlayer()
        
    }

 

}
