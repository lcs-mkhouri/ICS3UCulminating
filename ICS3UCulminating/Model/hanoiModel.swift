//
//  hanoiModel.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import Foundation

// STEP 1: Define the Disk model
// This represents a single disk in the game.
struct Disk: Identifiable {
    let id: Int      // A unique ID so SwiftUI can track it
    let size: Int    // The width of the disk (larger number = wider disk)
}

// NEW: Define the GameResult model
// This stores the results of a completed game.
struct GameResult: Identifiable {
    let id: UUID = UUID()
    let diskCount: Int
    let moveCount: Int
}
