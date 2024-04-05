//
//  ContentView.swift
//  Login
//
//  Created by user1 on 26/12/23.
//

import SwiftUI

struct onboarding: View {
    
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        if currentPage > totalPages {
            SignUp_Page()
        } else {
            WalkthroughScreen()
        }
    }
}

struct Home: View {
    
    var body: some View {
        Text("Welcome")
            .font(.title)
            .fontWeight(.heavy)
    }
}

struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        
        ZStack {
            
            if currentPage == 1 {
                ScreenView(image: "img1", title: "Welcome to Bloom", detail: "Your trusted partner for a safe and healthy pregnancy journey.")
                    .transition(.scale)
            }
            
            if currentPage == 2 {
                ScreenView(image: "img2", title: "Tracking Tools", detail: "The app will provide tracking tools to help users monitor their pregnancy progress.")
                    .transition(.scale)
            }
            
            if currentPage == 3 {
                ScreenView(image: "img3", title: "Educational Resources", detail: "The app will provide educational resources to help users learn about maternal health, including exercise videos, and nutrition.")
                    .transition(.scale)
            }
            
            if currentPage == 4 {
                ScreenView(image: "img4", title: "Community Support", detail: "access to a community forum or chat where pregnant women can connect and seek advice")
                    .transition(.scale)
            }
            
            if currentPage == 5 {
                ScreenView(image: "img5", title: "Medicine Reminder", detail: "Reminders for taking prenatal vitamins, supplements, and any prescribed medications.")
                    .transition(.scale)
            }
            
        }.overlay(
            Button(action: {
                withAnimation(.easeInOut) {
                    if currentPage < totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.teal)
                    .clipShape(Circle())
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.black, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            ,alignment: .bottom
            
        ).padding(.bottom,20)
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    @AppStorage("currentPage") var currentPage = 1
    @State private var navigateToSignUp = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                if currentPage == 1 {
                    Text("Hey there!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.2)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    // Navigate to SignUp_Page
                    navigateToSignUp = true
                }) {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
                .fullScreenCover(isPresented: $navigateToSignUp, content: SignUp_Page.init)
            }.foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(detail)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer(minLength: 120)
        }
    }
}

var totalPages = 5

