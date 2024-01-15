//
//  Homepage_2.swift
//  Login
//
//  Created by user50a on 11/01/24.
//

import SwiftUI

struct Homepage_2: View {
    @State private var currentWeek: Double = 1

    var body: some View {
        VStack {
            // Horizontal ScrollView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(1...40, id: \.self) { week in
                        Text("\(week) weeks")
                            .padding(10)
                            .foregroundColor(week == Int(currentWeek) ? .blue : .black)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation {
                                    currentWeek = Double(week)
                                }
                            }
                    }
                }
                .padding()
            }

            // Circular Loading View
            CircularLoadingView(progress: currentWeek / 40)
                .frame(width: 150, height: 150)

            // Labels for "Length" and "Weight"
            HStack {
                Image(systemName: "ruler")
                    .foregroundColor(.blue)
                Spacer()
                Text("Length")
                    .font(.caption)

                Spacer()

                Text("Weight")
                    .font(.caption)
                Spacer()
                Image(systemName: "scalemass")
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
    }
}

struct CircularLoadingView: View {
    var progress: Double

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .opacity(0.3)

                Circle()
                    .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270))
                    
            }

            Image(systemName: "face.child")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
    }
}

    
    #Preview {
        Homepage_2()
    }

