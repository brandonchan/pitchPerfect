//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brandon on 7/20/15.
//  Copyright (c) 2015 bc. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!


    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!

    
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pauseRecording(sender: UIButton) {
        audioRecorder.pause()
        pauseButton.hidden = true
        resumeButton.hidden = false
        recordingInProgress.text = "Recording Paused"
    }
    
    @IBAction func resumeRecording(sender: UIButton) {
        audioRecorder.record()
        pauseButton.hidden = false
        resumeButton.hidden = true
        recordingInProgress.text = "Recording in Progress"
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide the stop button
        recordingInProgress.text = "Tap to Record"
        recordingInProgress.hidden = false
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {

        recordingInProgress.text = "Recording in Progress"
        recordingInProgress.hidden = false
        stopButton.hidden = false
        pauseButton.hidden = false
        recordButton.enabled = false

        println("in recordAudio")

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String


        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)

            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
 

    @IBAction func stopAudio(sender: UIButton) {

        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
   
   
}

