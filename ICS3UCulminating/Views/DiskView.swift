import SwiftUI

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

#Preview {
    DiskView(disk: Disk(id: 1, size: 3))
}
