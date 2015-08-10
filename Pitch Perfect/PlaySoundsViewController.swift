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
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()


        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer2.enableRate = true
        
        audioEngine = AVAudioEngine()
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
    }
    
    func rateSounds(rate: Float) {
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
    }
    @IBAction func snailSound(sender: UIButton) {
        resetPlayer()
        rateSounds(0.5)
        audioPlayer.play()
    }
    
    
    @IBAction func rabbitSound(sender: UIButton) {
        resetPlayer()
        rateSounds(1.5)
        audioPlayer.play()
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
        resetPlayer()
        audioPlayer.play()
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0.0
        audioPlayer2.playAtTime(playtime)
    }
  
    @IBAction func stopButton(sender: UIButton) {
        resetPlayer()
        
    }

 

}
