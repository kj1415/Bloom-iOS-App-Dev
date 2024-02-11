import SwiftUI

struct AppointmentBookingView: View {
    @State private var selectedCategoryIndex = 0
    @State private var selectedDoctorIndex: Int?
    @State private var selectedDate = Date()
    @State private var selectedTimeSlot: String?
    
    let categories = ["Gynaecologist", "Physiotherapist"]
    
    // Sample data for doctors and physiotherapists
    let gynaecologists = [
        "Dr. Emily Johnson",
        "Dr. Sarah Smith",
        "Dr. Jessica Davis"
    ]
    
    let physiotherapists = [
        "Dr. Michael Brown",
        "Dr. David Wilson",
        "Dr. Olivia Lee"
    ]
    
    // Sample time slots
    let timeSlots = [
        "09:00 AM",
        "10:00 AM",
        "11:00 AM",
        "02:00 PM",
        "03:00 PM",
        "04:00 PM"
    ]
    
    var selectedCategory: String {
        categories[selectedCategoryIndex]
    }
    
    var selectedCategoryDoctors: [String] {
        if selectedCategoryIndex == 0 {
            return gynaecologists
        } else {
            return physiotherapists
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Select Category", selection: $selectedCategoryIndex) {
                ForEach(0..<categories.count) { index in
                    Text(categories[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(selectedCategoryDoctors.indices, id: \.self) { index in
                        Button(action: {
                            selectedDoctorIndex = index
                        }) {
                            HStack {
                                Text(selectedCategoryDoctors[index])
                                    .padding()
                                    .foregroundColor(.black)
                                Spacer()
                                if selectedDoctorIndex == index {
                                    Image(systemName: "checkmark")
                                        .padding()
                                        .foregroundColor(.blue)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                    }
                }
            }
            .padding()
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(timeSlots, id: \.self) { timeSlot in
                        Button(action: {
                            selectedTimeSlot = timeSlot
                        }) {
                            Text(timeSlot)
                                .padding()
                                .background(selectedTimeSlot == timeSlot ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                // Confirm appointment action
                if let doctorIndex = selectedDoctorIndex, let timeSlot = selectedTimeSlot {
                    print("Appointment confirmed with \(selectedCategoryDoctors[doctorIndex]) at \(timeSlot) on \(selectedDate)")
                    // Add your appointment confirmation logic here
                } else {
                    print("Please select a doctor and a time slot.")
                }
            }) {
                Text("Confirm Appointment")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct AppointmentBookingView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentBookingView()
    }
}
