# Atlys App - Visa Application Carousel

A modern iOS application built with SwiftUI that showcases an interactive country carousel for visa applications, featuring smooth animations, dynamic card scaling, and a clean authentication interface.

## 📱 Features

### 🎠 Interactive Carousel
- **Smooth scrolling** with iOS 17's view-aligned scroll behavior
- **Dynamic card scaling** - Cards grow/shrink based on proximity to center
- **Parallax effects** - 3D-style transformations for depth perception
- **Image loading** - AsyncImage with loading states and error handling
- **Custom pagination** - Animated dot indicators showing current position

### 📞 Authentication Interface
- **Phone number input** with country code selection
- **Country picker** with 12+ supported countries
- **Input validation** - Numeric-only, 10-digit limit
- **Social login buttons** - Google, Apple, Email options
- **Modern UI** - Clean design with purple accent color (#6600CC)

### 🎨 UI/UX Highlights
- Responsive layout adapting to different screen sizes
- Smooth animations and transitions
- Loading states for async image loading
- Placeholder images for failed loads
- Custom corner radii and shadows
- Professional branding with logo support

## 🏗️ Project Structure

```
AtlysApp/
├── AtlysApp.swift                 # App entry point
├── ContentView.swift              # Main view with carousel and login
│
├── Models/
│   └── Country.swift             # Country data model
│
├── Views/
│   ├── CarouselView.swift        # Interactive carousel implementation
│   ├── PageControl.swift         # Pagination dots component
│   └── PhoneInputView.swift      # Phone input with country picker
│
├── Utils/
│   └── ImageCache.swift          # Image caching utility
│
└── Assets.xcassets/
    └── AppIcon.appiconset/       # App icons
    └── logo.png                  # Atlys logo (if available)
```

## 🎯 Architecture

### MVVM Pattern
The app follows a Model-View-ViewModel architecture:
- **Models**: Data structures (`Country`, `CountryCode`)
- **Views**: SwiftUI views and UI components
- **View Models**: State management (implicit in SwiftUI bindings)

### Key Components

#### CarouselView
- **ScrollView with horizontal layout** for carousel behavior
- **GeometryReader** for calculating distances and positions
- **Dynamic sizing** based on center proximity
- **Z-index management** to bring focused cards to front

#### PhoneInputView
- **Binding-based state management** for phone number
- **Sheet presentation** for country picker
- **Input validation** with onChange modifiers
- **Custom keyboard toolbar** with Done button

#### ImageCache
- **Singleton pattern** for shared access
- **NSCache** implementation for efficient memory management
- **100 image limit** and 50MB total size limit

## 🎨 Design Specifications

### Colors
- **Primary**: RGB(102, 0, 204) / #6600CC
- **Background**: White (#FFFFFF)
- **Text**: Black with various opacities
- **Overlays**: Gray with opacity variations

### Typography
- **Heading**: System font, 24-26pt, Bold
- **Body**: System font, 14-16pt, Regular/Medium
- **Small**: System font, 12pt, Medium

### Card Dimensions
- **Card Width**: Screen width - 80pt (40pt padding each side)
- **Card Height**: Equal to card width (square aspect)
- **Center Height**: Card height + 40pt
- **Corner Radius**: 18pt
- **Scale Range**: 80-100% of original size

## 🚀 Getting Started

### Prerequisites
- **Xcode 15.0+**
- **iOS 17.0+** deployment target
- **Swift 5.9+**

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd AtlysApp
   ```

2. **Open the project**
   ```bash
   open AtlysApp.xcodeproj
   ```

3. **Configure the bundle identifier**
   - Select the AtlysApp target
   - Go to Signing & Capabilities
   - Update the bundle identifier to your own

4. **Build and run**
   - Select a simulator or connected device
   - Press ⌘R to build and run

### Configuration

#### Adding Countries
Edit the `countries` array in `ContentView.swift`:

```swift
private let countries: [Country] = [
    Country(imageUrl: "https://example.com/image1.jpg", countryName: "Thailand"),
    Country(imageUrl: "https://example.com/image2.jpg", countryName: "Malaysia"),
    Country(imageUrl: "https://example.com/image3.jpg", countryName: "Singapore")
]
```

#### Customizing Colors
Update the color values in the view files:
- Primary color: `Color(red: 0.4, green: 0, blue: 0.8)`
- Or use asset catalog colors

## 📐 Key Algorithms

### Card Scaling Algorithm
```swift
let distance = abs(itemCenter - screenCenter)
let maxDistance = screenWidth / 2
let progress = 1 - min(distance / maxDistance, 1.0)
let dynamicHeight = cardHeight + (40 * progress)
let dynamicWidth = cardWidth - (40 * progress)
```

### Opacity Calculation
```swift
let opacity = 0.6 + (0.4 * progress)  // Range: 0.6 to 1.0
```

### Vertical Offset
```swift
let verticalOffset = -20 * progress  // Range: -20 to 0
```

## 🔧 Customization

### Adjusting Carousel Speed
Modify the scrollTargetBehavior or add explicit animation timing.

### Changing Card Size
Update the `cardWidth` calculation in `carouselScrollView`:
```swift
let cardWidth = screenWidth - 80  // Adjust 80 for different padding
```

### Adding More Animations
Extend the `cardContent` function to add rotation, blur, or other effects:
```swift
.rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
.blur(radius: blurAmount)
```

## 🧪 Testing

### Manual Testing Checklist
- [ ] Carousel scrolls smoothly in both directions
- [ ] Cards scale properly when approaching center
- [ ] Pagination dots update correctly
- [ ] Phone number accepts only digits
- [ ] Country picker displays and works
- [ ] Images load and display correctly
- [ ] Placeholder shows for failed images
- [ ] Keyboard dismisses on background tap

### Simulator Testing
Test on different iPhone sizes:
- iPhone SE (smallest)
- iPhone 15 (standard)
- iPhone 15 Pro Max (largest)

## 📱 Supported Devices

- iPhone 8 and later
- iOS 17.0+
- Portrait orientation

## 🐛 Known Issues

- None currently reported

## 🔮 Future Enhancements

- [ ] Add haptic feedback on scroll
- [ ] Implement swipe gestures for navigation
- [ ] Add pull-to-refresh for carousel
- [ ] Implement image caching
- [ ] Add accessibility labels
- [ ] Support dark mode
- [ ] Add landscape orientation support
- [ ] Implement actual authentication flow
- [ ] Add analytics tracking
- [ ] Implement offline image caching

## 📝 Code Style

- Follow Swift API Design Guidelines
- Use descriptive variable names
- Prefer `let` over `var`
- Use computed properties for derived values
- Keep functions focused and small
- Comment complex algorithms

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 👥 Credits

- Built with SwiftUI
- Designed for Atlys visa application platform
- Icons from SF Symbols

## 📞 Support

For issues, questions, or contributions, please open an issue on GitHub.

---

**Version**: 1.0.0  
