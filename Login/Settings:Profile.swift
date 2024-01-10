import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack{
            
            Color(.systemTeal).brightness(0.70).ignoresSafeArea()
            
            VStack{
                Text("Profile")
                    .bold()
//                    .padding(10)
//                    .frame(width: 300)
//                    .frame(height: 300)
//                    .cornerRadius(10)
//
                
                Image("pimage")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 300)
//                    .frame(height: 300)
                    .cornerRadius(1000)
                    .padding(10)
                Button(action: {}
                       ,
                       label: {
                    Text("Edit Profile                     ")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })
                
                Button(action: {}
                       ,
                       label: {
                    Text("My Health Info              ")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })
                
                Button(action: {}
                       ,
                       label: {
                    Text("Notifications                 ")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })

                Button(action: {}
                       ,
                       label: {
                    Text("Settings                         ")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })
                
                Button(action: {}
                       
                       ,
                       label: {
                    Text("Technical Support        ")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })

                Button(action: {}
                       ,
                       label: {
                    Text("Logout                            ")
                        .foregroundColor(.red)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(Color.black)
                })
                
                .padding(10)

                
            }
        }}}

#Preview {
    Settings()
}
