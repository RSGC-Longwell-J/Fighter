//
//  GameViewController.swift
//  Fighter
//
//  Created by Longwell on 2017-02-28.
//  Copyright © 2017 Longwell. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = StartScreen(size: CGSize(width:2048,height:1536))
        
        let skView = self.view as! SKView
        
        //skView.showFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
}

        
