import SwiftUI

class MedicationRemindersManager: ObservableObject {
    @Published var medicationReminders: [MedicationReminder] = []
}

struct AddPlanView: View {
    @Binding var isSheetPresented: Bool
    @State private var pillName = ""
    @State private var amount = 1
    @State private var duration = 1
    @State private var isBeforeFood = false
    @State private var isAfterFood = false
    @State private var selectedTime = Date()
    @EnvironmentObject var remindersManager: MedicationRemindersManager
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(.systemTeal).brightness(0.70).ignoresSafeArea()
                
                VStack(spacing: 10) {
                    HStack {
                        Button(action: {
                            isSheetPresented = false
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        
                        Spacer()
                        
                        
                        /* Text("Add Plan")
                         .font(.title)
                         .fontWeight(.bold)
                         .padding(.vertical, 5)
                         .padding(.horizontal, 10)*/
                    }
                    Color(.systemTeal).brightness(0.70).ignoresSafeArea()
                    .padding(.horizontal)
                    
                    TextField("Enter pill name", text: $pillName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Amount")
                            .fontWeight(.bold)
                        Stepper(value: $amount, in: 1...5) {
                            Text("\(amount)")
                        }
                        
                        Text("Duration")
                            .fontWeight(.bold)
                        Stepper(value: $duration, in: 1...365) {
                            Text("\(duration) days")
                        }
                    }
                    .padding()
                    
                    Text("Before or After?")
                        .fontWeight(.bold)
                    HStack {
                        Button(action: {
                            isBeforeFood = true
                            isAfterFood = false
                        }) {
                            Text("Before")
                                .foregroundColor(isBeforeFood ? .white : .blue)
                                .padding()
                                .background(isBeforeFood ? Color.blue : Color.clear)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            isBeforeFood = false
                            isAfterFood = true
                        }) {
                            Text("After")
                                .foregroundColor(isAfterFood ? .white : .blue)
                                .padding()
                                .background(isAfterFood ? Color.blue : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Notification:")
                            .fontWeight(.bold)
                        Text("Set a time for reminder")
                            .padding(.bottom, 5)
                        DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute, .date])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    .padding()
                    
                    Button(action: {
                        let medicationReminder = MedicationReminder(pillName: pillName, amount: amount, duration: duration, isBeforeFood: isBeforeFood, selectedTime: selectedTime)
                        remindersManager.medicationReminders.append(medicationReminder)
                        isSheetPresented = false
                    }) {
                        Text("Add Medicine")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .navigationBarHidden(true)
            }
        }
    }
}
struct MedicationReminder: Identifiable {
    let id = UUID()
    let pillName: String
    let amount: Int
    let duration: Int
    let isBeforeFood: Bool
    let selectedTime: Date
}
struct MedicineCapsule: Identifiable {
    let id = UUID()
    let pillName: String
    let amount: Int
    let duration: Int
    let isBeforeFood: Bool
    let selectedTime: Date
}
struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView(isSheetPresented: .constant(true))
    }
}
