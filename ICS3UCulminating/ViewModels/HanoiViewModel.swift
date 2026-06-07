//
//  HanoiViewModel.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import Foundation
import Observation

// STEP 2 & 5: The ViewModel
// This class manages the state and rules of our game.

@Observable
class HanoiViewModel {
    
    // MARK: - Stored properties
    
    // An array of three arrays, each representing a tower (rod).
    var towers: [[Disk]] = [[], [], []]
    
    // How many disks are we playing with?
    var diskCount: Int = 3
    
    // Memory to store which tower was tapped first (the source).
    var selectedTowerIndex: Int? = nil
    
    // Track the number of moves made.
    var moveCount: Int = 0
    
    // Message to display to the user.
    var message: String = "Move all disks to the third tower."
    
    // Store a list of previous game results.
    var history: [GameResult] = []
    
    // MARK: - Initializer
    
    init(numberOfDisks: Int = 3) {
        self.diskCount = numberOfDisks
        self.resetGame()
        self.loadHistory() // Load saved games when the app starts
    }
    
    // MARK: - Functions
    
    func resetGame() {
        // 1. Create three empty towers
        var newTowers: [[Disk]] = [[], [], []]
        
        // 2. Add disks to the first tower (index 0)
        for i in 0..<diskCount {
            let diskSize: Int = diskCount - i
            let newDisk: Disk = Disk(id: i, size: diskSize)
            newTowers[0].append(newDisk)
        }
        
        // 3. Update our state
        self.towers = newTowers
        self.selectedTowerIndex = nil
        self.moveCount = 0
        self.message = "Move all disks to the third tower."
    }
    
    func selectTower(at index: Int) {
        if let fromIndex: Int = selectedTowerIndex {
            if fromIndex == index {
                selectedTowerIndex = nil
                message = "Tower \(index + 1) deselected."
            } else {
                moveDisk(from: fromIndex, to: index)
                selectedTowerIndex = nil
            }
        } else {
            if towers[index].isEmpty == false {
                selectedTowerIndex = index
                message = "Tower \(index + 1) selected. Tap a destination."
            } else {
                message = "That tower is empty!"
            }
        }
    }
    
    func moveDisk(from fromIndex: Int, to toIndex: Int) {
        guard let diskToMove: Disk = towers[fromIndex].last else {
            return
        }
        
        var isValid: Bool = false
        if let targetTopDisk: Disk = towers[toIndex].last {
            if diskToMove.size < targetTopDisk.size {
                isValid = true
            } else {
                message = "Invalid: Cannot place a larger disk on a smaller one!"
            }
        } else {
            isValid = true
        }
        
        if isValid == true {
            towers[fromIndex].removeLast()
            towers[toIndex].append(diskToMove)
            moveCount += 1
            message = "Moved to Tower \(toIndex + 1)."
            checkWinCondition()
        }
    }
    
    func checkWinCondition() {
        if towers[2].count == diskCount {
            message = "Victory! You won in \(moveCount) moves."
            
            // Save this game to the history list
            let result: GameResult = GameResult(diskCount: diskCount, moveCount: moveCount)
            self.history.append(result)
            
            self.saveHistory() // Persist to JSON file
        }
    }
    
    // MARK: - Persistence Functions (made for exceeding expectations)
    
    // Find the documents directory on the user's device
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Save the history array to a JSON file
    func saveHistory() {
        let url = getDocumentsDirectory().appendingPathComponent("history.json")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(history)
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
            print("History saved successfully.")
        } catch {
            print("Failed to save history: \(error.localizedDescription)")
        }
    }
    
    // Load the history array from the JSON file
    func loadHistory() {
        let url = getDocumentsDirectory().appendingPathComponent("history.json")
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.history = try decoder.decode([GameResult].self, from: data)
                print("History loaded successfully.")
            } catch {
                print("Failed to load history: \(error.localizedDescription)")
            }
        }
    }
}
