import SwiftUI

struct Details1: View {
    @State private var babyName = ""
    @State private var lastMenstrualCycle = Date()
    @State private var weight = ""
    
    var body: some View {
        ZStack{
            Color(.systemTeal).brightness(0.70).ignoresSafeArea()
            
            VStack {
                Image("logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
                
                Text("*Mandatory fields")
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
                
                TextField("Baby's Name", text: $babyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Weight (kg)*", text: $weight)
                    .keyboardType(.numberPad) // Allow only numerical input
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("Last Menstrual Cycle*", selection: $lastMenstrualCycle, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Sync with Apple Health action
                }) {
                    Text("Sync with Apple Health")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: TabView()) {
                    Text("Let's Get Started")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
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
