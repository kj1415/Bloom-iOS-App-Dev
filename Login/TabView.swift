//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//
//class CurrentWeekManager: ObservableObject {
//    @Published var currentWeek: CGFloat = 0
//}
//
//struct HomePageView: View {
//    @ObservedObject var currentWeekManager: CurrentWeekManager
//
//    var body: some View {
//        // Your HomePageView content here
//        Text("HomePageView Content")
//    }
//}
//
//struct TabView: View {
//    @State private var selectedIndex = 0
//    @StateObject private var currentWeekManager = CurrentWeekManager()
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Spacer()
//                switch selectedIndex {
//                case 0:
//                    NavigationView {
//                        VStack {
//                            HomePageView(currentWeekManager: currentWeekManager)
//                        }
//                        .navigationTitle("You are \(Int(currentWeekManager.currentWeek)) weeks Pregnant")
//                    }                case 1:
//                    NavigationView {
//                        VStack {
//                            ContentView(viewModel: PillReminderViewModel())
//                        }
//                        .navigationTitle("")
//                    }
//                    
//                case 2:
//                    NavigationView {
//                        VStack {
//                            VitalsPage()
//                        }
//                        .navigationTitle("Vitals")
//                    }
//                case 3:
//                    NavigationView {
//                        VStack {
//                            TwitterCloneView()
//                            Text("")
//                        }
//                        .navigationTitle("MomComm")
//                    }
//                default:
//                    NavigationView {
//                        VStack {
//                            MomComm()
//                        }
//                        .navigationTitle("second")
//                    }
//                }
//            }
//            .navigationBarBackButtonHidden()
//            .onAppear {
//                // Fetch user data from Firestore
//                fetchUserData()
//            }
//            HStack {
//                ForEach(0..<4, id: \.self) { number in
//                    Spacer()
//                    Button(action: { self.selectedIndex = number }) {
//                        Image(systemName: icons[number])
//                            .font(.system(size: 25, weight: .regular, design: .default))
//                            .foregroundColor(selectedIndex == number ? .teal : Color(uiColor: UIColor.lightGray))
//                    }
//                    .frame(width: 40, height: 40)
//                }
//                Spacer()
//            }
//        }
//    }
//    
//    // Fetch user data from Firestore
//    private func fetchUserData() {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("Error: UID is nil")
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("details").document(uid).getDocument { (document, error) in
//            if let document = document, document.exists {
//                if let lastMenstrualCycleTimestamp = document["lastMenstrualCycle"] as? Timestamp {
//                    self.lastMenstrualCycle = lastMenstrualCycleTimestamp.dateValue()
//                    // Calculate current week based on fetched last menstrual cycle date
//                    self.currentWeek = calculateCurrentWeek(from: Date(), and: self.lastMenstrualCycle)
//                }
//            } else {
//                print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
//    }
//    
//    // Helper function to calculate the current week of pregnancy
//    private func calculateCurrentWeek(from currentDate: Date, and lastMenstrualCycleDate: Date) -> CGFloat {
//        let daysSinceLastCycle = Calendar.current.dateComponents([.day], from: lastMenstrualCycleDate, to: currentDate).day!
//        let weeksSinceLastCycle = CGFloat(daysSinceLastCycle) / 7
//        return weeksSinceLastCycle
//    }
//}
//
//struct HomePageView1: View {
//    @Binding var currentWeek: CGFloat // Define currentWeek as a binding
//    
//    var body: some View {
//        ScrollView {
//            // Your existing code for HomePageView
//            RoundedRectangle(cornerRadius: 1)
//                .foregroundColor(Color.white.opacity(0.4))
//                .overlay(
//                    Text("You are \(Int((currentWeek))) weeks Pregnant")
//                        .foregroundColor(.blue)
//                        .font(.title3)
//                        .padding()
//                )
//        }
//    }
//}
//
//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}
//

//
//  TabVIew.swift
//  Login
//
//  Created by user50a on 15/01/24.
//

import SwiftUI

struct TabView: View {
    @State var selectedIndex = 0
    
    let icons = [
    "house",
    "pills.fill",
//    "heart.circle",
    "shared.with.you",
    
    ]
    var body: some View {
        VStack{
            ZStack{
                Spacer()
                switch selectedIndex{
                case 0:
                    NavigationView{
                        VStack{
                            HomePageView()
                        }.navigationTitle("Hey Mom 🌸")
//                            .navigationBarTitleDisplayMode(.large)
                    }
                  
                case 1:
                    NavigationView{
                        VStack{
                            ContentView(viewModel: PillReminderViewModel())
                        }.navigationTitle("")
                    }
                    
//                case 2:
//                    NavigationView{
//                        VStack{
//                            VitalsPage()
//                        }.navigationTitle("Vitals")
//                    }
//                case 2:
//                    NavigationView{
//                        VStack{
//                            TwitterCloneView()
//                            Text("")
//                        }.navigationTitle("")
//                    }
                default:
                    NavigationView{
                        VStack{
                            TwitterCloneView()

                        }.navigationTitle("")
                    }
               
                    }
                
            }
            .navigationBarBackButtonHidden()
            //.navigationViewStyle(.columns)
            }
            HStack{
                ForEach(0..<3, id: \.self){number in
                    Spacer()
                    Button(action: {self.selectedIndex = number},
                           label: {
                    Image(systemName: icons[number])
                            .font(.system(size: 25, weight: .regular,design: .default))
                            .foregroundColor(selectedIndex == number ? .teal : Color(uiColor: UIColor.lightGray))
                            
                    }).frame(width: 40, height: 40)}
                Spacer()
            }
            }
            
        
    }



#Preview {
    TabView()
}
