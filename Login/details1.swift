//
//  details1.swift
//  Login
//
//  Created by user1 on 31/12/23.
//

import SwiftUI

struct details1: View {
    var body: some View {
        
        
            //Spacer()
            //.padding(50)
            Image("logo1")
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .padding()
        Text("                                          *Madotory fields")
            //.backgroundColor(.blue)
                
        Text("Baby's Name                                                  ")
           // .padding()
            .padding(.vertical,10)
            
        TextField("Name", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            .padding(10)
            .padding(.horizontal,10)
    
        Text("Last Menstrual cycle                                       ")
            
        TextField("Date", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            
            .padding(.horizontal,10)
            
        Text("Weight*")
        TextField("Enter weight in kgs", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            
            .padding(.horizontal,10)
        Spacer()
            .padding(50)
         
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
               ,
               label: {
            Text("Sync with apple health")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal,50)
                .background(Color.blue)
                .cornerRadius(10)
        })
        .padding(10)
        
        
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/
               ,
               label: {
            Text("Let's Get Started")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal,50)
                .background(Color.blue)
                .cornerRadius(10)
        })
        Spacer()
            .padding(10)
        }
    
}

#Preview {
    details1()
}
