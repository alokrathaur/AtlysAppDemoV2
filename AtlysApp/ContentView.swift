import SwiftUI
import Combine

struct ContentView: View {
    @State private var currentIndex: Int = 0
    @State private var phoneNumber: String = ""
    
    private let countries: [Country] = {
        let image1 = "https://media.istockphoto.com/id/845702822/photo/top-view-of-the-new-downtown-of-amman.jpg?s=612x612&w=0&k=20&c=Bm7uu-rw2jq-zl2zyNvMSy4ZyyZCQthJpec1x0brSUk="
        let image2 = "https://i.guim.co.uk/img/media/55b58f9514a6ccb5a57d59d04151af12864acf69/0_374_5616_3370/master/5616.jpg?width=1200&quality=85&auto=format&fit=max&s=877edba5b55e783567bcbd2b6b006544"
        // Create only 3 items
        return [
            Country(imageUrl: image1, countryName: "Thailand"),
            Country(imageUrl: image2, countryName: "Malaysia"),
            Country(imageUrl: image1, countryName: "Singapore")
        ]
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                contentView
            }
        }
        .background(Color.white)
        .ignoresSafeArea()
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
    }
    
    private var contentView: some View {
        Group {
                // Header
                VStack(spacing: 5) {
                    // Logo Image
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .padding(.top, 50)
                    
                    Text("visas on time")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.4, green: 0, blue: 0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                
                // Carousel with pagination
                VStack(spacing: 0) {
                    CarouselView(items: countries, currentIndex: $currentIndex)
                        .frame(height: 360)
                    
                    // Pagination dots
                    HStack(spacing: 6) {
                        ForEach(0..<countries.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex ? Color.gray : Color.gray.opacity(0.3))
                                .frame(width: index == currentIndex ? 8 : 6,
                                       height: index == currentIndex ? 8 : 6)
                                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentIndex)
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(.vertical, 20)
                
                // Login Section
                VStack(spacing: 20) {
                    Text("Get Visas On Time")
                        .font(.system(size: 26, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    PhoneInputView(phoneNumber: $phoneNumber)
                        .padding(.horizontal, 24)
                    
                    Button(action: {}) {
                        Text("Continue")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.4, green: 0, blue: 0.8))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Text("or")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .padding(.horizontal, 24)
                    
                    HStack(spacing: 16) {
                        socialButton(icon: "globe", color: .blue)
                        socialButton(icon: "apple.logo", color: .black)
                        socialButton(icon: "envelope.fill", color: .black)
                    }
                    .padding(.horizontal, 24)
                    
                    Text("By continuing, you agree to our terms & privacy policy")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 30)
                }
            }
    }
    
    private func socialButton(icon: String, color: Color) -> some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(color)
                .frame(width: 54, height: 54)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}
