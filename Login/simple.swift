//
//  simple.swift
//  Login
//
//  Created by user50a on 10/01/24.
//

import SwiftUI

struct simple: View {
    var body: some View {
        
        ZStack{
            Color(.systemTeal)
                .ignoresSafeArea()
                .brightness(/*@START_MENU_TOKEN@*/0.60/*@END_MENU_TOKEN@*/)
          
        VStack {
                Text("Hello World")
                .font(.largeTitle)
                .padding(.top, 50)
                            
                Spacer()
                            
                HStack {
                    Spacer()
                    Button(action: {
                                    // Handle button tap
                                }) {
                    Text("Heart Rate")
                        Image(systemName: "heart.circle.fill")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                                }
                        Spacer()
                                Button(action: {
                                    // Handle button tap
                                }) {
                                    Text("Walking")
                                    Image(systemName: "figure.walk")
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 20)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Handle button tap
                                }) {
                                    Text("Exercise")
                                    Image(systemName: "figure.strengthtraining.functional")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                Spacer()
                                Button(action: {
                                    // Handle button tap
                                }) {
                                    
                                        Text("Sleep")
                                        Image(systemName: "powersleep")
                                            .padding()
                                            .background(Color.orange)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                Spacer()
                            }
                            .padding(.bottom, 20)
                            
                            Spacer()
                        }
                        .navigationBarTitle(Text(""), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            // Handle back button tap
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        })
                    }
                }
            }

            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }

            
        
            
            
            
            
            
            
            
            
            
            
            
           

#Preview {
    simple()
}
