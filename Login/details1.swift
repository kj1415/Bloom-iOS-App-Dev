import SwiftUI
import Firebase
import FirebaseFirestore

struct Details1: View {
    @State private var babyName = ""
    @State private var lastMenstrualCycle = Date()
    @State private var weight = ""
    @State private var navigateToTabView = false // Added state property

    // Computed property to get UID from Firebase Auth when needed
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }

    var body: some View {
        ZStack{
            //Color(.systemTeal).brightness(0.70).ignoresSafeArea()
            Image("img11")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.05)
                    .edgesIgnoringSafeArea(.all)
            VStack {
//                Image("logo1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
//                    .padding()
                Spacer()

                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.red.opacity(0.3))
                    .overlay(
                        Text("Disclaimer")
                            .font(.title)
                        
                    )
                    .frame(width: 200,height: 50)
                    .foregroundColor(.red)
                    .padding(.bottom, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.teal.opacity(0.2))
                    .overlay(
                        Text("The content provided in this app, including but not limited to pregnancy tracking, nutrition advice, and exercise recommendations, is for informational purposes only. It is not intended to replace professional medical advice, diagnosis, or treatment. Always consult with your healthcare provider before making any decisions based on information obtained from this app.")
                            .font(.system(size: 16))
                            
                        
                    )
                    .frame(width: 370,height: 200,alignment: .trailingFirstTextBaseline)
                    .foregroundColor(.red)
                    .padding(.bottom,50)
//                Text("*Mandatory fields")
//                    .foregroundColor(.red)
//                    .padding(.bottom, 10)

//                TextField("Baby's Name", text: $babyName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                TextField("Weight (kg)*", text: $weight)
//                    .keyboardType(.numberPad) // Allow only numerical input
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
                Text("Please enter the date of your last menstrual cycle to help us personalise the app for you!")
                    .font(.subheadline)
                    .frame(width:380, alignment: .center)
                    
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.teal.opacity(0.4))
                    .overlay(
                DatePicker("Last Menstrual Cycle*", selection: $lastMenstrualCycle, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                )
                    .frame(width: 380,height: 80,alignment: .center)
                Spacer()

                NavigationLink(destination:TabView(), isActive: $navigateToTabView) {
                    EmptyView()
                }

                Button(action: {
                    createNewDetailsDocument()
                    navigateToTabView = true // Set to true to trigger navigation
                }) {
                    Text("Let's Get Started")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color.teal)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    private func createNewDetailsDocument() {
        let db = Firestore.firestore()

        // Check if UID is available
        guard let uid = uid else {
            print("Error: UID is nil")
            return
        }

        // Extract only the date component from lastMenstrualCycle
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: lastMenstrualCycle)
        guard let dateOnly = calendar.date(from: dateComponents) else {
            print("Error extracting date component")
            return
        }

        // Create a new document in Firestore under "details" collection
        db.collection("details").document(uid).setData([
            "uid": uid, // Store UID in Firestore
            "babyName": babyName,
            "weight": weight,
            "lastMenstrualCycle": dateOnly // Store only the date component
            // Add more fields as needed
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

struct NextScreen: View {
    var body: some View {
        Text("Next Screen")
    }
}

struct Details1_Previews: PreviewProvider {
    static var previews: some View {
        Details1()
    }
}

