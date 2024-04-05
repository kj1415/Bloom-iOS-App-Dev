import SwiftUI

// Model for Exercise
struct Exercise {
    var name: String
    var description: String
    var benefits: String
    var instructions: String
    var photo: String // Image name or URL
    // Add more properties as needed
}

// Sample exercise data
let sampleExercises: [Exercise] = [
    Exercise(name: "Walking",
             description: "A simple yet effective low-impact exercise that can be done anywhere.",
             benefits: "Improves cardiovascular health, boosts mood, and strengthens muscles.",
             instructions: "Walk briskly for 30 minutes daily.",
             photo: "walking"),
    Exercise(name: "Yoga",
             description: "A practice that combines physical postures, breathing exercises, and meditation.",
             benefits: "Increases flexibility, improves balance, reduces stress, and enhances mental well-being.",
             instructions: "Follow a guided yoga routine for 20-30 minutes daily.",
             photo: "yoga"),
    Exercise(name: "Swimming",
             description: "A full-body workout that is gentle on the joints.",
             benefits: "Builds muscle strength, improves endurance, and increases flexibility.",
             instructions: "Swim laps for 30 minutes in a pool.",
             photo: "swim"),
    Exercise(name: "Prenatal Yoga",
                description: "Yoga tailored specifically for pregnant women, focusing on gentle stretches and breathing techniques.",
                benefits: "Promotes relaxation, relieves back pain, improves flexibility, and prepares the body for childbirth.",
                instructions: "Attend a prenatal yoga class or follow online videos designed for pregnant women.",
                photo: "prenatal"),
       Exercise(name: "Pelvic Tilts",
                description: "An exercise to strengthen the abdominal muscles and reduce lower back pain.",
                benefits: "Helps maintain pelvic alignment, improves posture, and prepares the body for labor.",
                instructions: "Lie on your back with knees bent. Tighten your abdominal muscles and tilt your pelvis upward, then release. Repeat 10-15 times.",
                photo: "pelvic"),
       Exercise(name: "Kegel Exercises",
                description: "Exercises to strengthen the pelvic floor muscles, which support the bladder, uterus, and bowels.",
                benefits: "Prevents urinary incontinence, supports the pelvic organs, and aids in postpartum recovery.",
                instructions: "Contract the muscles you would use to stop the flow of urine. Hold for 5-10 seconds, then relax. Repeat 10-15 times.",
                photo: "kegal"),
      
       Exercise(name: "Prenatal Pilates",
                description: "A form of exercise that focuses on strengthening the core, improving flexibility, and enhancing body awareness.",
                benefits: "Builds abdominal strength, improves posture, and reduces the risk of back pain during pregnancy.",
                instructions: "Join a prenatal Pilates class led by a certified instructor.",
                photo: "pilates")
    // Add more sample exercises here
]

// Exercise View
struct ExerciseView: View {
    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(exercise.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
            
            Text(exercise.name)
                .font(.title)
                .padding(.bottom, 4)
            
            Text(exercise.description)
                .foregroundColor(.gray)
                .padding(.bottom, 4)
            
            Text("Benefits:")
                .font(.headline)
                .padding(.bottom, 4)
            
            Text(exercise.benefits)
                .padding(.bottom, 4)
            
            Text("Instructions:")
                .font(.headline)
                .padding(.bottom, 4)
            
            Text(exercise.instructions)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

// Main ContentView displaying exercises
struct ExercisePage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(sampleExercises, id: \.name) { exercise in
                        NavigationLink(destination: ExerciseView(exercise: exercise)) {
                            ExerciseRowView(exercise: exercise)
                        }
                    }
                }
                .padding()
            } .navigationBarHidden(false)
                .navigationBarTitle("Exercises          ", displayMode: .inline) // Set custom navigation bar title
                .navigationBarTitleDisplayMode(.inline)
       
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

// Exercise Row View
struct ExerciseRowView: View {
    var exercise: Exercise
    
    var body: some View {
        HStack {
            Image(exercise.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            Text(exercise.name)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Preview
struct ExercisePage_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePage()
    }
}

