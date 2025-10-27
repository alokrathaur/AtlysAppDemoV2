import SwiftUI

// Extension for placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct PhoneInputView: View {
    @Binding var phoneNumber: String
    @State private var selectedCountry = CountryCode(code: "+91", flag: "🇮🇳", name: "India")
    @State private var showCountryPicker = false
    
    let countryCodes: [CountryCode] = [
        CountryCode(code: "+91", flag: "🇮🇳", name: "India"),
        CountryCode(code: "+1", flag: "🇺🇸", name: "United States"),
        CountryCode(code: "+44", flag: "🇬🇧", name: "United Kingdom"),
        CountryCode(code: "+65", flag: "🇸🇬", name: "Singapore"),
        CountryCode(code: "+971", flag: "🇦🇪", name: "UAE"),
        CountryCode(code: "+86", flag: "🇨🇳", name: "China"),
        CountryCode(code: "+81", flag: "🇯🇵", name: "Japan"),
        CountryCode(code: "+82", flag: "🇰🇷", name: "South Korea"),
        CountryCode(code: "+61", flag: "🇦🇺", name: "Australia"),
        CountryCode(code: "+49", flag: "🇩🇪", name: "Germany"),
        CountryCode(code: "+33", flag: "🇫🇷", name: "France"),
        CountryCode(code: "+39", flag: "🇮🇹", name: "Italy")
    ]
    
    var body: some View {
        HStack(spacing: 8) {
            // Country Picker Button
            Button(action: {
                showCountryPicker.toggle()
            }) {
                HStack(spacing: 4) {
                    Text(selectedCountry.flag)
                        .font(.system(size: 20))
                    Text(selectedCountry.code)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            
            Divider()
                .frame(height: 20)
            
            // Phone Number TextField
            ZStack(alignment: .leading) {
                if phoneNumber.isEmpty {
                    Text("Enter mobile number")
                        .foregroundColor(Color.gray.opacity(0.6))
                        .font(.system(size: 16))
                }
                
                TextField("", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .autocorrectionDisabled()
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
                    .onChange(of: phoneNumber) { oldValue, newValue in
                        // Limit to 10 digits
                        if newValue.count > 10 {
                            phoneNumber = String(newValue.prefix(10))
                        }
                        // Remove non-numeric characters
                        phoneNumber = phoneNumber.filter { $0.isNumber }
                    }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerView(
                selectedCountry: $selectedCountry,
                countryCodes: countryCodes,
                isPresented: $showCountryPicker
            )
        }
    }
}

struct CountryCode: Identifiable {
    let id = UUID()
    let code: String
    let flag: String
    let name: String
}

struct CountryPickerView: View {
    @Binding var selectedCountry: CountryCode
    let countryCodes: [CountryCode]
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                List(countryCodes) { country in
                    Button(action: {
                        selectedCountry = country
                        isPresented = false
                    }) {
                        HStack {
                            Text(country.flag)
                                .font(.system(size: 24))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(country.name)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                Text(country.code)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if selectedCountry.code == country.code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(Color.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            }
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .preferredColorScheme(.light)
    }
}
