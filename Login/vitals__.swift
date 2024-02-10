//
//  vitals__.swift
//  Login
//
//  Created by user50a on 10/01/24.
//

import SwiftUI

struct vitals__: View {
    var body: some View {
        ZStack {
            Color(.systemTeal)
                .brightness(0.70)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Hello User")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                Spacer()
                
                HStack(spacing: 20) {
                    SquareButton(imageName: "heart.fill", buttonText: "Heart Rate", number: 90, subtitle: "bpm")
                    SquareButton(imageName: "figure.walk", buttonText: "Walking", number: 32, subtitle: "km")
                }
                .padding(.vertical, 20)
                
                HStack(spacing: 20) {
                    SquareButton(imageName: "bolt.fill", buttonText: "Exercise", number: 5, subtitle: "Hrs")
                    SquareButton(imageName: "zzz", buttonText: "Sleep", number: 7, subtitle: "Hrs")
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
        }
    }
}

struct SquareButton: View {
    var imageName: String
    var buttonText: String
    var number: Int
    var subtitle: String
    
    var body: some View {
        Button(action: {
            // Button action
        }) {
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.blue)
                    .cornerRadius(15)
                
                Text(buttonText)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
                
                Text("\(number)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}



//TabView
//{
//    Text("HOME")
//        .tabItem {
//            Label("",image: "homeicon")
//        }
//        
//     Text("Appointment")
//            .tabItem {
//                Label("",image:"appointicon")
//            }
//    
//    Text("Vitals")
//           .tabItem {
//               Label("",image:"vitalsicon")
//           }
//    
//    Text("Community")
//           .tabItem {
//               Label("",image:"momcom")
//           }
//    }
    




                
    #Preview {
        vitals__()
                }
       
