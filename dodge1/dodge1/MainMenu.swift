//
//  MainMenu.swift
//  dodge1
//
//  Created by John C Williams on 4/27/16.
//  Copyright © 2016 John C. Williams. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {

    override func didMoveToView(view: SKView) {
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("Enemies"), userInfo: nil, repeats: true)
            
        NSLog("sprite is here")
        
    }
    
    func Enemies(){
        
        let Enemy = SKSpriteNode(imageNamed: "trump2.png")
        let MinValue = self.size.width / 8
        let MaxValue = self.size.width - 20
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
