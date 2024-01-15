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
    "cross.case",
    "heart.circle",
    "shared.with.you"
    ]
    var body: some View {
        VStack{
            ZStack{
                Spacer()
                switch selectedIndex{
                case 0:
                    NavigationView{
                        VStack{
                            Homepage_2()
                        }.navigationTitle("Home")
                    }
                    NavigationLink("Hello", destination: Homepage_2())
                case 1:
                    NavigationView{
                        VStack{
                            appointments()
                        }.navigationTitle("Appointments")
                    }
                    
                case 2:
                    NavigationView{
                        VStack{
                            Text("")
                        }.navigationTitle("ProHealth")
                    }
                case 3:
                    NavigationView{
                        VStack{
                            Text("")
                        }.navigationTitle("MomComm")
                    }
                default:
                    NavigationView{
                        VStack{
                        MomComm()
                        }.navigationTitle("second")
                    }
               
                    } 
                
                }
            }
            HStack{
                ForEach(0..<4, id: \.self){number in
                    Spacer()
                    Button(action: {self.selectedIndex = number},
                           label: {
                    Image(systemName: icons[number])
                            .font(.system(size: 25, weight: .regular,design: .default))
                            .foregroundColor(selectedIndex == number ? .blue : Color(uiColor: UIColor.lightGray))
                            
                    }).frame(width: 40, height: 40)}
                Spacer()
            }
            }
            
        
    }



#Preview {
    TabView()
}
