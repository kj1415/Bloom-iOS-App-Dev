import SwiftUI

struct Checkup {
    var month: String
    var description: String
}

struct CheckupListView: View {
    var checkups: [Checkup]
    
    var body: some View {
        List {
            ForEach(checkups, id: \.month) { checkup in
                NavigationLink(destination: CheckupDetailView(checkup: checkup)) {
                    CheckupRowView(checkup: checkup)
                }
            }
        }
        .navigationTitle("Pregnancy Checkups")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }
}

struct CheckupRowView: View {
    var checkup: Checkup
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(checkup.month)
                .font(.headline)
                .foregroundColor(.blue) // Set month text color to blue
            Text(checkup.description)
                .foregroundColor(.secondary)
                .lineLimit(2) // Limit description to two lines
        }
        .padding(.vertical, 8)
    }
}

struct CheckupDetailView: View {
    var checkup: Checkup
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(checkup.month)
                    .font(.title)
                Text(checkup.description)
            }
            .padding()
        }
    }
}

struct ContentView3: View {
    let checkups: [Checkup] = [
            Checkup(month: "First Trimester", description: "Confirmation of pregnancy by a healthcare provider."),
            Checkup(month: "Second trimester", description: "Follow-up prenatal visit to monitor the progress of the pregnancy."),
            Checkup(month: "Third Trimester", description: "Continued prenatal care visits, usually once a month."),
        
        ]
    
    var body: some View {
        NavigationView {
            CheckupListView(checkups: checkups)
        }
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}


