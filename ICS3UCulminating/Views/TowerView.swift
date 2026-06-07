import SwiftUI

// MARK: - Tower View
// Represents a rod and the stack of disks on it.

struct TowerView: View {
    
    // MARK: - Stored properties
    let disks: [Disk]
    let index: Int
    let isSelected: Bool
    let action: () -> Void
    
    // MARK: - Computed properties
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                // The Rod (the background pole)
                Capsule()
                    .fill(.secondary.opacity(0.2))
                    .frame(width: 8, height: 160)
                
                // The stack of disks
                VStack(spacing: 2) {
                    // We display disks from top down.
                    ForEach(self.reverse(disks)) { disk in
                        DiskView(disk: disk)
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                    }
                }
                .padding(.bottom, 4)
            }
            .frame(width: 140, height: 180)
            .background {
                // Background shape with selection feedback
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.primary.opacity(0.03))
            }
            .clipShape(.rect(cornerRadius: 16))
            .overlay {
                // Selection border
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            }
            .contentShape(Rectangle()) // Ensures the whole area is tappable
            .onTapGesture {
                action()
            }
            
            Text("T\(index + 1)")
                .font(.caption)
                .bold()
                .foregroundStyle(isSelected ? .blue : .primary)
                .padding(.top, 4)
        }
    }
    
    // MARK: - Functions
    func reverse(_ input: [Disk]) -> [Disk] {
        var result: [Disk] = []
        for i in (0..<input.count).reversed() {
            result.append(input[i])
        }
        return result
    }
}

#Preview {
    TowerView(disks: [Disk(id: 1, size: 3)], index: 0, isSelected: false, action: {})
}
