import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail: Float = 0
    @State private var wrongPassword: Float = 0
    @State private var errorMessage: String?
    @State private var showingDetails1 = false
    @State private var showingSignUpPage = false

    var body: some View {
        NavigationView {
            ZStack {
//                Color.teal
//                    .ignoresSafeArea()
//                Circle()
//                    .scale(1.7)
//                    .foregroundColor(.white.opacity(0.15))
//                Circle()
//                    .scale(1.35)
//                    .foregroundColor(.white)
                Image("img1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.1)
                        .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongEmail))

                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button("Login") {
                        login()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.teal)
                    .cornerRadius(10)

                    // Button to navigate to SignUp_Page
                    Button("Don't have an account? Sign Up") {
                        showingSignUpPage = true
                    }
                    .foregroundColor(.black)

                    // You can use NavigationLink or performSegue to navigate to the next screen
                    NavigationLink(destination: TabView(), isActive: $showingDetails1) {
                        EmptyView()
                    }
                  .navigationBarHidden(true)
                }
                .sheet(isPresented: $showingSignUpPage) {
                    SignUp_Page()
                }
            }
            
        }
    }

    func login() {
        // Validate email and password
        guard isValidEmail(email) else {
            errorMessage = "Invalid email address"
            return
        }

        // Authenticate user
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                errorMessage = error?.localizedDescription ?? "Error during login"
                return
            }
            // Successfully logged in
            print("User logged in with UID: \(user.uid)")
            // Navigate to Details1
            showingDetails1 = true
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        // Implement your email validation logic
        // For simplicity, a basic email format check is used here
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

