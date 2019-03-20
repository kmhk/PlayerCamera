//
//  ViewController.swift
//  PlayerVideo
//
//  Created by user on 3/20/19.
//  Copyright © 2019 KMHK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: member variable
    
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var btnRecord: UIButton!
    
    let viewModel = CameraViewModel.sharedModel()
    
    
    // MARK: life cycling method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        btnRecord.setImage(UIImage(named: "btnRecord"), for: .normal)
        
        viewModel?.initRecorder(with: viewCamera)
    }


    // MARK: action method
    
    @IBAction func btnRecordTapped(_ sender: Any) {
        viewModel?.shotRecording()
    }
    
}


// MARK: - CameraViewModel delegate

extension ViewController: CameraViewModelDelegate
{
    func isStartedRecording(isRecording: Bool) {
        if isRecording == true {
            btnRecord.setImage(UIImage(named: "btnStopRecord"), for: .normal)
        } else {
            btnRecord.setImage(UIImage(named: "btnRecord"), for: .normal)
        }
    }
    
    func finishedRecord() {
        performSegue(withIdentifier: "seguePlay", sender: nil)
    }
}
