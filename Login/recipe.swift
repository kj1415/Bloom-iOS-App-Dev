//import SwiftUI
//import WebKit
//
//struct Recipe {
//    var title: String
//    var videoURL: String
//}
//
//enum RecipeCategory: String, CaseIterable {
//    case breakfast = "Breakfast"
//    case lunch = "Lunch"
//    case snacks = "Snacks"
//    case dinner = "Dinner"
//}
//
//struct RecipeListPage: View {
//    let recipes: [Recipe] = [
//        Recipe(title: "Healthy Pregnancy Snacks", videoURL: "https://www.youtube.com/watch?v=LFiZb6Cn_aQ&pp=ygUYaGVhbHRoeSBwcmVnbmFuY3kgc25hY2tz"),
//        Recipe(title: "Healthy Pregnancy Snacks", videoURL: "https://www.youtube.com/watch?v=LFiZb6Cn_aQ&pp=ygUYaGVhbHRoeSBwcmVnbmFuY3kgc25hY2tz"),
//        
//        
//        Recipe(title: "Healthy Breakfast Options", videoURL: "https://www.youtube.com/watch?v=example8"),
//        Recipe(title: "Healthy Breakfast Options", videoURL: "https://www.youtube.com/watch?v=example8"),
//        Recipe(title: "Healthy Breakfast Options", videoURL: "https://www.youtube.com/watch?v=example8"),
//        
//        
//        Recipe(title: "Lunch Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example9"),
//        Recipe(title: "Lunch Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example9"),
//        Recipe(title: "Lunch Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example9"),
//        
//        
//        Recipe(title: "Dinner Recipes for Pregnancy", videoURL: "https://www.youtube.com/watch?v=example10"),
//        Recipe(title: "Dinner Recipes for Pregnancy", videoURL: "https://www.youtube.com/watch?v=example10"),
//        Recipe(title: "Dinner Recipes for Pregnancy", videoURL: "https://www.youtube.com/watch?v=example10"),
//        
////        Recipe(title: "Nutrient-Rich Smoothies", videoURL: "https://www.youtube.com/watch?v=2_MMdqqgqSs&pp=ygUYbnV0cmllbnQgcmljaCBzbW9vdGhpZXMg"),
////        Recipe(title: "Balanced Pregnancy Meals", videoURL: "https://www.youtube.com/watch?v=BLBbEPGJEAY&pp=ygUbYmFsYW5jZWQgcHJlZ25hbmN5IGRpZXQgZW5n"),
////        Recipe(title: "Superfoods for Moms", videoURL: "https://www.youtube.com/watch?v=kYQtHQbmMXk&pp=ygUTc3VwZXJmb29kcyBmb3IgbW9tcw%3D%3D"),
////        Recipe(title: "Indian Pregnancy Recipes", videoURL: "https://www.youtube.com/watch?v=Vk-j6b5-jKs&pp=ygUYSW5kaWFuIHByZWduYW5jeSByZWNpcGVz"),
////        Recipe(title: "Healthy Juices", videoURL: "https://www.youtube.com/watch?v=j6_g5apdKLY&pp=ygUOaGVhbHRoeSBqdWljZXM%3D"),
////        Recipe(title: "Fruit-based Recipes", videoURL: "https://www.youtube.com/watch?v=example7"),
// 
//        
//        
////        Recipe(title: "Snack Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example11"),
////        Recipe(title: "Snack Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example11"),
////        Recipe(title: "Snack Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example11"),
////
////
////        Recipe(title: "Remedy Foods for Moms", videoURL: "https://www.youtube.com/watch?v=example12"),
////        Recipe(title: "Ayurvedic Pregnancy Recipes", videoURL: "https://www.youtube.com/watch?v=example13"),
//    ]
//    
//    @State private var selectedCategory: RecipeCategory = .breakfast
//
//    var body: some View {
//        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(RecipeCategory.allCases, id: \.self) { category in
//                        Button(action: {
//                            self.selectedCategory = category
//                        }) {
//                            Text(category.rawValue)
//                                .font(.headline)
//                                .padding()
//                                .background(self.selectedCategory == category ? Color.teal : Color.gray)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            
//            Divider()
//            
//            NavigationView {
//                switch selectedCategory {
//                case .breakfast:
//                    List(recipes.filter { $0.title.lowercased().contains(selectedCategory.rawValue.lowercased()) }, id: \.title) { recipe in
//                        NavigationLink(destination: RecipeDetailPage(videoURL: recipe.videoURL)) {
//                            RecipeListItem(title: recipe.title, videoURL: recipe.videoURL)
//                        }
//                    }
//                    //.navigationBarTitle("Breakfast", displayMode: .automatic)
//                case .lunch:
//                    List(recipes.filter { $0.title.lowercased().contains(selectedCategory.rawValue.lowercased()) }, id: \.title) { recipe in
//                        NavigationLink(destination: RecipeDetailPage(videoURL: recipe.videoURL)) {
//                            RecipeListItem(title: recipe.title, videoURL: recipe.videoURL)
//                        }
//                    }
//                    //.navigationBarTitle("Lunch", displayMode: .automatic)
//                case .snacks:
//                    List(recipes.filter { $0.title.lowercased().contains(selectedCategory.rawValue.lowercased()) }, id: \.title) { recipe in
//                        NavigationLink(destination: RecipeDetailPage(videoURL: recipe.videoURL)) {
//                            RecipeListItem(title: recipe.title, videoURL: recipe.videoURL)
//                        }
//                    }
//                    //.navigationBarTitle("Snacks", displayMode: .automatic)
//                case .dinner:
//                    List(recipes.filter { $0.title.lowercased().contains(selectedCategory.rawValue.lowercased()) }, id: \.title) { recipe in
//                        NavigationLink(destination: RecipeDetailPage(videoURL: recipe.videoURL)) {
//                            RecipeListItem(title: recipe.title, videoURL: recipe.videoURL)
//                        }
//                    }
//                    //.navigationBarTitle("Dinner", displayMode: .automatic)
//                }
//            }
//        }
//    }
//}
//
//struct RecipeListItem: View {
//    var title: String
//    var videoURL: String // Add videoURL property to fetch the thumbnail
//
//    var body: some View {
//        HStack {
//            // Display the thumbnail image
//            Image(systemName: "play.circle.fill") // Placeholder image
//                .resizable()
//                .frame(width: 100, height: 100) // Adjust size as needed
//                .foregroundColor(Color.blue) // Color of the placeholder
//
//            VStack(alignment: .leading) {
//                Text(title)
//                    .font(.headline)
//                    .padding(.bottom, 4)
//                Text("Description or other details here") // You can add more details if needed
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding(10)
//    }
//
//
////    private func symbolForTitle(_ title: String) -> Image {
////        switch title.lowercased() {
////        case "healthy pregnancy snacks":
////            return Image(systemName: "leaf.arrow.circlepath")
////        case "nutrient-rich smoothies":
////            return Image(systemName: "flame.circle.fill")
////        case "balanced pregnancy meals":
////            return Image(systemName: "square.grid.3x2.fill")
////        case "superfoods for moms":
////            return Image(systemName: "staroflife.circle.fill")
////        case "indian pregnancy recipes":
////            return Image(systemName: "flag.circle.fill")
////        case "healthy juices":
////            return Image(systemName: "drop.circle.fill")
////        case "fruit-based recipes":
////            return Image(systemName: "f.circle.fill")
////        case "healthy breakfast options":
////            return Image(systemName: "sun.max.circle.fill")
////        case "lunch ideas for moms":
////            return Image(systemName: "tray.circle.fill")
////        case "dinner recipes for pregnancy":
////            return Image(systemName: "moon.circle.fill")
////        case "snack ideas for moms":
////            return Image(systemName: "bag.circle.fill")
////        case "remedy foods for moms":
////            return Image(systemName: "pill.circle.fill")
////        case "ayurvedic pregnancy recipes":
////            return Image(systemName: "leaf.circle.fill")
////        default:
////            return Image(systemName: "questionmark.circle.fill")
////        }
////    }
//}
//
//struct RecipeDetailPage: View {
//    var videoURL: String
//
//    var body: some View {
//        WebView(urlString: videoURL)
//            .navigationBarTitle("Recipe Video", displayMode: .inline)
//    }
//}
//
//struct WebView: UIViewRepresentable {
//    let urlString: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // No need to update the view in this simple example
//    }
//}
//
//struct RecipeListPage_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListPage()
//    }
//}
//
//
