//
//  contentView.swift
//  ICS3UCulminating
//
//  Created by Michel Khouri on 2026-06-01.
//

import SwiftUI

// STEP 4: Assembling the Board
// This view brings together the ViewModel and the visual components.

struct contentView: View {
    
    // MARK: - Stored properties
    
    // The @State property wrapper works with @Observable classes to keep the UI in sync.
    @State var viewModel: HanoiViewModel = HanoiViewModel(numberOfDisks: 3)
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 40) {
            
            // 1. Title
            Text("Tower of Hanoi")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            // 2. The Towers
            // We show all three towers from the ViewModel.
            HStack(alignment: .bottom, spacing: 20) {
                ForEach(0..<3) { index in
                    TowerView(
                        disks: viewModel.towers[index],
                        index: index
                    )
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
            
            // 3. Game Controls
            Button(action: {
                viewModel.resetGame()
            }) {
                Label("Reset Game", systemImage: "arrow.clockwise")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    contentView()
}
