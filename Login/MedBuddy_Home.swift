//
//  MedBuddy_Home.swift
//  Login
//
//  Created by user50a on 10/01/24.
//

import SwiftUI

struct MedBuddy_Home: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).brightness(0.70).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        // Handle back button tap
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    // Display the current month
                    
                    Text("MedBuddy").font(.title).multilineTextAlignment(.center)
                                    
                }
                .padding(.horizontal)
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
                
                // Button to add medicine
                Button(action: {
                                // Your button action
                            }) {
                        Image(systemName: "plus")
                        
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(150)
                            .background(Circle().fill(Color.blue).frame(width: 150,height: 150))
                            .background(Circle().fill(Color.teal.gradient).frame(width: 250,height: 250))
                                
                            }
                        
                    
                
                // Display records for the particular day
                Text("Medication Records for \(getCurrentDay())")
                    .font(.headline)
                    
                
                // Add your medicine records display here
                // ...

                Spacer()
            }
            .padding(.top, 10)
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
    var day: Int
    
    var body: some View {
        VStack {
            Text("\(day)")
                .font(.title2)
                .foregroundColor(.blue)
            Text(getDayOfWeek(day))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    func getDayOfWeek(_ day: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        guard let date = Calendar.current.date(byAdding: .day, value: day - 1, to: Date()) else { return "" }
        return dateFormatter.string(from: date)
    }
}

#Preview {
    MedBuddy_Home()
}
