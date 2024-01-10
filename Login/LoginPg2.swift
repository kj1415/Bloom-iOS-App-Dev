//
//  LoginPg2.swift
//  Login
//
//  Created by user1 on 01/01/24.
//

import SwiftUI

struct LoginPg2: View {
    var body: some View {
        ZStack{
        Image("teal")
                .resizable()
                .ignoresSafeArea()
            VStack{
                  Image("logo1")
                    .padding(50)
                
                Text("Enter your name")
                
            
                TextField("Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .padding(.horizontal,10)
                
                Text("Enter your email")
                
            
                TextField("Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .padding(.horizontal,10)
                
                Text("Enter your password")
                
            
                TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .padding(.horizontal,10)
                
                
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
                .padding(10)
                
                Text("OR")
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
                       ,
                       label: {
                    Text("Sign Up with Google")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding(10)
                
                
                
            }
            
            
        }
    }
}

#Preview {
    LoginPg2()
}
