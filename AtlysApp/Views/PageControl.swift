import SwiftUI

struct PageControl: View {
    let totalPages: Int
    let currentPage: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.white : Color.white.opacity(0.35))
                    .frame(width: index == currentPage ? 8 : 6,
                           height: index == currentPage ? 8 : 6)
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentPage)
            }
        }
        .padding(.vertical, 8)
    }
}
