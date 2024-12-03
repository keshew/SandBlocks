import SwiftUI
import SpriteKit

class GameData: ObservableObject {
    @Published var isLose = false
    @Published var isWin = false
    @Published var isRules = false
    @Published var isMenu = false
    @Published var score = 0
    @Published var timeLeft = 120
    @Published var numberOfBlocks = 3
    @Published var sizeOfBlock: CGFloat = 130
    @Published var moveToDisct = 5.9
}

struct CBitMask {
    static let pinkBlock: UInt32 = 1
    static let yellowBlock: UInt32 = 9
    static let orangeBlock: UInt32 = 3
    static let greenBlock: UInt32 = 5
    static let blueBlock: UInt32 = 7
    static let purpleBlock: UInt32 = 15
}

class BlockNode: SKSpriteNode {
    init(texture: SKTexture,
         position: CGPoint,
         categoryBitMask: UInt32,
         contactTestBitMask: UInt32,
         size: CGFloat) {
        let texture = texture
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = position
        self.size = CGSize(width: size, height: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size - 10, height: size))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.contactTestBitMask = contactTestBitMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData?
    var block: BlockNode!
    var nodes = [SKSpriteNode]()
    var blockNodes = [BlockNode]()
    var blockTimer: Timer!
    var gameTimer: Timer!
    var lineImage: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    var timeBonusCountLabel: SKLabelNode!
    var doubleBonusCountLabel: SKLabelNode!
    var timerForLine: Timer!
    var level = 7
    func startTimer() {
        let waitAction = SKAction.wait(forDuration: 1.0)
        let updateAction = SKAction.run { [weak self] in
            self?.updateTimer()
        }
        let sequence = SKAction.sequence([waitAction, updateAction])
        run(SKAction.repeatForever(sequence))
    }
    
    @objc func checkForLine() {
        for node in nodes {
            if node.action(forKey: "moveAction") != nil {
            } else {
                game?.isLose = true
            }
        }
        
        for block in blockNodes {
            if block.position.y >= lineImage.position.y - 50 {
                game?.isLose = true
            }
        }
        
        if game?.score == 10 {
            game?.isWin = true
        }
    }
    
    func sizeForNode() {
        if level < 5 {
            game!.sizeOfBlock = 130
            game!.numberOfBlocks = 3
            game!.moveToDisct = 5.9
        } else if level >= 5, level < 8 {
            game!.sizeOfBlock = 97
            game!.numberOfBlocks = 4
            game!.moveToDisct = 7.9
        } else if level > 8 {
            game!.sizeOfBlock = 78
            game!.numberOfBlocks = 5
            game!.moveToDisct = 9.9
        }
    }
    
    func updateTimer() {
        if game?.timeLeft ?? 0 > 0 {
            game?.timeLeft -= 1
            timeLabel.text = "TIME: \(String(describing: game!.timeLeft / 60)):\(String(describing: game!.timeLeft % 60))"
         } else {
             game?.isLose = true
         }
     }
    
    @objc func blockGoToBottom() {
        let randomBlock = getRandomBlock().keys.randomElement() ?? ""
        block = BlockNode(texture: SKTexture(imageNamed: randomBlock),
                          position: CGPoint(x: size.width / 2,
                                            y: size.height),
                          categoryBitMask: getRandomBlock()[randomBlock] ?? 0,
                          contactTestBitMask: getRandomBlock()[randomBlock] ?? 0,
                          size: game!.sizeOfBlock)
        block.physicsBody?.collisionBitMask =  0
        block.name = "block"
        block.zPosition = 5
        self.addChild(block)
        let moveAction = SKAction.moveTo(y: -1000, duration: 10)
        block.run(moveAction)
    }
    
    override func didMove(to view: SKView) {
        scene?.size = UIScreen.main.bounds.size
        physicsWorld.contactDelegate = self
        sizeForNode()
        setupView()
        setupBlocks()
        startTimer()
        blockTimer = .scheduledTimer(timeInterval: 5, target: self, selector: #selector(blockGoToBottom), userInfo: nil, repeats: true)
        
        timerForLine = .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkForLine), userInfo: nil, repeats: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            guard block != nil else { return }
            if location.y > size.height / 2.2 {
                block.position.x = location.x
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
               tappedNode.name == "backgroundHelpButton" || tappedNode.name == "helpButton" {
                game?.isRules = true
            }
            
            if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
               tappedNode.name == "backgroundBackButton" || tappedNode.name == "arrowButton" {
                game?.isMenu = true
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        guard block != nil else { return }
        
        if nodeB.name == "block", nodeA.name == "massiveBlock"  {
            block.removeAllActions()
            let moveTo = lineImage.position.y + block.size.width / 2
            let moveAction = SKAction.moveTo(y: moveTo, duration: TimeInterval(Int(game!.timeLeft)))
            self.block.run(moveAction, withKey: "moveAction")
            blockNodes.append(block)
            if nodeA.physicsBody?.contactTestBitMask == nodeB.physicsBody?.contactTestBitMask {
                nodeA.removeFromParent()
                nodeB.removeFromParent()
                
                game?.score = (game?.score ?? 0) + 2
                scoreLabel.text = "SCORE: \(game?.score ?? 0)-100"
            }
        } else if nodeB.name == "block", nodeA.name == "block" {
            block.removeAllActions()
      
            let moveTo = lineImage.position.y + block.size.width / 2
            let moveAction = SKAction.moveTo(y: moveTo, duration:TimeInterval(Int(Double(game!.timeLeft) / 1.5)))
                self.block.run(moveAction, withKey: "moveAction")
            blockNodes.append(block)
            if nodeA.physicsBody?.contactTestBitMask == nodeB.physicsBody?.contactTestBitMask {
                nodeA.removeFromParent()
                nodeB.removeFromParent()
                game?.score = (game?.score ?? 0) + 2
                scoreLabel.text = "SCORE: \(game?.score ?? 0)-100"
            }
        }
    }
}

struct GameView: View {
    @StateObject var gameModel =  GameViewModel()
    @StateObject private var gameData = GameData()
    
    var body: some View {
        SpriteView(scene: gameModel.createGameScene(gameData: gameData))
            .ignoresSafeArea()
            .navigationDestination(isPresented: $gameData.isRules) {
                RulesView()
            }
        
            .navigationDestination(isPresented: $gameData.isWin) {
                WinView()
            }
        
            .navigationDestination(isPresented: $gameData.isLose) {
                LoseView()
            }
        
            .navigationDestination(isPresented: $gameData.isMenu) {
                MenuView()
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView()
}

private extension GameSpriteKit {
    func getRandomBlock() -> [String: UInt32] {
        let allBalls: [String: UInt32] = [ImageName.orangeBlock.rawValue : CBitMask.orangeBlock,
                                          ImageName.yellowBlock.rawValue : CBitMask.yellowBlock,
                                          ImageName.pinkBlock.rawValue : CBitMask.pinkBlock,
                                          ImageName.greenBlock.rawValue : CBitMask.greenBlock,
                                          ImageName.blueBlock.rawValue : CBitMask.blueBlock,
                                          ImageName.purpleBlock.rawValue : CBitMask.purpleBlock]
        return allBalls
    }
    func setupView() {
        let background = SKSpriteNode(imageNamed: ImageName.gameBackgroundImage.rawValue)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        background.xScale = 2
        background.position = (CGPoint(x: size.width / 2, y: size.height / 2))
        addChild(background)
        
        let backgroundBackButton = SKSpriteNode(imageNamed: ImageName.smallButtonBackImage.rawValue)
        backgroundBackButton.size = CGSize(width: size.width / 7, height: size.height / 15)
        backgroundBackButton.name = "backgroundBackButton"
        backgroundBackButton.position = (CGPoint(x: size.width / 10, y: size.height / 1.13))
        addChild(backgroundBackButton)
        
        let arrowButton = SKSpriteNode(imageNamed: ImageName.backArrowImage.rawValue)
        arrowButton.size = CGSize(width: size.width / 15, height: size.height / 30)
        arrowButton.name = "arrowButton"
        arrowButton.position = (CGPoint(x: size.width / 10, y: size.height / 1.13))
        addChild(arrowButton)
        
        let backgroundHelpButton = SKSpriteNode(imageNamed: ImageName.smallButtonBackImage.rawValue)
        backgroundHelpButton.size = CGSize(width: size.width / 7, height: size.height / 15)
        backgroundHelpButton.name = "backgroundHelpButton"
        backgroundHelpButton.position = (CGPoint(x: size.width / 1.1, y: size.height / 1.13))
        addChild(backgroundHelpButton)
        
        let helpButton = SKSpriteNode(imageNamed: ImageName.helpImage.rawValue)
        helpButton.size = CGSize(width: size.width / 20, height: size.height / 30)
        helpButton.position = (CGPoint(x: size.width / 1.1, y: size.height / 1.13))
        helpButton.name = "helpButton"
        addChild(helpButton)
        
        let levelLabel = SKLabelNode(fontNamed: "Yeast22-Regular")
        levelLabel.text = "LEVEL \(self.level)"
        levelLabel.fontSize = 55
        levelLabel.position = (CGPoint(x: size.width / 2, y: size.height / 1.3))
        levelLabel.fontColor = UIColor(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))
        levelLabel.zPosition = 15
        addChild(levelLabel)
        
        let scoreBackImage = SKSpriteNode(imageNamed: ImageName.currenTimeBackgroundImage.rawValue)
        scoreBackImage.size = CGSize(width: size.width / 2.2, height: size.height / 9)
        scoreBackImage.position = (CGPoint(x: size.width / 4, y: size.height / 1.45))
        scoreBackImage.zPosition = 15
        addChild(scoreBackImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Yeast22-Regular")
        scoreLabel.text = "SCORE: 0-100"
        scoreLabel.fontSize = 18
        scoreLabel.zPosition = 15
        scoreLabel.position = (CGPoint(x: size.width / 3.35, y: size.height / 1.47))
        scoreLabel.fontColor = UIColor(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))
        addChild(scoreLabel)
        
        let scoreImage = SKSpriteNode(imageNamed: ImageName.scoreImage.rawValue)
        scoreImage.size = CGSize(width: size.width / 10, height: size.height / 20)
        scoreImage.zPosition = 15
        scoreImage.position = (CGPoint(x: size.width / 8.5, y: size.height / 1.45))
        addChild(scoreImage)
        
        let timeBackImage = SKSpriteNode(imageNamed: ImageName.currenTimeBackgroundImage.rawValue)
        timeBackImage.size = CGSize(width: size.width / 2.2, height: size.height / 9)
        timeBackImage.zPosition = 15
        timeBackImage.position = (CGPoint(x: size.width / 1.35, y: size.height / 1.45))
        addChild(timeBackImage)
        
        timeLabel = SKLabelNode(fontNamed: "Yeast22-Regular")
        timeLabel.text = "TIME: \(String(describing: game!.timeLeft / 60)):\(String(describing: game!.timeLeft % 60))"
        timeLabel.fontSize = 18
        timeLabel.zPosition = 15
        timeLabel.position = (CGPoint(x: size.width / 1.26, y: size.height / 1.47))
        timeLabel.fontColor = UIColor(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))
        addChild(timeLabel)
        
        let timeImage = SKSpriteNode(imageNamed: ImageName.timeImage.rawValue)
        timeImage.size = CGSize(width: size.width / 10, height: size.height / 20)
        timeImage.zPosition = 15
        timeImage.position = (CGPoint(x: size.width / 1.65, y: size.height / 1.45))
        addChild(timeImage)
        
        let timeBonusButton = SKSpriteNode(imageNamed: ImageName.timeBackgroundGameImage.rawValue)
        timeBonusButton.size = CGSize(width: size.width / 4, height: size.height / 13)
        timeBonusButton.zPosition = 15
        timeBonusButton.position = (CGPoint(x: size.width / 4, y: size.height / 1.7))
        addChild(timeBonusButton)
        
        let timeBonusCount = SKSpriteNode(imageNamed: ImageName.smallButtonForLevelsImage.rawValue)
        timeBonusCount.size = CGSize(width: size.width / 8, height: size.width / 8)
        timeBonusCount.zPosition = 15
        timeBonusCount.position = (CGPoint(x: size.width / 7.6, y: size.height / 1.77))
        addChild(timeBonusCount)
        
        let doubleBonusCount = SKSpriteNode(imageNamed: ImageName.smallButtonForLevelsImage.rawValue)
        doubleBonusCount.size = CGSize(width: size.width / 8, height: size.width / 8)
        doubleBonusCount.zPosition = 16
        doubleBonusCount.position = (CGPoint(x: size.width / 1.15, y: size.height / 1.77))
        addChild(doubleBonusCount)
        
        doubleBonusCountLabel = SKLabelNode(fontNamed: "Yeast22-Regular")
        doubleBonusCountLabel.text = "2"
        doubleBonusCountLabel.fontSize = 25
        doubleBonusCountLabel.zPosition = 16
        doubleBonusCountLabel.position = (CGPoint(x: size.width / 1.155, y: size.height / 1.805))
        doubleBonusCountLabel.fontColor = UIColor(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))
        addChild(doubleBonusCountLabel)
        
        timeBonusCountLabel = SKLabelNode(fontNamed: "Yeast22-Regular")
        timeBonusCountLabel.text = "2"
        timeBonusCountLabel.fontSize = 25
        timeBonusCountLabel.zPosition = 15
        timeBonusCountLabel.position = (CGPoint(x: size.width / 7.9, y: size.height / 1.805))
        timeBonusCountLabel.fontColor = UIColor(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))
        addChild(timeBonusCountLabel)
        
        let scoreBonusButton = SKSpriteNode(imageNamed: ImageName.doubleScoreBackgroundGameImage.rawValue)
        scoreBonusButton.size = CGSize(width: size.width / 4, height: size.height / 13)
        scoreBonusButton.zPosition = 15
        scoreBonusButton.position = (CGPoint(x: size.width / 1.33, y: size.height / 1.7))
        addChild(scoreBonusButton)
        
        lineImage = SKSpriteNode(imageNamed: ImageName.lineWithArrowImage.rawValue)
        lineImage.size = CGSize(width: size.width, height: size.height / 20)
        lineImage.position = (CGPoint(x: size.width / 2, y: size.height / 1.9))
        addChild(lineImage)
    }
    func setupBlocks() {
        for row in 0..<35 {
            for column in 0..<game!.numberOfBlocks {
                let randomBlock = getRandomBlock().keys.randomElement() ?? ""
                let massiveBlock = BlockNode(texture: SKTexture(imageNamed: randomBlock),
                                             position: (CGPoint(x: size.width / game!.moveToDisct + CGFloat(column * Int(game!.sizeOfBlock)),
                                                                y: size.height / 9 - CGFloat(row * Int(game!.sizeOfBlock)))),
                                             categoryBitMask: getRandomBlock()[randomBlock] ?? 0,
                                             contactTestBitMask: getRandomBlock()[randomBlock] ?? 0,
                                             size: game!.sizeOfBlock)
                massiveBlock.physicsBody?.collisionBitMask = 0
                massiveBlock.name = "massiveBlock"
                
                let moveTo = lineImage.position.y + massiveBlock.size.width / 2
                let moveAction = SKAction.moveTo(y: moveTo - Double((row + 1) * Int(game!.sizeOfBlock)), duration: 120)
   
                massiveBlock.run(moveAction, withKey: "moveAction")
                self.addChild(massiveBlock)
                nodes.append(massiveBlock)
            }
        }
    }
}
