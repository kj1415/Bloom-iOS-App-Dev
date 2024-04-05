//
//import SwiftUI
//
//// Model for Meal
//struct Meal {
//    var name: String
//    var photo: String // Image name or URL
//    var description: String
//    var benefits: String
//    var ingredients: [String]
//    var youtubeURL: String // Add YouTube URL attribute
//    // Add more properties as needed
//}
//
//
//// Enum to represent meal types
//enum MealType: String, CaseIterable {
//    case breakfast = "Breakfast"
//    case lunch = "Lunch"
//    case snacks = "Snacks"
//    case dinner = "Dinner"
//}
//
//// Sample Indian breakfast data
//let sampleIndianBreakfasts: [Meal] = [
//    Meal(name: "Poha",
//         photo: "poha",
//         description: "Poha is a popular Indian breakfast made from flattened rice.",
//         benefits: "Low in calories and fat. Rich in iron and carbohydrates. Easily digestible and energy-boosting.",
//         ingredients: ["Flattened rice (poha)", "Onion", "Potato", "Peanuts", "Spices"],
//         youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
//    // Add more sample Indian breakfasts here
//]
//
//    
//    // Add more sample Indian breakfasts here
//
//
//// Sample Indian lunch data
//let sampleIndianLunches: [Meal] = [
//    Meal(name: "Grilled Chicken with Vegetables",
//             photo: "grilled",
//             description: "Grilled chicken breast served with a side of grilled vegetables.",
//             benefits: "Rich in protein, vitamins, and minerals. Supports muscle growth and overall health.",
//         ingredients: ["Chicken breast", "Mixed vegetables (like zucchini, bell peppers, onions)", "Olive oil", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=s13rTGimsWg&pp=ygUmZ3JpbGxlZCBjaGlja2VuIHdpdGggdmVnZXRhYmxlcyByZWNpcGU%3D"),
//   
//    // Add sample Indian lunch data here
//]
//
//// Sample Indian snacks data
//let sampleIndianSnacks: [Meal] = [
//    Meal(name: "Samosa",
//             photo: "Samosa",
//             description: "Deep-fried pastry filled with spicy potato filling.",
//             benefits: "Provides energy and essential nutrients. Can be enjoyed as a tasty snack.",
//         ingredients: ["Potatoes", "Peas", "Spices", "Pastry dough"], youtubeURL: "https://www.youtube.com/watch?v=fUGoI0q2Dpc&pp=ygUVc2Ftb3NhIHJlY2lwZSBoZWFsdGh5"),
//        
//    // Add sample Indian snacks data here
//]
//
//// Sample Indian dinner data
//let sampleIndianDinners: [Meal] = [
//    Meal(name: "Palak Paneer",
//            photo: "palak",
//            description: "A creamy spinach curry with chunks of paneer (Indian cottage cheese), flavored with spices.",
//            benefits: "Rich in iron, calcium, and vitamins. Supports bone health and provides essential nutrients.",
//         ingredients: ["Spinach", "Paneer", "Tomatoes", "Onions", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=cRsAQeR5dbI&pp=ygUTcGFsYWsgcGFuZWVyIHJlY2lwZQ%3D%3D"),
//       
//   ]
//    // Add sample Indian dinner data here
//
//
//// Main ContentView displaying meals based on selection
//struct ContentView1: View {
//    @State private var selectedMealType = MealType.breakfast
//    
//    init() {
//           // Customize the appearance of the navigation bar
//           let appearance = UINavigationBarAppearance()
//           appearance.largeTitleTextAttributes = [
//               .font : UIFont.systemFont(ofSize: 20), // Adjust the font size
//               .foregroundColor : UIColor.black // Set the text color
//           ]
//           UINavigationBar.appearance().scrollEdgeAppearance = appearance
//       }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Picker("Select Meal", selection: $selectedMealType) {
//                    ForEach(MealType.allCases, id: \.self) { type in
//                        Text(type.rawValue)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//                
//                MealListView(selectedMealType: selectedMealType)
//            }
//            .navigationTitle("Recipes for Pregnancy")
//            .navigationBarTitleDisplayMode(.automatic) // Set the navigation bar title display mode to inline
//            .navigationBarHidden(false)
//        }
//    }
//}
//
//// View displaying meals based on selected meal type
//// View displaying meals based on selected meal type
//struct MealListView: View {
//    var selectedMealType: MealType
//    
//    var body: some View {
//        List {
//            Section(header: Text("")) {
//                ForEach(sampleIndianBreakfasts, id: \.name) { breakfast in
//                    if selectedMealType == .breakfast {
//                        NavigationLink(destination: MealView(meal: breakfast)) {
//                            MealRowView(meal: breakfast)
//                        }
//                    }
//                }
//            }
//            
//            Section(header: Text("")) {
//                ForEach(sampleIndianLunches, id: \.name) { lunch in
//                    if selectedMealType == .lunch {
//                        NavigationLink(destination: MealView(meal: lunch)) {
//                            MealRowView(meal: lunch)
//                        }
//                    }
//                }
//            }
//            
//            Section(header: Text("")) {
//                ForEach(sampleIndianSnacks, id: \.name) { snack in
//                    if selectedMealType == .snacks {
//                        NavigationLink(destination: MealView(meal: snack)) {
//                            MealRowView(meal: snack)
//                        }
//                    }
//                }
//            }
//            
//            Section(header: Text("")) {
//                ForEach(sampleIndianDinners, id: \.name) { dinner in
//                    if selectedMealType == .dinner {
//                        NavigationLink(destination: MealView(meal: dinner)) {
//                            MealRowView(meal: dinner)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct MealRowView: View {
//    var meal: Meal
//    
//    var body: some View {
//        HStack {
//            Image(meal.photo)
//                .resizable()
//                .frame(width: 50, height: 50)
//                .cornerRadius(8)
//            Text(meal.name)
//                .font(.headline)
//                .padding(.leading, 8) // Add leading padding
//        }
//    }
//}
//
//
//
//
//struct MealView: View {
//    var meal: Meal
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                Image(meal.photo)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                
//                Text(meal.name)
//                    .font(.title)
//                    .padding(.horizontal)
//                
//                Text(meal.description)
//                    .padding(.horizontal)
//                
//                Text("Benefits:")
//                    .font(.headline)
//                    .padding(.horizontal)
//                
//                Text(meal.benefits)
//                    .padding(.horizontal)
//                
//                Text("Ingredients:")
//                    .font(.headline)
//                    .padding(.horizontal)
//                
//                ForEach(meal.ingredients, id: \.self) { ingredient in
//                    Text("• \(ingredient)")
//                        .padding(.horizontal)
//                }
//                
//                Button(action: {
//                    // Open the YouTube URL for this recipe
//                    if let youtubeURL = URL(string: meal.youtubeURL) {
//                        UIApplication.shared.open(youtubeURL)
//                    }
//                }) {
//                    Text("Watch on YouTube")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//            }
//            .padding(.vertical)
//        }
//    }
//}
//
//
//// ContentView_Previews
//struct ContentView1_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView1()
//    }
//}
//
