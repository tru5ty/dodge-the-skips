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
    var badGuys:[BadGuy] = []
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()
    
    override func didMoveToView(view: SKView) {
        endOfScreenLeft = (self.size.width / 2) * CGFloat(-1)
        endOfScreenRight = (self.size.width / 2)
        
        addBG()
        addJeff()
        addBadGuys()
    }
    
    func addBG() {
        let bg = SKSpriteNode(imageNamed: "bg")
        addChild(bg)
        bg.zPosition = 1
    }
    
    func addJeff() {
        let jeff = SKSpriteNode(imageNamed: "jeff")
        hero = Hero(guy: jeff)
        addChild(jeff)
        jeff.zPosition = 2
    }
    
    func addBadGuys() {
        addBadGuy(named: "natasha", speed: 1.0, yPos: CGFloat(self.size.height / 4))
        addBadGuy(named: "boris", speed: 1.5, yPos: CGFloat(0))
        addBadGuy(named: "paul", speed: 3.0, yPos: CGFloat(self.size.height / 4 * (-1)))
    }
    
    func addBadGuy(named named:String, speed:Float, yPos:CGFloat) {
        let badGuyNode = SKSpriteNode(imageNamed: named)
        let badGuy = BadGuy(speed: speed, guy: badGuyNode)
        badGuys.append(badGuy)
        resetBadGuy(badGuyNode, ypos: yPos)
        badGuy.yPos = badGuyNode.position.y
        addChild(badGuyNode)
        badGuyNode.zPosition = 3
    }
    
    func resetBadGuy(badguyNode:SKSpriteNode, ypos:CGFloat) {
        badguyNode.position.x = endOfScreenRight
        badguyNode.position.y = ypos
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
        if !gameOver {
            updateBadGuyPosition()
        }
    }
    
    func updateBadGuyPosition() {
        for badGuy in badGuys {
            if !badGuy.moving {
                badGuy.currentFrame++
                if badGuy.currentFrame > badGuy.randomFrame {
                    badGuy.moving = true
                }
            } else {
                badGuy.guy.position.y = CGFloat(Double(badGuy.guy.position.y) + sin(badGuy.angle) * badGuy.range)
                badGuy.angle += hero.speed
                if badGuy.guy.position.x > endOfScreenLeft {
                    badGuy.guy.position.x -= CGFloat(badGuy.speed)
                } else {
                    badGuy.guy.position.x = endOfScreenRight
                    badGuy.currentFrame = 0
                    badGuy.setRandomFrame()
                    badGuy.moving = false
                    badGuy.range += 0.1
                    //updateScore()
                }
            }
        }
    }
}
