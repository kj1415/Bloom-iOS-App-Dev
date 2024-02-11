import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack {
            Color(.systemTeal)
                .brightness(0.70)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                
                Image("pimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    SettingsButton(title: "Edit Profile", action: {})
                    SettingsButton(title: "My Health Info", action: {})
                    SettingsButton(title: "Notifications", action: {})
                    SettingsButton(title: "Settings", action: {})
                    SettingsButton(title: "Technical Support", action: {})
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                .padding(.horizontal)
            }
            .padding()
        }
        .foregroundColor(.black) // Set the primary text color
    }
}

struct SettingsButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
        })
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
