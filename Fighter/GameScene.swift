//
//  GameScene.swift
//  Fighter
//
//  Created by Longwell on 2017-02-28.
//  Copyright © 2017 Longwell. All rights reserved.
//

import SpriteKit
import Darwin


class GameScene: SKScene {
    
    // MARK: Properties
    
    //setting stickman to be the picture of him
    let stickMan = SKSpriteNode(imageNamed: "Stick_Figure")
    
    //Background
    let background = SKSpriteNode(imageNamed: "Grass")
    
    
    //setting the score to be helvetica font
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    let livesOnScreen = SKLabelNode(fontNamed: "Helvetica")
    
    
    //creating a variable
    var lives = 5
    
    
    
    override func didMove(to view:  SKView) {
        
        
        //setting the background color to be black
        backgroundColor = SKColor.white
        
        
        //Creating StickMan
        stickMan.setScale(1.5)
        stickMan.position = CGPoint(x: 250, y: 500)
        stickMan.zPosition = 50
        addChild(stickMan)
        
        //Creating the background
        
        background.setScale(2.2)
        background.zPosition = 0
        background.position = CGPoint(x: size.width/2, y:size.height/2)
        addChild(background)
        
        //Spawning the Zombie
        let actionWaitZombie = SKAction.wait(forDuration: 5)
        let actionSpawnZombie = SKAction.run() { [weak self] in self?.spawnZombie() }
        
        
        let actionSequenceZombie = SKAction.sequence([actionWaitZombie, actionSpawnZombie])
        let actionZombieRepeat = SKAction.repeatForever(actionSequenceZombie)
        
        
        run(actionZombieRepeat)
        
        //spawning the powerup
        
        let actionWaitPower = SKAction.wait(forDuration:10)
        let actionSpawnPower = SKAction.run() { [weak self] in self?.spawnPower() }
        
        let actionSequencePower = SKAction.sequence([actionWaitPower, actionSpawnPower])
        let actionPowerRepeat = SKAction.repeatForever(actionSequencePower)
        
        run(actionPowerRepeat)
        
        
        
        //Making the Score Appear
        scoreLabel.text = String("Lives \(lives)")
        scoreLabel.fontColor = SKColor.black
        scoreLabel.fontSize = 96
        scoreLabel.zPosition = 150
        scoreLabel.position = CGPoint(x: size.width - size.width / 8, y: size.height - size.height / 4)
        
        addChild(scoreLabel)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        checkCollisionZombie()
        checkCollisionPowerup()
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        if touchLocation.x > self.size.width / 2 {
            print("right")
        } else {
            print("left")
        }
        
        moveStickManHorizontaly(touchLocation: touchLocation)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        moveStickManHorizontaly(touchLocation: touchLocation)
        
    }
    
    
    //Moving stickMan to a location
    func moveStickManHorizontaly(touchLocation: CGPoint)  {
        
        let destination = CGPoint(x: stickMan.position.x, y: touchLocation.y)
        
        let actionMove = SKAction.move(to:destination, duration: 0.5)
        
        stickMan.run(actionMove)
        
        
    }
    
    //making the projectile attack appear
    
    
    
    //Spawning the Zombies
    func spawnZombie() {
        let zombie = SKSpriteNode(imageNamed: "zombie")
        
        let verticalPosition = CGFloat(arc4random_uniform(0) + 1500)
        let horizontalPosition = size.width + zombie.size.width
        
        
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        zombie.position = startingPosition
        zombie.zPosition = 50
        zombie.setScale(0.9)
        
        addChild(zombie)
        
        zombie.name = "zombie"
        
        let endingPosition = CGPoint(x: 0 - zombie.size.width, y: verticalPosition)
        let actionMove = SKAction.move(to: endingPosition, duration: 7)
        
        let actionRemove = SKAction.removeFromParent()
        
        let actionSequence = SKAction.sequence([actionMove, actionRemove])
        zombie.run(actionSequence)
    }
    
    //Spawning the PowerUp
    
    func spawnPower() {
        
        let Power1 = SKSpriteNode(imageNamed: "Power1")
        
        let verticalPosition = CGFloat(arc4random_uniform(400) + 1200)
        let horizontalPosition = size.width + Power1.size.width
        
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        Power1.position = startingPosition
        Power1.zPosition = 50
        Power1.setScale(1.0)
        
        addChild(Power1)
        
        Power1.name = "Power1"
        
        let endingPosition = CGPoint(x: 0 - Power1.size.width, y: verticalPosition)
        let actionMove = SKAction.move(to: endingPosition, duration: 7)
        
        let actionRemove = SKAction.removeFromParent()
        
        let actionSequence = SKAction.sequence([actionMove, actionRemove])
        
        Power1.run(actionSequence)
        
        
    }
    
    
    //checking if stickman is hit by a zombie
    func checkCollisionZombie() {
        
        var hitZombie : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "zombie", using: {
            node, _ in
            
            
            let zombie = node as! SKSpriteNode
            
            
            if zombie.frame.intersects(self.stickMan.frame) {
                
                hitZombie.append(zombie)
            }
            
        })
        
        for zombie in hitZombie{
            
            stickManHitByZombie(by: zombie)
        }
    }
    
    
    //What happens when the zombie hits stickMan
    func stickManHitByZombie(by zombie: SKSpriteNode){
        
        lives = lives - 1
        
        if lives < 0{
            
            let gameOverScene = GameOverScreen(size: size)
            
            let reveal = SKTransition.reveal(with: .down, duration: 0.5)
            
            view?.presentScene(gameOverScene,transition: reveal)
            
            
        }
        
        
        scoreLabel.text = String("Lives \(lives)")
        
        zombie.removeFromParent()
    }
    
    
    //checking if stickman is hit by power up
    func checkCollisionPowerup() {
        
        var hitPower : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "Power1", using: {
            node, _ in
            
            
            let Power1 = node as! SKSpriteNode
            
            
            if Power1.frame.intersects(self.stickMan.frame) {
                
                hitPower.append(Power1)
            }
            
        })
        
        for Power1 in hitPower{
            
            stickManHitByPower(by: Power1)
        }
    }
    
    
    //what heppens when the powerup hits stickman
    func stickManHitByPower(by Power1: SKSpriteNode){
        
        lives = lives + 1
        
        scoreLabel.text = String("Lives \(lives)")
        
        Power1.removeFromParent()
        
        
    }
    
    //function to pause the game for a sec
    func pauseForAMoment() {
        
        sleep(1)
        
    }
    
    
    
    
}
