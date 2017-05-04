//
//  StartScreen.swift
//  Fighter
//
//  Created by Longwell on 2017-05-04.
//  Copyright © 2017 Longwell. All rights reserved.
//

import Foundation
import SpriteKit


class StartScreen : SKScene {
    
    override func didMove(to view: SKView) {
        
        let startScreen = SKSpriteNode(imageNamed: "Black")
        startScreen.color = SKColor.black
        startScreen.setScale(15)
        startScreen.zPosition = 100
        startScreen.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let startScreenText = SKLabelNode(fontNamed: "Helvetica")
        startScreenText.text = "Tap to Begin"
        startScreenText.fontColor = SKColor.white
        startScreenText.fontSize = 288
        startScreenText.zPosition = 150
        startScreenText.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(startScreen)
        addChild(startScreenText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        if touchLocation.x > self.size.width - self.size.width {
            
            let gameScene = GameScene(size: size)
            
            let reveal = SKTransition.reveal(with: .down, duration: 0.5)
            
            view?.presentScene(gameScene,transition: reveal)
            
        
    }
    }

}
