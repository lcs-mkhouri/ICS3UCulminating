import SwiftUI

// MARK: - History View
// This view displays a list of completed games in a separate page.

struct HistoryView: View {
    
    // MARK: - Stored properties
    let history: [GameResult]
    @Environment(\.dismiss) var dismiss // To close the page
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                if history.isEmpty {
                    ContentUnavailableView(
                        "No History Yet",
                        systemImage: "clock.arrow.circlepath",
                        description: Text("Complete a game to see your results here.")
                    )
                } else {
                    // Show most recent games at the top
                    ForEach(self.reverseResults(history)) { result in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(result.diskCount) Disks")
                                    .font(.headline)
                                
                                Text("Moves: \(result.moveCount)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "medal.fill")
                                .foregroundStyle(.orange.gradient)
                                .font(.title3)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Game History")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    func reverseResults(_ results: [GameResult]) -> [GameResult] {
        var reversed: [GameResult] = []
        for i in (0..<results.count).reversed() {
            reversed.append(results[i])
        }
        return reversed
    }
}

#Preview {
    HistoryView(history: [
        GameResult(diskCount: 3, moveCount: 7),
        GameResult(diskCount: 4, moveCount: 15)
    ])
}
