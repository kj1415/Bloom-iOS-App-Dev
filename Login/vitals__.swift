//
//  vitals__.swift
//  Login
//
//  Created by user50a on 10/01/24.
//

import SwiftUI

struct vitals__: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .font(.largeTitle)
                .padding(.top, 50)
            
            Spacer()
            
            HStack {
                Spacer()
                // Button 1
                SquareButton(imageName: "heart.fill", buttonText: "Button 1", number: 42, subtitle: "Likes")
                Spacer()
                // Button 2
                SquareButton(imageName: "star.fill", buttonText: "Button 2", number: 123, subtitle: "Stars")
                Spacer()
            }
            .padding(.vertical, 20)
            
            HStack {
                Spacer()
                // Button 3
                SquareButton(imageName: "circle.fill", buttonText: "Button 3", number: 567, subtitle: "Circles")
                Spacer()
                // Button 4
                SquareButton(imageName: "square.fill", buttonText: "Button 4", number: 999, subtitle: "Squares")
                Spacer()
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
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






                
    #Preview {
        vitals__()
                }
       
