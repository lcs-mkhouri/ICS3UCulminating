import SwiftUI

// MARK: - Launch View
// This is the starting page that shows the title.
// The user must tap the "Start Game" button to proceed.

struct LaunchView: View {
    
    // MARK: - Stored properties
    
    // Closure to call when the button is tapped
    let onStart: () -> Void
    
    // MARK: - Computed properties
    var body: some View {
        ZStack {
            // Background
            Color.blue
                .ignoresSafeArea()
            
            // Subtle background gradient
            LinearGradient(
                colors: [.clear, .black.opacity(0.15)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                // Game Info
                VStack(spacing: 25) {
                    // Game Icon
                    Image(systemName: "trapezoid.and.line.vertical")
                        .font(.system(size: 90))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 10)
                    
                    VStack(spacing: 10) {
                        // Game Title
                        Text("Tower of Hanoi")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        // Game Subtitle
                        Text("A Classic Strategic Challenge")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Start Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        onStart()
                    }
                }) {
                    Text("Start Game")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.blue)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 40)
                        .background(.white)
                        .clipShape(.capsule)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                }
                .padding(.bottom, 60)
            }
        }
    }
}

#Preview {
    LaunchView(onStart: {})
}
