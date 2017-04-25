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
}


