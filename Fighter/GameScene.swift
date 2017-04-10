//
//  GameScene.swift
//  Fighter
//
//  Created by Longwell on 2017-02-28.
//  Copyright © 2017 Longwell. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    // MARK: Properties
    
    
    let stickMan = SKSpriteNode(imageNamed: "Stick_Figure")
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    
    var lives = 3
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        //adding a sprite
    

        stickMan.setScale(1.5)
        stickMan.position = CGPoint(x: 250, y: 500)
        addChild(stickMan)
        
        let actionWait = SKAction.wait(forDuration: 5)
        let actionSpawn = SKAction.run() { [weak self] in self?.spawnZombie() }
        
        
        let actionSequence = SKAction.sequence([actionWait, actionSpawn])
        let actionZombieRepeat = SKAction.repeatForever(actionSequence)
        
        
        run(actionZombieRepeat)
        
        scoreLabel.text = String(lives)
        scoreLabel.fontColor = SKColor.black
        scoreLabel.fontSize = 96
        scoreLabel.zPosition = 150
        scoreLabel.position = CGPoint(x: size.width - size.width / 8, y: size.height - size.height / 4)
        
        addChild(scoreLabel)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        checkCollisions()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        moveStickMan(touchLocation: touchLocation)
        
            }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // get the first touch location
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        moveStickMan(touchLocation: touchLocation)
        
    }
    
    func moveStickMan(touchLocation: CGPoint)  {
        
        let destination = CGPoint(x: stickMan.position.x, y: touchLocation.y)
        
        let actionMove = SKAction.move(to:destination, duration: 0.5)
        
        stickMan.run(actionMove)

        
    }
    func spawnZombie() {
        let zombie = SKSpriteNode(imageNamed: "zombie")
        
        let verticalPosition = CGFloat(arc4random_uniform(UInt32(size.height - zombie.size.width)))
        let horizontalPosition = size.width + zombie.size.width
        
        
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        zombie.position = startingPosition
        
        zombie.setScale(0.9)
        
        addChild(zombie)
        
        zombie.name = "zombie"
        
        let endingPosition = CGPoint(x: 0 - zombie.size.width, y: verticalPosition)
        let actionMove = SKAction.move(to: endingPosition, duration: 7)
        
        let actionRemove = SKAction.removeFromParent()
        
        let actionSequence = SKAction.sequence([actionMove, actionRemove])
        zombie.run(actionSequence)
    }
    
    
    func checkCollisions() {
        
        var hitZombie : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "zombie", using: {
            node, _ in
        
        
        let zombie = node as! SKSpriteNode
        
//            if zombie.frame.insetBy(dx: 40 dy: 10).intersects(self.stickMan.frame)
            
        if zombie.frame.intersects(self.stickMan.frame) {
            
            hitZombie.append(zombie)
        }
        
    })
        
        for zombie in hitZombie{
            
            stickManHit(by: zombie)
        }
    }
    
    func stickManHit(by zombie: SKSpriteNode){
        
        lives -= -1
        
        scoreLabel.text = String(lives)
        
        zombie.removeFromParent()
    }
    

    
}
