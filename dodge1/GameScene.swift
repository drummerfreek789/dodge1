//
//  GameScene.swift
//  dodge1
//
//  Created by John C Williams on 4/19/16.
//  Copyright (c) 2016 John C. Williams. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "player.png")
    
    override func didMoveToView(view: SKView) {
        
        player.position = CGPointMake(self.size.width/2, self.size.height/5)
        
        
       var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("Enemies"), userInfo: nil, repeats: true)
        
        self.addChild(player)
        
        NSLog("sprite is here")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
           
           let location = touch.locationInNode(self)
            player.position.x = location.x

            
           /* let location = touch.locationInNode(self)
            
            
            /*let action = SKAction.moveTo(CGPoint(x: location.x, y: location.y), duration: 2.5)*/
            
            let action = SKAction.moveTo(location, duration: 1.0)

            player.runAction(action)
            
            let dx = location.x - player.position.x
            let dy = location.y - player.position.y
            var angleInRadians = atan2(dy, dx) - CGFloat(M_PI_2)
            
            if(angleInRadians < 0){
                angleInRadians = angleInRadians + 2 * CGFloat(M_PI)
            }
            
            /*player.zRotation = angleInRadians
            
            let actionAngle = SKAction.rotateToAngle(angleInRadians, duration: 0)
            player.runAction(actionAngle)*/
            */
        }
    }
    
    func Enemies(){
        
        let Enemy = SKSpriteNode(imageNamed: "trump1.png")
        let MinValue = self.size.width / 8
        let MaxValue = self.size.width - 150
        let SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        
        
        let action = SKAction.moveToY(-70, duration: 2.0)
        Enemy.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(Enemy)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
