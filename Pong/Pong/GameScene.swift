//
//  GameScene.swift
//  Pong
//
//  Created by Luqman Abdurrohman on 9/8/19.
//  Copyright © 2019 Luqman Abdurrohman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var score = [Int]()
    
    var scoreEnemy = SKLabelNode()
    var scoreMain = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        scoreEnemy = self.childNode(withName: "scoreEnemy") as! SKLabelNode
        scoreMain = self.childNode(withName: "scoreMain") as! SKLabelNode

        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame(){
        score = [0,0]
        scoreMain.text = "\(score[0])"
        scoreEnemy.text = "\(score[1])"
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        //sets ball position to the center
        ball.position = CGPoint(x: 0, y: 0)
        //resets the impulse settings of the ball
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        let impluse = 90
        
        if playerWhoWon == main{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: impluse, dy: impluse))
        }
        else if playerWhoWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -(impluse), dy: -(impluse)))
         }
        
        scoreMain.text = "\(score[0])"
        scoreEnemy.text = "\(score[1])"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //grabs the information for each touch
        for touch in touches{
            //declares a variable to the location of the touch
            let location = touch.location(in: self)
    
            //intialize the main(platform) location to the touch location
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //grabs the information for each touch
        for touch in touches{
            //declares a variable to the location of the touch
            let location = touch.location(in: self)
            
            //intialize the main(platform) location to the touch location
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //moves the enemy platform X axis relatively to the ball
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= main.position.y - 70{
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70{
            addScore(playerWhoWon: main)
        }

    }
}
