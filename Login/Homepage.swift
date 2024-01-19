import SwiftUI

struct HomePageView: View {
    @State private var currentWeek: Double = 1

    var body: some View {
        ScrollView {
            // Week Scroller
            WeekScrollerView(currentWeek: $currentWeek)
                .frame(height: 150)

            // Circular Loading View with Embryo Image
            myCircularLoadingView(currentWeek: $currentWeek)
                .frame(width: 150, height: 150)
                .padding()

            // Horizontal ScrollView of Large Square Buttons
            LargeSquareButtonsScrollView()

            // Medication Reminder Section
            MedicationReminderSection()
        }
    }
}

struct WeekScrollerView: View {
    @Binding var currentWeek: Double

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...40, id: \.self) { week in
                    Text("\(week) weeks")
                        .padding(10)
                        .foregroundColor(week == Int(currentWeek) ? .blue : .black)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .onAppear {
                            // Automatically move to the next week every week
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(week)) {
                                withAnimation {
                                    currentWeek = Double(week)
                                }
                            }
                        }
                }
            }
            .padding()
        }
    }
}

struct myCircularLoadingView: View {
    @Binding var currentWeek: Double
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .opacity(0.3)

                Circle()
                    .trim(from: 0, to: CGFloat(min(1.0, 0.01 * currentWeek)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270))
                
                Image(systemName: "figure.child.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    
            }

            
        }
    }
}

struct LargeSquareButton<Destination: View>: View {
    var systemImageName: String
    var destinationScreen: Destination

    var body: some View {
        NavigationLink(destination: destinationScreen) {
            VStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)

                Text("Button")
                    .foregroundColor(.blue)
                    .padding(.top, 8)
            }
        }
    }
}

struct LargeSquareButtonsScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(1...5, id: \.self) { index in
                    let destinationView = Text("Screen \(index)")
                    let systemImageName = systemImageName(for: index)

                    LargeSquareButton(systemImageName: systemImageName, destinationScreen: destinationView)
                        .onTapGesture {
                            // Handle navigation here
                            print("Button \(index) tapped")
                        }
                }
            }
            .padding()
        }
    }

    func systemImageName(for index: Int) -> String {
        switch index {
        case 1:
            return "heart.fill"
        case 2:
            return "star.fill"
        case 3:
            return "bolt.fill"
        case 4:
            return "leaf.fill"
        case 5:
            return "flame.fill"
        default:
            return "heart.fill"
        }
    }
}



struct MedicationReminderSection: View {
    var body: some View {
        VStack {
            Text("Medication Reminder")
                .font(.title)
                .padding()

            // Add Medication Reminder content here
            // For example, a list of medications and reminders
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

















/*

//
//  Homepage.swift
//  Login
//
//  Created by user1 on 01/01/24.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        //Image("logo1")
        Text(getCurrentMonth()).font(.headline).padding()
        // Title "MedBuddy"
        
        // ScrollView for dates and days
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(1...30, id: \.self) { day in
                    DateBox(day: day)
                }
            }
        }
        .padding(.horizontal)
        
        
        
        
        
        
        
        
        
        
        
        
        Text("Services")
            .bold()
        HStack{
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.blue)
                    .cornerRadius(100)
            })
            
            /*  Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
             ,
             label: {
             Text("Medic")
             .foregroundColor(.white)
             .padding()
             .padding(.horizontal,50)
             .background(Color.red)
             .cornerRadius(10)
             })*/
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.red)
                    .cornerRadius(10)
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                   ,
                   label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal,50)
                    .background(Color.pink)
                    .cornerRadius(10)
            })
        }
        
        
    }
    
    
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }
    
    
    #Preview {
        Homepage()
    }
    
    
}
 /**/*/
