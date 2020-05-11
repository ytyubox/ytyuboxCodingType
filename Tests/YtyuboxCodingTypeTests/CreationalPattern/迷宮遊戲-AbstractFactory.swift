//
// 迷宮遊戲-AbstractFactory.swift
//  
//
//  Created by 游宗諭 on 2020/5/11.
//

//                                   ┌────────────┐
//                                   │  MapSite   │
//                 ┌──────────────4─>│            │
//                 │                 ├────────────┤
//                 │                 │  Enter()   │
//                 │                 │            │
//                 │                 └────────────┘
//                 │                        △
//                 │         ┌──────────────┼──────────────┐
//                 │         │              │              │
//                 │         │              │              │
// ┌─────────┐     │  ┌────────────┐ ┌────────────┐ ┌────────────┐
// │  Maze   │   sides│    Room    │ │  MapSite   │ │  MapSite   │
// ├─────────┤     └──│            │ │            │ │            │
// │         │        ├────────────┤ ├────────────┤ ├────────────┤
// │AddRoom()│        │ roomNumber │ │            │ │   isOpen   │
// │RoomNo() │        ├────────────┤ ├────────────┤ ├────────────┤
// │         │        │  Enter()   │ │  Enter()   │ │  Enter()   │
// │         │        │ SetSide()  │ │            │ │            │
// └─────────┘        │ GetSide()  │ └────────────┘ └────────────┘
//                    └────────────┘

/// 抽象工廠可以確保繼承類別執行型別抹除後, 同一系別的物件執行 type casting 還原必定成功
/// 
import Foundation

 
enum Direction {
  case North, South, East, West
}

protocol MapSite {
  func enter()
}

class AnyMapSite:MapSite {
  func enter() { fatalError()}
}

class Room:MapSite {
  func enter() {
    
  }
  let roomNumber: Int
  init(_ roomNo:Int) {
    self.roomNumber = roomNo
  }
  func getSide(_ direction:Direction) -> MapSite {
    sides[direction]!
  }
  func setSide(_ direction: Direction, _ mapsite: MapSite) {
    sides[direction] = mapsite
  }
  var sides:[Direction:MapSite] = [:]
  
}
class Maze {
  var allRoom:[Int:Room] = [:]
  func addRoom(_ room: Room) {
    allRoom[room.roomNumber] = room
  }
  func roomNo(_ const: Int) -> Room {
    allRoom[const]!
  }
}
class Wall: MapSite{
  func enter() {
  }
  
}
class Door:MapSite {
  func enter() {
    
  }
  init(_ r1:Room, r2:Room) {
    room1 = r1
    room2 = r2
  }
  func otherSideFrom(_ r: Room) -> Room {
    return r === room1 ? room2 : room1
  }
  let room1:Room
  let room2:Room
  var isOpen = false
}


class MazeFactory {
  init() { }
  func makeMaze() -> Maze {
    return Maze()
  }
  func makeWall() -> Wall {Wall()}
  func makeRoom(_ n:Int) -> Room {Room(n)}
  func makeDoor(_ r1:Room,_ r2: Room) -> Door { Door(r1, r2: r2)}
}

class mazeGame {
  func createMaze(_ factory: MazeFactory) -> Maze{
    let aMaze = factory.makeMaze()
    let r1 = factory.makeRoom(1)
    let r2 = factory.makeRoom(2)
    let aDoor = factory.makeDoor(r1, r2)
    aMaze.addRoom(r1)
    aMaze.addRoom(r2)
    r1.setSide(.North, factory.makeWall())
    r1.setSide(.East, aDoor)
    r1.setSide(.South, factory.makeWall())
    r1.setSide(.West, factory.makeWall())
    
    r2.setSide(.North, factory.makeWall())
    r2.setSide(.East, factory.makeWall())
    r2.setSide(.South, factory.makeWall())
    r2.setSide(.West, aDoor)
    return aMaze
    
  }
}

// MARK: - EnchantedMaze 魔法迷宮

class EnchantedMazeFactory: MazeFactory {
  override func makeRoom(_ n: Int) -> Room {
    EnchantedRoom(n, castSpell())
  }
  class EnchantedRoom: Room {
    init(_ n:Int,_ spell: EnchantedMazeFactory.Spell) {
      self.spell = spell
      super.init(n)
    }
    
    var spell:Spell
  }
  struct Spell {
    var message:String
  }
  private func castSpell() -> Spell {
    Spell(message: (1...5).map{_ in "abcdefghi".randomElement()!}.map(String.init).joined())
  }
}
