//
//  Hero.swift
//  DodgeTheSkips
//
//  Created by Nathan McGuire on 10/01/2016.
//  Copyright © 2016 Nathan McGuire. All rights reserved.
//

import Foundation
import SpriteKit


class Hero {
    var guy: SKSpriteNode
    var speed = 0.1
    
    init(guy:SKSpriteNode) {
        self.guy = guy
    }
}