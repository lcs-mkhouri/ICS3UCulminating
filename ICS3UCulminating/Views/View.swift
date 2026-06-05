import SwiftUI

// STEP 3 & 6: Visual Components

// MARK: - Disk View
// Represents a single disk on a tower.
struct DiskView: View {
    
    // MARK: - Stored properties
    let disk: Disk
    
    // MARK: - Computed properties
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(self.color(for: disk.size).gradient) // Added gradient for depth
            // The width grows with the size of the disk
            .frame(width: CGFloat(disk.size) * 35, height: 22)
            .overlay {
                Text("\(disk.size)")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .bold()
            }
            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Functions
    func color(for size: Int) -> Color {
        let colors: [Color] = [.red, .orange, .blue, .green, .purple, .pink]
        let index: Int = (size - 1) % colors.count
        return colors[index]
    }
}

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
            .clipShape(.rect(cornerRadius: 16)) // Modern clipShape API
            .overlay {
                // Selection border
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            }
            .contentShape(Rectangle()) // Ensures the whole area is tappable
            .onTapGesture {
                action()
            }
            
            Text("Tower \(index + 1)")
                .font(.subheadline)
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
