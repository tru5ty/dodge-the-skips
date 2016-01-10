//
//  GameScene.swift
//  DodgeTheSkips
//
//  Created by Nathan McGuire on 10/01/2016.
//  Copyright (c) 2016 Nathan McGuire. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var hero: Hero!
    var touchLocation: CGFloat!
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        addBG()
        addJeff()
    }
    
    func addBG() {
        let bg = SKSpriteNode(imageNamed: "bg")
        addChild(bg)
    }
    
    func addJeff() {
        let jeff = SKSpriteNode(imageNamed: "jeff")
        hero = Hero(guy: jeff)
        addChild(jeff)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
       
        for touch in touches {
            if !gameOver {
                touchLocation = (touch.locationInView(self.view).y * -1) + (self.size.height/2)
            }
        }
        
        let moveAction = SKAction.moveToY(touchLocation, duration: 0.5)
        moveAction.timingMode = SKActionTimingMode.EaseOut
        hero.guy.runAction(moveAction)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
