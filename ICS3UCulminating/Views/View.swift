import SwiftUI

// STEP 3: Visual Components

// MARK: - Disk View
// Represents a single disk on a tower.
struct DiskView: View {
    
    // MARK: - Stored properties
    let disk: Disk
    
    // MARK: - Computed properties
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(self.color(for: disk.size))
            // The width grows with the size of the disk
            .frame(width: CGFloat(disk.size) * 30, height: 18)
            .overlay(
                Text("\(disk.size)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .bold()
            )
    }
    
    // MARK: - Functions
    func color(for size: Int) -> Color {
        let colors: [Color] = [.red, .orange, .blue, .green, .purple]
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
    
    // MARK: - Computed properties
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                // The Rod (the background pole)
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 6, height: 150)
                
                // The stack of disks
                VStack(spacing: 2) {
                    // We display disks from top down.
                    // Our array has the top disk at the end, so we reverse it.
                    ForEach(self.reverse(disks)) { disk in
                        DiskView(disk: disk)
                    }
                }
                .padding(.bottom, 2)
            }
            .frame(width: 120, height: 160)
            
            Text("Tower \(index + 1)")
                .font(.caption)
                .bold()
        }
    }
    
    // MARK: - Functions
    // Explicitly reversing the array to follow coding guidelines (no higher-order functions)
    func reverse(_ input: [Disk]) -> [Disk] {
        var result: [Disk] = []
        for i in (0..<input.count).reversed() {
            result.append(input[i])
        }
        return result
    }
}
