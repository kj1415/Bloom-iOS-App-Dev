import SwiftUI

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()
struct MedBuddy_Home: View {
    @EnvironmentObject var remindersManager: MedicationRemindersManager
    @State private var selectedDate: Date = Date()

    private var dates: [Date] {
        (1...30).map { Calendar.current.date(byAdding: .day, value: $0 - 1, to: Date()) ?? Date() }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemTeal).brightness(0.70).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button(action: {
                            //HomePageView()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .frame(width: 1, height: 1, alignment: .leading)
                                
                        }
                        .padding(.horizontal,5)
                        .buttonStyle(PlainButtonStyle())
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(dates, id: \.self) { date in
                                    DateBox(date: date, isSelected: Calendar.current.isDate(self.selectedDate, inSameDayAs: date))
                                        .onTapGesture {
                                            self.selectedDate = date
                                        }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .background(Color.teal.brightness(0.70).ignoresSafeArea())
                        .cornerRadius(10)
                        Spacer()

                        Text("MedBuddy")
                            .font(.title)
                            .foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(remindersManager.medicationReminders) { medicine in
                                Text("\(medicine.pillName) - Amount: \(medicine.amount) - Duration: \(medicine.duration) - Time: \(formatter.string(from: medicine.selectedTime))")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)

                    Text(getCurrentMonth())
                        .font(.headline)
                        .padding()

//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 10) {
//                            ForEach(dates, id: \.self) { date in
//                                DateBox(date: date, isSelected: Calendar.current.isDate(self.selectedDate, inSameDayAs: date))
//                                    .onTapGesture {
//                                        self.selectedDate = date
//                                    }
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, 10)
//                    .background(Color.white)
//                    .cornerRadius(10)

                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)

                VStack {
                    Spacer()
                    Button(action: {
                        // Navigate to AddPlanView
                    }) {
                        Image(systemName: "plus")
                        
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(170)
                            .background(Circle().fill(Color.blue).frame(width: 100,height: 100))
                            .background(Circle().fill(Color.teal.gradient).frame(width: 200,height: 200))
                                
                            }
                    }
                    .padding(.bottom, 150)
            }
            .navigationTitle("MedBuddy")
            
        }
    }

    // Function to get the current month
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }

    // Function to get the current day
    func getCurrentDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date())
    }
}
struct DateBox: View {
    var date: Date
    var isSelected: Bool

    var body: some View {
        VStack {
            Text(DateFormatter.shortWeekday.string(from: date))
                .font(.title2)
                .foregroundColor(isSelected ? .blue : .gray)
            Text(DateFormatter.shortDate.string(from: date))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct MedBuddy_Home_Previews: PreviewProvider {
    static var previews: some View {
        MedBuddy_Home()
            .environmentObject(MedicationRemindersManager())
    }
}

extension DateFormatter {
    static let shortWeekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
}
