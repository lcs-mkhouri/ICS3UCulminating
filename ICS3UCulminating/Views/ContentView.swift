//
//  contentView.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import SwiftUI

// STEP 4 & 6: Assembling the Board
// This view brings together the ViewModel and the visual components.

struct ContentView: View {
    
    // MARK: - Stored properties
    
    // The @State property wrapper works with @Observable classes to keep the UI in sync.
    @State var viewModel: HanoiViewModel = HanoiViewModel(numberOfDisks: 3)
    
    // Controls the visibility of the starting splash screen
    @State var showSplash: Bool = true
    
    // Controls the visibility of the history page
    @State var showHistory: Bool = false
    
    // MARK: - Computed properties
    
    var body: some View {
        ZStack {
            if showSplash {
                // The Starting Page
                LaunchView {
                    self.showSplash = false
                }
                .transition(.asymmetric(
                    insertion: .identity,
                    removal: .move(edge: .top).combined(with: .opacity)
                ))
            } else {
                // Main Game Content
                gameContent
                    .transition(.opacity)
            }
        }
        // Presents the history as a separate page
        .sheet(isPresented: $showHistory) {
            HistoryView(history: viewModel.history)
        }
    }
    
    // Extracted game content to keep the body clean
    var gameContent: some View {
        VStack(spacing: 30) {
            
            // 1. Title Section
            VStack(spacing: 8) {
                Text("Tower of Hanoi")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                
                Text("Solve the ancient puzzle")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top)
            
            // 2. The Towers (The Game Board)
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(0..<3) { index in
                    TowerView(
                        disks: viewModel.towers[index],
                        index: index,
                        isSelected: viewModel.selectedTowerIndex == index,
                        action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                viewModel.selectTower(at: index)
                            }
                        }
                    )
                }
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 24))
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
            
            // 3. Status Section
            VStack(spacing: 15) {
                Text(viewModel.message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(height: 60)
                    .padding(.horizontal)
                    .foregroundStyle(viewModel.message.contains("Victory") ? .green : .primary)
                
                Label("Moves: \(viewModel.moveCount)", systemImage: "arrow.left.and.right.circle")
                    .font(.title3.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(.capsule)
            }
            
            // 4. Game Controls
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    // Reset Button
                    Button(role: .destructive, action: {
                        withAnimation {
                            viewModel.resetGame()
                        }
                    }) {
                        Label("Reset", systemImage: "arrow.clockwise")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.red.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 14))
                    }
                    
                    // Difficulty Button
                    Button(action: {
                        withAnimation {
                            var nextCount: Int = viewModel.diskCount + 1
                            if nextCount > 5 {
                                nextCount = 3
                            }
                            viewModel.diskCount = nextCount
                            viewModel.resetGame()
                        }
                    }) {
                        Label("\(viewModel.diskCount) Disks", systemImage: "list.number")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.orange.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 14))
                    }
                }
                
                // NEW: Button to open History Page
                Button(action: {
                    showHistory = true
                }) {
                    Label("View History", systemImage: "clock.arrow.circlepath")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue.gradient)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 14))
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
