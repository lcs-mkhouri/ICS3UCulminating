//
//  hanoiViewModel.swift
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
    
    // MARK: - Initializer
    
    init(numberOfDisks: Int = 3) {
        self.diskCount = numberOfDisks
        self.resetGame()
    }
    
    // MARK: - Functions
    
    func resetGame() {
        // 1. Create three empty towers
        var newTowers: [[Disk]] = [[], [], []]
        
        // 2. Add disks to the first tower (index 0)
        // We add them largest to smallest so the top is the smallest disk.
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
    
    // This function is called when a user taps a tower.
    func selectTower(at index: Int) {
        if let fromIndex: Int = selectedTowerIndex {
            // SECOND TAP: We already have a tower selected.
            // If user taps the same tower, we just deselect it.
            if fromIndex == index {
                selectedTowerIndex = nil
                message = "Tower \(index + 1) deselected."
            } else {
                // Try to move from the first tower tapped to this one.
                moveDisk(from: fromIndex, to: index)
                selectedTowerIndex = nil // Clear selection after the move attempt
            }
        } else {
            // FIRST TAP: No tower is selected yet.
            // Only select if the tower is not empty.
            if towers[index].isEmpty == false {
                selectedTowerIndex = index
                message = "Tower \(index + 1) selected. Tap a destination."
            } else {
                message = "That tower is empty!"
            }
        }
    }
    
    // Internal logic for moving a disk and checking rules.
    func moveDisk(from fromIndex: Int, to toIndex: Int) {
        // 1. Get the top disk from the source tower.
        guard let diskToMove: Disk = towers[fromIndex].last else {
            return
        }
        
        // 2. Decide if the move is allowed.
        var isValid: Bool = false
        
        if let targetTopDisk: Disk = towers[toIndex].last {
            // Rule: Small disk on top of Large disk ONLY.
            if diskToMove.size < targetTopDisk.size {
                isValid = true
            } else {
                message = "Invalid: Cannot place a larger disk on a smaller one!"
            }
        } else {
            // Rule: Any disk can go on an empty tower.
            isValid = true
        }
        
        // 3. If valid, perform the move and check if the player won.
        if isValid == true {
            towers[fromIndex].removeLast()
            towers[toIndex].append(diskToMove)
            moveCount += 1
            message = "Moved to Tower \(toIndex + 1)."
            
            checkWinCondition()
        }
    }
    
    func checkWinCondition() {
        // You win if all disks are on the third tower (index 2).
        if towers[2].count == diskCount {
            message = "Victory! You won in \(moveCount) moves."
        }
    }
}
