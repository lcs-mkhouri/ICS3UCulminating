//
//  hanoiViewModel.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import Foundation
import Observation

// STEP 2: The ViewModel
// This class manages the state of our game.

@Observable
class HanoiViewModel {
    
    // MARK: - Stored properties
    
    // An array of three arrays, each representing a tower (rod).
    var towers: [[Disk]] = [[], [], []]
    
    // How many disks are we playing with?
    var diskCount: Int = 3
    
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
    }
}
