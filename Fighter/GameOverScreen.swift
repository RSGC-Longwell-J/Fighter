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
        backgroundColor = SKColor.black
        
        let gameOverScreen = SKLabelNode(fontNamed: "Helvetica")
        gameOverScreen.text = "GameOver"
        gameOverScreen.fontColor = SKColor.white
        gameOverScreen.fontSize = 288
        gameOverScreen.zPosition = 150
        gameOverScreen.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(gameOverScreen)
    }
}


