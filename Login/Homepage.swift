
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
        
        TabView{
            
            Text("HOME")
                .tabItem {
                    Label("",image: "homeicon")
                    
                    
                }
            
            Text("Appointment")
                .tabItem {
                    Label("",image:"appointicon")
                }
            
            Text("Vitals")
                .tabItem {
                    Label("",image:"vitalsicon")
                }
            
            Text("Community")
                .tabItem {
                    Label("",image:"momcom")
                }
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

 /**/*/
