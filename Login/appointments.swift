//
//  appointments.swift
//  Login
//
//  Created by user1 on 04/01/24.
//

import SwiftUI
import MapKit

// Sample data for popular physiotherapists
struct Physiotherapist {
    var id: Int
    var name: String
    var imageName: String
    var description: String
}

struct appointments: View {
    @State private var searchText = ""
    @State private var selectedPhysiotherapist: Physiotherapist?

    // Sample physiotherapists data
    let popularPhysiotherapists: [Physiotherapist] = [
        Physiotherapist(id: 1, name: "Dr. John Doe", imageName: "physio1", description: "Experienced in sports injuries."),
        Physiotherapist(id: 2, name: "Dr. Jane Smith", imageName: "physio2", description: "Specializing in rehabilitation."),
        // Add more physiotherapists as needed
    ]

    var body: some View {
        VStack {
            // Display physiotherapists on top
            Text("Physiotherapists")
                .font(.title)
                .padding()

            // Back button aligned to the top left corner
            HStack {
                Button(action: {
                    // Handle back button tap
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }
            .padding(.horizontal)

            // Map in the top half of the screen
            MapView()
                .frame(height: UIScreen.main.bounds.height / 3)

            // Search bar below the map
            SearchBar(text: $searchText)
                .padding()

            // Horizontal scroll view of popular physiotherapists
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(popularPhysiotherapists, id: \.id) { physiotherapist in
                        PhysiotherapistCard(physiotherapist: physiotherapist)
                            .onTapGesture {
                                // Handle selection of physiotherapist
                                selectedPhysiotherapist = physiotherapist
                            }
                    }
                }
                .padding()
            }

            // Additional content for appointment booking can be added here
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view if needed
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search Physiotherapists", text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct PhysiotherapistCard: View {
    var physiotherapist: Physiotherapist

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(physiotherapist.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(physiotherapist.name)
                .font(.headline)

            Text(physiotherapist.description)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 150)
    }
}

#Preview {
    appointments()
}

