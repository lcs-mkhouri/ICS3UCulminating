//
//  contentView.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import SwiftUI

// STEP 4 & 6: Assembling the Board
// This view brings together the ViewModel and the visual components.

struct contentView: View {
    
    // MARK: - Stored properties
    
    // The @State property wrapper works with @Observable classes to keep the UI in sync.
    @State var viewModel: HanoiViewModel = HanoiViewModel(numberOfDisks: 3)
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 30) {
            
            // 1. Title Section
            VStack(spacing: 5) {
                Text("Tower of Hanoi")
                    .font(.largeTitle)
                    .bold()
                
                Text("Strategy Puzzle")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top)
            
            // 2. The Towers (The Game Board)
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(0..<3) { index in
                    TowerView(
                        disks: viewModel.towers[index],
                        index: index,
                        isSelected: viewModel.selectedTowerIndex == index,
                        action: {
                            viewModel.selectTower(at: index)
                        }
                    )
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
            
            // 3. Status Section
            VStack(spacing: 15) {
                // Game Message (e.g., "Invalid Move", "Victory!")
                Text(viewModel.message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .padding(.horizontal)
                
                // Move Counter
                HStack {
                    Image(systemName: "arrow.left.and.right.circle")
                    Text("Moves: \(viewModel.moveCount)")
                        .bold()
                }
                .font(.title3)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            }
            
            // 4. Game Controls
            HStack(spacing: 20) {
                // Reset Button
                Button(action: {
                    viewModel.resetGame()
                }) {
                    Label("Reset", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 120)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // Difficulty Button
                Button(action: {
                    // Cycle disks between 3, 4, and 5
                    var nextCount: Int = viewModel.diskCount + 1
                    if nextCount > 5 {
                        nextCount = 3
                    }
                    viewModel.diskCount = nextCount
                    viewModel.resetGame()
                }) {
                    Label("\(viewModel.diskCount) Disks", systemImage: "list.number")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 120)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    contentView()
}
