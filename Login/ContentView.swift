//
//  ContentView.swift
//  Login
//
//  Created by user1 on 26/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
                
        
            VStack{
                Text("Appintment Scheduler")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Image("img1")
               //Image(systemName: "globe")
                 //   .imageScale(.large)
                   // .foregroundStyle(.tint)
                Text("This app will allow users to schedule their appointments with healthcare provides such as doctors and physiotherapists").padding()
                
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                       , 
                       label: {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,100)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
