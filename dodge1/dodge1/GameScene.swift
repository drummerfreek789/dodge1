//
//  GameScene.swift
//  dodge1
//
//  Created by John C Williams on 4/19/16.
//  Copyright (c) 2016 John C. Williams. All rights reserved.
//

import SpriteKit


struct physics{
    static let Enemy: UInt32 = 1
    static let Bullet: UInt32 = 2
    static let Player: UInt32 = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode(imageNamed: "player.png")
    
    override func didMoveToView(view: SKView) {
        
        
        physicsWorld.contactDelegate = self
        
        player.position = CGPointMake(self.size.width/2, self.size.height/5)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = physics.Player
        player.physicsBody?.contactTestBitMask = physics.Enemy
        player.physicsBody?.dynamic = false
        
        
       var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("Enemies"), userInfo: nil, repeats: true)
        
        self.addChild(player)
        
        NSLog("sprite is here")
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if ((firstBody.categoryBitMask == physics.Enemy) && (secondBody.categoryBitMask == physics.Player)) || (firstBody.categoryBitMask == physics.Player) && (secondBody.categoryBitMask == physics.Enemy){
        
            collisionWithEnemy(firstBody.node as! SKSpriteNode, player: secondBody.node as! SKSpriteNode)
        
            NSLog("you've been hit")
        }
        
        //NSLog("you've been hit")

    }
    
    func pauseGame(){
        
        self.view!.paused = true
    }

    func collisionWithEnemy(Enemy: SKSpriteNode, player: SKSpriteNode){
        Enemy.removeFromParent()
        player.removeFromParent()
        NSLog("you died")
        
        
        self.runAction(SKAction.runBlock(self.pauseGame))
        sleep(2)
        
        
        self.view?.presentScene(GameOver())
       //self.presentViewController(GameOverViewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
           
           let location = touch.locationInNode(self)
            player.position.x = location.x

        }
    }
    
    /*override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            let location = touch.locationInNode(self)
            player.position.x = location.x
            
        }
    }*/
    
    func Enemies(){
        
        let Enemy = SKSpriteNode(imageNamed: "trump2.png")
        let MinValue = self.size.width / 8
        let MaxValue = self.size.width - 20
        let SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true
        Enemy.physicsBody?.contactTestBitMask = physics.Player
        Enemy.physicsBody?.categoryBitMask = physics.Enemy
        
        let action = SKAction.moveToY(-70, duration: 2.0)
        let actionDone = SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Enemy)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
