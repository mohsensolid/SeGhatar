//
//  HomePresenterTest.swift
//  SeGhatarTests
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import XCTest
@testable import SeGhatar

class HomePresenterTest: XCTestCase {
    var presenter:HomePresenter?
    var mock = MockHomeController()
    var gameMangerMock = GameManagerMock()
    var scoreManagerMock = ScoreManagerMock()
    override func setUp() {
        presenter = HomePresenter(delegate: mock)
        presenter?.gameManager = gameMangerMock
        presenter?.scoreManager = scoreManagerMock
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testTwoPlayerTappedClearBoardAndSetGameManager(){
        presenter?.twoPlayerSelected()
        let manager = presenter?.gameManager
        XCTAssert(manager is LocalGameManager)
        XCTAssertTrue(scoreManagerMock.resetTheGameVerify)
        XCTAssertTrue(mock.hideOpponentFinderVerify)
        XCTAssertTrue(mock.clearChatVerify)
        XCTAssertTrue(mock.toggleGameOptionVerify)
        XCTAssertTrue(mock.resetBoradVerfiy)
        XCTAssertTrue(mock.hideChatBoxVerify)
    }
    func testOnlinePlayerTappedClearBoardAnSetGameManager() {
        presenter?.onlineGameSelected()
        let manager = presenter?.gameManager
        XCTAssert(manager is OnlineGameManager)
        XCTAssertTrue(scoreManagerMock.resetTheGameVerify)
        XCTAssertTrue(mock.showChatBoxVerify)
        XCTAssertTrue(mock.clearChatVerify)
        XCTAssertTrue(mock.toggleGameOptionVerify)
        XCTAssertTrue(mock.resetBoradVerfiy)
        XCTAssertTrue(mock.showChatBoxVerify)
    }
    func testAiPlayerTappedClearBoardAndSetGameManager(){
        presenter?.aiGameSelected()
        let manager = presenter?.gameManager
        XCTAssert(manager is AiGameManager)
        XCTAssertTrue(scoreManagerMock.resetTheGameVerify)
        XCTAssertTrue(mock.hideOpponentFinderVerify)
        XCTAssertTrue(mock.clearChatVerify)
        XCTAssertTrue(mock.toggleGameOptionVerify)
        XCTAssertTrue(mock.resetBoradVerfiy)
        XCTAssertTrue(mock.hideChatBoxVerify)
    }
    
    func testResetTappedClearBoardAndSetGameManager(){
        presenter?.resetSelected()
        XCTAssertTrue(scoreManagerMock.resetTheGameVerify)
        XCTAssertTrue(gameMangerMock.restartVerfiy)
        XCTAssertTrue(mock.clearChatVerify)
        XCTAssertTrue(mock.toggleGameOptionVerify)
        XCTAssertTrue(mock.resetBoradVerfiy)
    }
    func testSendMessage(){
        presenter?.sendMessage(msg: "Hi")
        XCTAssertTrue(gameMangerMock.sendMessageVerify)
    }
    func testEmptyMessageNotSend(){
        presenter?.sendMessage(msg: "")
        XCTAssertFalse(gameMangerMock.sendMessageVerify)
    }
    func testCellTappedAtWhenNoGameManager(){
      let  pre = HomePresenter(delegate: mock)
        pre.cellTappedAt(row: 2, col: 1, layer: 2)
        XCTAssertTrue(mock.gameMangerNotSelectedVerify)
    }
    func testCellTappedAt(){
        presenter?.cellTappedAt(row: 2, col: 2, layer: 2)
        XCTAssertFalse(mock.gameMangerNotSelectedVerify)
        XCTAssertTrue(gameMangerMock.cellTappedVerify)
    }
    func testIsYourTurn(){
        presenter?.isYourTurn()
        XCTAssertTrue(gameMangerMock.isYourTurnVerify)
    }
    func testIsGameEndedAndBlueWin(){
        presenter?.gameIsEnded(redScore: 1, blueScore: 2)
        XCTAssertTrue(mock.gameIsEndVerify)
        XCTAssertEqual(mock.title, "ابی برنده شد")
        let message = "ابی = \(2) قرمز = \(1)"
        XCTAssertEqual(mock.message,message)

    }
    func testIsGameEndedAndRedWin(){
        presenter?.gameIsEnded(redScore: 2, blueScore: 1)
        XCTAssertTrue(mock.gameIsEndVerify)
        XCTAssertEqual(mock.title, "قرمز برنده شد")
        let message = "ابی = \(1) قرمز = \(2)"
        XCTAssertEqual(mock.message,message)
    }
    func testIsGameEndAndEqual(){
        presenter?.gameIsEnded(redScore: 2, blueScore: 2)
        XCTAssertTrue(mock.gameIsEndVerify)
        XCTAssertEqual(mock.title, "مساوری")
        let message = "ابی = \(2) قرمز = \(2)"
        XCTAssertEqual(mock.message,message)
    }
    func testScoreChange(){
        presenter?.score(redScore: 2, blueScore: 2)
        XCTAssertTrue(mock.redScore == 2)
        XCTAssertTrue(mock.blueScore == 2)
    }
    func testScoreManagerNotfiyChange(){
        presenter?.changeItemAt(row: 2, col: 2, layer: 2, player: Player.Red)
         XCTAssertTrue(scoreManagerMock.cellChangeAtVerify)
        XCTAssertTrue(mock.changeColorVerify)
    }
    func testNewMessageRecive(){
        presenter?.newMessageRecive(message: "salam", player: true)
        XCTAssertTrue(mock.newMessageRecivedVerify)
        let message = MessageModel(message: "salam", sender: true)
        XCTAssertEqual(mock.messsageModl!, message)

    }
    func oppnentFinded(){
        presenter?.oppnentFinded()
        XCTAssertTrue(mock.hideOpponentFinderVerify)

    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
