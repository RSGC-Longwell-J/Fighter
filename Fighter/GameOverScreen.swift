//
//  GameOverScreen.swift
//  Fighter
//
//  Created by Longwell on 2017-04-20.
//  Copyright © 2017 Longwell. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScreen : SKScene {
    
    override func didMove(to view: SKView) {
        
        let gameOverScreen = SKSpriteNode(imageNamed: "Blood")
        gameOverScreen.setScale(9)
        gameOverScreen.zPosition = 100
        gameOverScreen.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let gameOverScreenText = SKLabelNode(fontNamed: "Helvetica")
        gameOverScreenText.text = "GameOver"
        gameOverScreenText.fontColor = SKColor.white
        gameOverScreenText.fontSize = 288
        gameOverScreenText.zPosition = 150
        gameOverScreenText.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(gameOverScreen)
        addChild(gameOverScreenText)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        if touchLocation.x > self.size.width - self.size.width {
            
            let startScreen = StartScreen(size: size)
            
            let reveal = SKTransition.reveal(with: .down, duration: 0.5)
            
            view?.presentScene(startScreen,transition: reveal)
            
            
        }
    }
}


