//
//  OnlineGameManager.swift
//  SeGhatar
//
//  Created by MAC on 7/26/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
import Starscream

struct SocketRequest:Codable {
    var type:String
    var data:String
}
struct MoveData : Codable{
    var col:Int
    var row:Int
    var layer:Int
    var player:Bool
}
struct MessageData : Codable {
    var msg:String
    var user:Bool
}
struct StateData : Codable{
    var state:String
    //    var user:Bool=false
}
struct InitData: Codable {
    var turn:Bool
}
class OnlineGameManager: GameManagerDelegate {
    
    var isGameStarted:Bool = false
    var yourTurn:Player = Player.None
    var lastTurn:Player = Player.None
    var delegate:GameDelegate?
    var socket:WebSocket?
    init(delegate:GameDelegate) {
        self.delegate = delegate
        socket = WebSocket(url: URL(string: "wss://sebse-ghatar.herokuapp.com/ws/game/random/")!)
        socket?.delegate = self
        socket?.connect()
        
    }
    func isYourTurn() -> Bool {
        return yourTurn != Player.None && isGameStarted && yourTurn != lastTurn
    }
    
    func cellTappedAt(row: Int, col: Int, layer: Int) {
        var player:Bool = false
        if yourTurn == Player.Blue{
            player = false
        }else if yourTurn==Player.Red {
            player = true
        }else if yourTurn == Player.None{
            return
        }
        let move = MoveData(col: col, row: row, layer: layer, player: player)
        do {
            let moveJson = try JSONEncoder().encode(move)
            let jsonString = String(data: moveJson, encoding: .utf8)!
            let request = SocketRequest(type: "move", data: jsonString)
            let requestJson = try JSONEncoder().encode(request)
            let requestString = String(data: requestJson, encoding: .utf8)!
            socket?.write(string: requestString)
        }catch{
            return
        }
        
    }
    
    func dispose() {
        self.delegate = nil
    }
    
    func restart() {
        socket?.disconnect()
        socket?.connect()
    }
    
    func sendMessage(message: String) {
        if isGameStarted{
            let msg = MessageData(msg: message, user: true)
            do {
                let messageJson = try JSONEncoder().encode(msg)
                let jsonString = String(data: messageJson, encoding: .utf8)!
                let request = SocketRequest(type: "message", data: jsonString)
                let requestJson = try JSONEncoder().encode(request)
                let requestString = String(data: requestJson, encoding: .utf8)!
                socket?.write(string: requestString)
            }catch{
                return
            }
        }
    }
}
extension OnlineGameManager:WebSocketDelegate{
    
    func websocketDidConnect(socket: WebSocketClient) {
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        var DataObjWrapped:SocketRequest?
        do {
            let data = text.data(using: .utf8)!
            DataObjWrapped = try JSONDecoder().decode(SocketRequest.self, from: data)
        }catch{
            return
        }
        guard let DataObj = DataObjWrapped else{
            return
        }
        switch DataObj.type {
        case "message":
            let message = DataObj.data.data(using: .utf8)
            guard let messageJson = message else {
                return
            }
            do {
                let messageObj = try JSONDecoder().decode(MessageData.self, from: messageJson)
                var player:Bool?
                if messageObj.user && yourTurn == Player.Red  || !messageObj.user && yourTurn == Player.Blue{
                    player = true
                }else{
                    player = false
                }
                self.delegate?.newMessageRecive(message: messageObj.msg, player: player!)
            }catch{
                return
            }
            
            break
        case "move":
            let move = DataObj.data.data(using: .utf8)
            guard let moveJson = move else{
                return
            }
            do {
                let moveObj = try JSONDecoder().decode(MoveData.self, from: moveJson)
                var player:Player?
                if moveObj.player {
                    player = Player.Red
                }else{
                    player = Player.Blue
                }
                self.lastTurn = player!
                self.delegate?.changeItemAt(row: moveObj.row, col: moveObj.col, layer: moveObj.layer, player:player!)
            }catch{
                return
                
            }
            
            break
        case "init":
            let initString = DataObj.data.data(using: .utf8)
            guard let initJson = initString else{
                return
            }
            do{
                let initObj = try JSONDecoder().decode(InitData.self, from: initJson)
                var player:Player?
                if initObj.turn {
                    player = Player.Red
                }else{
                    player = Player.Blue
                }
                self.yourTurn = player!
            }catch{
                return            }
            
            break
        case "state":
            let state = DataObj.data.data(using: .utf8)
            guard let stateJson = state else{
                return
            }
            do{
                let stateObj = try JSONDecoder().decode(StateData.self, from: stateJson)
                if stateObj.state == "start"{
                    self.isGameStarted = true
                    self.delegate?.oppnentFinded()
                }
            }catch{
                return
                
            }
            
            break
        default:
            break
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
