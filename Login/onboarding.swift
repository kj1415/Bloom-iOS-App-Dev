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
        if currentPage > totalPages{
            Homepage_2()
        }
        else{
            WalkthroughScreen()
        }
        
    }
}

#Preview {
    onboarding()
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
        
        ZStack{
            
            if currentPage == 1{
                ScreenView(image: "img1", title: "Welcome to Bloom", detail: "Your trusted partner for a safe and ealthy pregnancy journey")
                    .transition(.scale)
            }
            
            if currentPage == 2{
                ScreenView(image: "img2", title: "Tracking Tools", detail: "The app will provide tracking tools to help users monitor their pregnancy and postpartum progress, including weight tracking, contraction timing, and heart rate.")
                    .transition(.scale)
            }
            
            if currentPage == 3{
                ScreenView(image: "img3", title: "Educational Resources", detail: "The app will provide educational resources to help users learn about maternal health, including exercise videos, and nutrition.")
                    .transition(.scale)
            }
            
            
            if currentPage == 4{
                ScreenView(image: "img4", title: "Community Support", detail: "Your trusted partner for a safe and ealthy pregnancy journey")
                    .transition(.scale)
            }
            
            if currentPage == 5{
                ScreenView(image: "img5", title: "Appointment Scheduler", detail: "Your trusted partner for a safe and ealthy pregnancy journey")
                    .transition(.scale)
            }
            
            
            
            
        }.overlay(
            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage < totalPages{
                        currentPage += 1
                    }
                    else{
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
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                                
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
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                if currentPage == 1{
                    Text("Hey there!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
                else{
                    Button(action: {
                        withAnimation(.easeInOut){
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
                    HomePageView_Previews()
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
                
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




/* ZStack{
 
 
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
.padding()*/









