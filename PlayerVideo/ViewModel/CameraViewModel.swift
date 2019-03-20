//
//  CameraViewModel.swift
//  PlayerVideo
//
//  Created by user on 3/20/19.
//  Copyright © 2019 KMHK. All rights reserved.
//

import UIKit
import SCRecorder


var sharedCameraViewModel: CameraViewModel?

let maxDuration = 20


class CameraViewModel: NSObject
{
    // MARK: memeber variable
    
    var recorder = SCRecorder()
    
    // MARK: static method
    
    static func sharedModel() -> CameraViewModel? {
        if sharedCameraViewModel == nil {
            sharedCameraViewModel = CameraViewModel()
        }
        
        return sharedCameraViewModel
    }
    
    // MARK: life cycling
    
    override init() {
        super.init()
        
        setupRecorder()
    }
    
    // MARK: video recorder initialize
    
    func initRecorder(with view: UIView!) {
        recorder.videoConfiguration.size = view.bounds.size
    }
    
    func releaseRecorder() {
        recorder.stopRunning()
    }
    
    func startRecording() {
        recorder.record()
    }
    
    func stopRecording() {
        if recorder.isRecording {
            recorder.pause {[weak self] in
                self?.finishedRecording()
            }
        } else {
            finishedRecording()
        }
    }
    
    func finishedRecording() {
        
    }
    
    // MARK: private method
    
    private func setupRecorder() {
        //weak var weakSelf = self
        
        recorder.captureSessionPreset = SCRecorderTools.bestCaptureSessionPresetCompatibleWithAllDevices()
        recorder.device = AVCaptureDevice.Position.back
        recorder.maxRecordDuration = CMTime(value: CMTimeValue(maxDuration * 1000), timescale: 1000)
        recorder.delegate = self
        
        let video = recorder.videoConfiguration
        video.enabled = true
        video.scalingMode = AVVideoScalingModeResizeAspectFill
        video.timeScale = 1.0
        video.maxFrameRate = 30
        
        let audio = recorder.audioConfiguration
        audio.enabled = true
        audio.bitrate = 128000
        audio.channelsCount = 1
        audio.sampleRate = 0
        audio.format = Int32(kAudioFormatMPEG4AAC)
        
        recorder.session = SCRecordSession()
        recorder.session?.fileType = AVFileType.mov.rawValue
        
        recorder.startRunning()
    }
}


// MARK: - SCRecorder delegate

extension CameraViewModel: SCRecorderDelegate
{
    func recorder(_ recorder: SCRecorder, didComplete session: SCRecordSession) {
        finishedRecording()
    }
    
    func recorder(_ recorder: SCRecorder, didComplete segment: SCRecordSessionSegment?, in session: SCRecordSession, error: Error?) {
        finishedRecording()
    }
}


// MARK: - SCAssetExportSession delegate

extension CameraViewModel: SCAssetExportSessionDelegate
{
    
}
