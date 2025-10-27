import SwiftUI

struct CarouselView: View {
    let items: [Country]
    @Binding var currentIndex: Int
    @State private var scrollPosition: Int?
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            carouselScrollView(screenWidth: screenWidth)
        }
    }
    
    private func carouselScrollView(screenWidth: CGFloat) -> some View {
        let cardWidth = screenWidth - 80
        let cardHeight = cardWidth
        let centerHeight = cardHeight + 40
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    cardItem(index: index, item: item, screenWidth: screenWidth, cardWidth: cardWidth, cardHeight: cardHeight, centerHeight: centerHeight)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 40)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $scrollPosition)
        .onAppear {
            if scrollPosition == nil {
                scrollPosition = 0
                currentIndex = 0
            }
        }
        .onChange(of: scrollPosition) { oldValue, newValue in
            if let newValue = newValue {
                currentIndex = newValue
            }
        }
    }
    
    private func cardItem(index: Int, item: Country, screenWidth: CGFloat, cardWidth: CGFloat, cardHeight: CGFloat, centerHeight: CGFloat) -> some View {
        GeometryReader { itemGeometry in
            let itemFrame = itemGeometry.frame(in: .global)
            let itemCenter = itemFrame.midX
            let screenCenter = screenWidth / 2
            let distance = abs(itemCenter - screenCenter)
            let maxDistance = screenWidth / 2
            
            let progress = 1 - min(distance / maxDistance, 1.0)
            let dynamicHeight = cardHeight + (40 * progress)
            let dynamicWidth = cardWidth - (40 * progress)
            let opacity = 0.6 + (0.4 * progress)
            let verticalOffset = -20 * progress
            
            cardContent(item: item, dynamicWidth: dynamicWidth, dynamicHeight: dynamicHeight, opacity: opacity, verticalOffset: verticalOffset, progress: progress, screenWidth: screenWidth)
        }
        .frame(width: cardWidth, height: centerHeight)
        .overlay(
            GeometryReader { overlayGeo in
                let itemFrame = overlayGeo.frame(in: .global)
                let itemCenter = itemFrame.midX
                let screenCenter = screenWidth / 2
                let distance = abs(itemCenter - screenCenter)
                let maxDistance = screenWidth / 2
                let progress = 1 - min(distance / maxDistance, 1.0)
                
                Color.clear
                    .zIndex(progress > 0.7 ? 1000 : 1)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .id(index)
    }
    
    private func cardContent(item: Country, dynamicWidth: CGFloat, dynamicHeight: CGFloat, opacity: CGFloat, verticalOffset: CGFloat, progress: CGFloat, screenWidth: CGFloat) -> some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: item.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.gray.opacity(0.1)
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: dynamicWidth, height: dynamicHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
            .frame(width: dynamicWidth, height: dynamicHeight)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.countryName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 2)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                
                HStack {
                    Text("12K+ Visas on Atlys")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color(red: 0.4, green: 0, blue: 0.8))
                }
                .cornerRadius(6)
            }
            .padding(.leading, 16)
            .padding(.bottom, 16)
        }
        .frame(width: dynamicWidth, height: dynamicHeight)
        .opacity(opacity)
        .offset(y: verticalOffset)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.15)
            Image(systemName: "photo")
                .imageScale(.large)
                .foregroundColor(.gray)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
