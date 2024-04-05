//import SwiftUI
//import WebKit
//
//struct Exercise {
//    var title: String
//    var videoURL: String
//}
//
//struct ExerciseListPage: View {
//    let exercises: [Exercise] = [
//        Exercise(title: "Prenatal Yoga", videoURL: "https://www.youtube.com/watch?v=example1"),
//        Exercise(title: "Low-Impact Cardio", videoURL: "https://www.youtube.com/watch?v=example2"),
//        Exercise(title: "Pelvic Floor Exercises", videoURL: "https://www.youtube.com/watch?v=example3"),
//        Exercise(title: "Prenatal Strength Training", videoURL: "https://www.youtube.com/watch?v=example4"),
//        Exercise(title: "Stretching Routine", videoURL: "https://www.youtube.com/watch?v=example5"),
//        Exercise(title: "Prenatal Pilates", videoURL: "https://www.youtube.com/watch?v=example6"),
//    ]
//
//    var body: some View {
//        NavigationView {
//            List(exercises, id: \.title) { exercise in
//                NavigationLink(destination: ExerciseDetailPage(videoURL: exercise.videoURL)) {
//                    ExerciseListItem(title: exercise.title)
//                }
//            }
//            //.navigationBarTitle("Pregnancy Exercises", displayMode: .automatic)
//            
////            .navigationBarItems(leading: Button(action: {
////                // Handle back button action
////            }) {
////                Image(systemName: "arrow.left.circle.fill")
////                    .resizable()
////                    .frame(width: 30, height: 30)
////                    .foregroundColor(Color.teal)
////            })
//        }
//    }
//}
//
//struct ExerciseListItem: View {
//    var title: String
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                HStack(spacing: 8) {
//                    Image(systemName: symbolForTitle(title))
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color(.systemTeal))
//                    Text(title)
//                        .font(.headline)
//                        .padding(.bottom, 4)
//                }
//                Divider()
//                    .background(Color.gray)
//            }
//           
//        }
//        .padding(20)
//    }
//
//    private func symbolForTitle(_ title: String) -> String {
//        switch title.lowercased() {
//        case "prenatal yoga":
//            return "person.2.circle.fill"
//        case "low-impact cardio":
//            return "heart.circle.fill"
//        case "pelvic floor exercises":
//            return "arrow.down.to.line.alt"
//        case "prenatal strength training":
//            return "dumbbell.fill"
//        case "stretching routine":
//            return "arrow.right.to.line.alt"
//        case "prenatal pilates":
//            return "star.circle.fill"
//        default:
//            return "questionmark.circle.fill"
//        }
//    }
//}
//
//struct ExerciseDetailPage: View {
//    var videoURL: String
//
//    var body: some View {
//        WebView(urlString: videoURL)
//            .navigationBarTitle("Exercise Video", displayMode: .inline)
//    }
//}
//
//struct ExerciseListPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseListPage()
//    }
//}
//
