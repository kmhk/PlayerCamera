//
//  PlayerViewController.swift
//  PlayerVideo
//
//  Created by user on 3/20/19.
//  Copyright © 2019 KMHK. All rights reserved.
//

import UIKit
import SCRecorder


class PlayerViewController: UIViewController {
    
    // MARK: memeber variable

    @IBOutlet weak var viewPlayer: UIView!
    
    let viewModel = CameraViewModel.sharedModel()
    
    
    // MARK: life cycling
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let player = SCPlayer()
        player.setItemBy(viewModel?.recorder.session?.assetRepresentingSegments())
        let playerLayer: AVPlayerLayer! = AVPlayerLayer(player: player)
        playerLayer.frame = viewPlayer.bounds
        viewPlayer.layer.addSublayer(playerLayer)
        
        player.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
