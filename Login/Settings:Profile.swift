import SwiftUI

struct Settings: View {
    @State private var profileImage: Image?
    @State private var isImagePickerPresented: Bool = false
    @State private var showingSignUpPage: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Profile")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemTeal))
                        
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 150, height: 150)
                            
                            profileImage?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                            
                            Circle()
                                .fill(Color(.systemTeal))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Text("Add\nPhoto")
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .font(.headline)
                                        .padding()
                                )
                                .onTapGesture {
                                    isImagePickerPresented.toggle()
                                }
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                        
                        VStack(spacing: 20) {
                            SettingsButton(title: "Edit Profile", action: {})
                            SettingsButton(title: "My Health Info", action: {})
                            SettingsButton(title: "Notifications", action: {})
                            SettingsButton(title: "Settings", action: {})
                            SettingsButton(title: "Technical Support", action: {})
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: SignUp_Page().navigationBarBackButtonHidden(), isActive: $showingSignUpPage) {
                            EmptyView()
                        }
                        .navigationBarBackButtonHidden()
                        
                        Button(action: {
                            // Add logout functionality
                            showingSignUpPage = true
                        }) {
                            Text("Logout")
                                .foregroundColor(Color.black)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        
                        .padding(.horizontal)
                    }
                    .padding()
                }
                .foregroundColor(Color(.systemTeal))
                
                // ImagePicker integration
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker2(image: $profileImage)
                }
                
            }
            
        }
        
    }
}


struct SettingsButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Color(.systemTeal))
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

