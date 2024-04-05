import SwiftUI

// Model for Meal
struct Meal {
    var name: String
    var photo: String // Image name or URL
    var description: String
    var benefits: String
    var ingredients: [String]
    var youtubeURL: String
    // Add more properties as needed
}

// Enum to represent meal types
enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case snacks = "Snacks"
    case dinner = "Dinner"
}

// Sample Indian breakfast data
let sampleIndianBreakfasts: [Meal] = [
    Meal(name: "poha",
         photo: "poha",
         description: "Poha is a popular Indian breakfast made from flattened rice.",
         benefits: "Low in calories and fat. Rich in iron and carbohydrates. Easily digestible and energy-boosting.",
         ingredients: ["Flattened rice (poha)", "Onion", "Potato", "Peanuts", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "upma",
         photo: "upma",
         description: "Upma is a savory South Indian breakfast dish made from semolina.",
         benefits: "High in fiber, vitamins, and minerals. Helps in digestion and keeps you full for longer.",
         ingredients: ["Semolina", "Vegetables (like peas, carrot, capsicum)", "Spices", "Nuts (optional)"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    
        Meal(name: "Idli Sambar",
             photo: "idli",
             description: "Idli is a soft, pillowy rice cake while sambar is a spicy lentil-based vegetable stew.",
             benefits: "Rich in carbohydrates, proteins, and essential nutrients. Easy to digest and provides energy.",
             ingredients: ["Idli batter", "Lentils", "Vegetables (like carrot, tomato, onion)", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Dosa",
             photo: "dosa",
             description: "Dosa is a fermented crepe made from rice batter and black lentils.",
             benefits: "High in carbohydrates and proteins. Contains essential vitamins and minerals. Easily digestible.",
             ingredients: ["Rice batter", "Black lentils", "Vegetable oil", "Potato masala (optional)"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Uttapam",
             photo: "uthappam",
             description: "Uttapam is a thick pancake made from fermented rice and urad dal batter, topped with vegetables.",
             benefits: "Rich in carbohydrates, proteins, and dietary fiber. Provides energy and aids digestion.",
             ingredients: ["Rice and urad dal batter", "Onion", "Tomato", "Capsicum", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Aloo Paratha",
             photo: "allup",
             description: "Aloo paratha is a stuffed Indian bread made from whole wheat flour and filled with a spicy potato mixture.",
             benefits: "Rich in carbohydrates, proteins, and dietary fiber. Provides energy and aids digestion.",
             ingredients: ["Whole wheat flour", "Potatoes", "Spices", "Ghee"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Besan Chilla",
             photo: "besan",
             description: "Besan chilla is a savory pancake made from chickpea flour and spices.",
             benefits: "High in protein, fiber, and essential nutrients. Supports digestion and provides sustained energy.",
             ingredients: ["Chickpea flour (besan)", "Onion", "Tomato", "Green chilies", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    //    Meal(name: "Quinoa Breakfast Bowl",
    //            photo: "quinoa",
    //            description: "A nutritious breakfast bowl made with cooked quinoa, fresh fruits (such as berries and bananas), nuts, and a drizzle of honey or maple syrup.",
    //            benefits: "High in protein, fiber, vitamins, and minerals. Supports digestion and provides sustained energy throughout the day.",
    //            ingredients: ["Quinoa", "Mixed berries", "Banana", "Almonds", "Walnuts", "Honey or maple syrup"]),
    //       Meal(name: "Greek Yogurt Parfait",
    //            photo: "greek",
    //            description: "Layered Greek yogurt with fresh berries, granola, and a drizzle of honey or maple syrup.",
    //            benefits: "High in protein, calcium, and probiotics. Supports bone health and aids digestion.",
    //            ingredients: ["Greek yogurt", "Berries (strawberries, blueberries)", "Granola", "Honey or maple syrup"]),
    //       Meal(name: "Avocado Toast with Poached Egg",
    //            photo: "avocardo",
    //            description: "Whole grain toast topped with mashed avocado, a perfectly poached egg, and a sprinkle of salt and pepper.",
    //            benefits: "Rich in healthy fats, fiber, protein, and essential nutrients. Provides sustained energy and supports baby's growth.",
    //            ingredients: ["Whole grain bread", "Avocado", "Egg", "Salt", "Pepper"]),
    //       Meal(name: "Oatmeal with Nut Butter and Berries",
    //            photo: "oat",
    //            description: "Creamy oatmeal topped with a dollop of nut butter (such as almond or peanut butter), fresh berries, and a drizzle of honey or maple syrup.",
    //            benefits: "High in fiber, protein, and antioxidants. Supports digestion and provides essential nutrients for both mother and baby.",
    //            ingredients: ["Oats", "Nut butter (almond, peanut, etc.)", "Berries (strawberries, blueberries)", "Honey or maple syrup"]),
    //       Meal(name: "Spinach and Feta Omelette",
    //            photo: "spinach",
    //            description: "A fluffy omelette filled with sautéed spinach, crumbled feta cheese, and a sprinkle of fresh herbs.",
    //            benefits: "Packed with protein, iron, and calcium. Supports fetal development and helps prevent anemia.",
    //            ingredients: ["Eggs", "Spinach", "Feta cheese", "Butter", "Salt", "Pepper"]),
    //       Meal(name: "Whole Grain Pancakes with Fresh Fruit",
    //            photo: "pancake",
    //            description: "Fluffy whole grain pancakes served with a variety of fresh fruits (such as berries, sliced bananas, and kiwi) and a drizzle of pure maple syrup.",
    //            benefits: "High in fiber, vitamins, and antioxidants. Provides energy and supports digestion.",
    //            ingredients: ["Whole grain pancake mix", "Fresh fruits (berries, bananas, kiwi, etc.)", "Pure maple syrup"]),
    //       Meal(name: "Chia Seed Pudding",
    //            photo: "chia",
    //            description: "Creamy chia seed pudding made with almond milk, chia seeds, and a touch of vanilla extract, topped with sliced fruits and nuts.",
    //            benefits: "Rich in omega-3 fatty acids, fiber, and antioxidants. Supports heart health and aids digestion.",
    //            ingredients: ["Chia seeds", "Almond milk", "Vanilla extract", "Fresh fruits (strawberries, raspberries, etc.)", "Nuts (almonds, walnuts, etc.)"]),
    //       Meal(name: "Whole Wheat Banana Bread",
    //            photo: "banana_bread",
    //            description: "Homemade whole wheat banana bread made with ripe bananas, whole grain flour, Greek yogurt, and a hint of cinnamon.",
    //            benefits: "High in fiber, potassium, and vitamins. Provides energy and supports digestion.",
    //            ingredients: ["Whole wheat flour", "Ripe bananas", "Greek yogurt", "Eggs", "Honey", "Cinnamon"]),
    //       Meal(name: "Smoothie Bowl",
    //            photo: "smoothie",
    //            description: "Thick and creamy smoothie bowl made with blended fruits (such as berries, bananas, and mango), Greek yogurt, and granola, topped with additional fruits and nuts.",
    //            benefits: "Packed with vitamins, minerals, and probiotics. Supports hydration, digestion, and overall health.",
    //            ingredients: ["Mixed fruits (berries, bananas, mango, etc.)", "Greek yogurt", "Granola", "Honey or maple syrup", "Nuts (almonds, walnuts, etc.)"]),
    //       Meal(name: "Egg and Vegetable Breakfast Burrito",
    //            photo: "burito",
    //            description: "A hearty breakfast burrito filled with scrambled eggs, sautéed vegetables (such as bell peppers, onions, and spinach), and shredded cheese, wrapped in a whole wheat tortilla.",
    //            benefits: "High in protein, fiber, and essential nutrients. Provides energy and supports muscle growth.",
    //            ingredients: ["Eggs", "Bell peppers", "Onion", "Spinach", "Whole wheat tortillas", "Shredded cheese", "Salt", "Pepper"]),
    // Add more sample Indian breakfasts here
]

// Sample Indian lunch data
let sampleIndianLunches: [Meal] = [
    Meal(name: "Grilled Chicken with Vegetables",
             photo: "grilled",
             description: "Grilled chicken breast served with a side of grilled vegetables.",
             benefits: "Rich in protein, vitamins, and minerals. Supports muscle growth and overall health.",
         ingredients: ["Chicken breast", "Mixed vegetables (like zucchini, bell peppers, onions)", "Olive oil", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=s13rTGimsWg&pp=ygUmZ3JpbGxlZCBjaGlja2VuIHdpdGggdmVnZXRhYmxlcyByZWNpcGU%3D"),
    Meal(name: "Salmon with Roasted Vegetables",
             photo: "salmon",
             description: "Baked salmon fillet served with a variety of roasted vegetables.",
             benefits: "Rich in omega-3 fatty acids, protein, and antioxidants. Supports fetal development and heart health.",
         ingredients: ["Salmon fillet", "Mixed vegetables (like asparagus, carrots, potatoes)", "Olive oil", "Lemon", "Herbs"], youtubeURL: "https://www.youtube.com/watch?v=s13rTGimsWg&pp=ygUmZ3JpbGxlZCBjaGlja2VuIHdpdGggdmVnZXRhYmxlcyByZWNpcGU%3D"),
    Meal(name: "Caprese Pasta Salad",
             photo: "pasta",
             description: "A light and refreshing pasta salad made with tomatoes, mozzarella, and fresh basil.",
             benefits: "Rich in antioxidants, calcium, and vitamins. Supports bone health and overall wellness.",
         ingredients: ["Pasta", "Cherry tomatoes", "Fresh mozzarella", "Basil", "Balsamic vinaigrette"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "Spinach and Feta Stuffed Chicken",
            photo: "spichi",
            description: "Chicken breasts stuffed with spinach and feta cheese, baked to perfection.",
            benefits: "Rich in protein, calcium, and vitamins. Supports bone health and muscle growth.",
         ingredients: ["Chicken breasts", "Fresh spinach", "Feta cheese", "Garlic", "Herbs"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    
    Meal(name: "Palak Paneer",
            photo: "palak",
            description: "A creamy spinach curry with chunks of paneer (Indian cottage cheese), flavored with spices.",
            benefits: "Rich in iron, calcium, and vitamins. Supports bone health and provides essential nutrients.",
         ingredients: ["Spinach", "Paneer", "Tomatoes", "Onions", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
       Meal(name: "Dal Tadka",
            photo: "dal",
            description: "Yellow lentils cooked to perfection and tempered with aromatic spices.",
            benefits: "High in protein, fiber, and essential nutrients. Supports digestion and provides energy.",
            ingredients: ["Yellow lentils (toor dal)", "Tomatoes", "Onions", "Garlic", "Cumin seeds"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
//       Meal(name: "Vegetable Biryani",
//            photo: "vegebiri",
//            description: "A fragrant rice dish cooked with mixed vegetables and aromatic spices.",
//            benefits: "Rich in carbohydrates, vitamins, and minerals. Provides sustained energy and essential nutrients.",
//            ingredients: ["Basmati rice", "Mixed vegetables (like carrots, peas, potatoes)", "Spices", "Yogurt"]),
//       Meal(name: "Chole (Chickpea Curry)",
//            photo: "chickpea",
//            description: "Spicy chickpea curry cooked with onions, tomatoes, and a blend of Indian spices.",
//            benefits: "High in protein, fiber, and antioxidants. Supports digestion and provides essential nutrients.",
//            ingredients: ["Chickpeas", "Tomatoes", "Onions", "Ginger", "Spices"]),
//       Meal(name: "Baingan Bharta",
//            photo: "baigan",
//            description: "Smoky roasted eggplant mashed and cooked with onions, tomatoes, and spices.",
//            benefits: "Rich in fiber, vitamins, and antioxidants. Supports digestion and provides essential nutrients.",
//            ingredients: ["Eggplant", "Tomatoes", "Onions", "Garlic", "Spices"]),
//       Meal(name: "Aloo Gobi",
//            photo: "alughobi",
//            description: "A classic Indian dish made with potatoes and cauliflower, cooked with spices.",
//            benefits: "High in vitamins, minerals, and antioxidants. Supports digestion and provides sustained energy.",
//            ingredients: ["Potatoes", "Cauliflower", "Tomatoes", "Spices", "Fresh cilantro"]),
//       Meal(name: "Paneer Butter Masala",
//            photo: "paneerbutter",
//            description: "Soft paneer cubes cooked in a rich and creamy tomato-based sauce, flavored with butter and spices.",
//            benefits: "Rich in protein, calcium, and vitamins. Supports bone health and muscle growth.",
//            ingredients: ["Paneer", "Tomatoes", "Cream", "Butter", "Spices"]),
//       Meal(name: "Vegetable Pulao",
//            photo: "veg-pulao",
//            description: "Fragrant basmati rice cooked with mixed vegetables and aromatic spices.",
//            benefits: "High in carbohydrates, vitamins, and minerals. Provides sustained energy and essential nutrients.",
//            ingredients: ["Basmati rice", "Mixed vegetables (like carrots, beans, bell peppers)", "Spices", "Ghee"]),
//       Meal(name: "Masoor Dal",
//            photo: "masoor-dal",
//            description: "Red lentils cooked with onions, tomatoes, and a blend of Indian spices.",
//            benefits: "High in protein, fiber, and essential nutrients. Supports digestion and provides energy.",
//            ingredients: ["Red lentils (masoor dal)", "Tomatoes", "Onions", "Garlic", "Turmeric"]),
//       Meal(name: "Puri with Aloo Sabzi",
//            photo: "poori",
//            description: "Deep-fried Indian bread served with spicy potato curry.",
//            benefits: "Provides energy and essential nutrients. Can be enjoyed as a comforting meal.",
//            ingredients: ["Whole wheat flour", "Potatoes", "Tomatoes", "Spices"]),
    // Add sample Indian lunch data here
]

// Sample Indian snacks data
let sampleIndianSnacks: [Meal] = [
    Meal(name: "Samosa",
             photo: "Samosa",
             description: "Deep-fried pastry filled with spicy potato filling.",
             benefits: "Provides energy and essential nutrients. Can be enjoyed as a tasty snack.",
         ingredients: ["Potatoes", "Peas", "Spices", "Pastry dough"], youtubeURL: "https://www.youtube.com/watch?v=fUGoI0q2Dpc&pp=ygUVc2Ftb3NhIHJlY2lwZSBoZWFsdGh5"),
        Meal(name: "Dhokla",
             photo: "dhokla",
             description: "Steamed fermented rice and chickpea flour cakes, served with chutney.",
             benefits: "Rich in protein, fiber, and essential nutrients. Easy to digest and provides sustained energy.",
             ingredients: ["Rice flour", "Chickpea flour", "Yogurt", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Bhel Puri",
             photo: "bhel",
             description: "A savory snack made with puffed rice, sev, and chutneys.",
             benefits: "Low in calories and fat. Provides a quick energy boost and satisfies cravings.",
             ingredients: ["Puffed rice", "Sev", "Tomatoes", "Onions", "Chutneys"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Pani Puri",
             photo: "pani-puri",
             description: "Hollow puris filled with spicy and tangy flavored water.",
             benefits: "Provides hydration and essential nutrients. Refreshing and enjoyable as a snack.",
             ingredients: ["Puris", "Mint water", "Tamarind chutney", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
        Meal(name: "Vada Pav",
             photo: "vada",
             description: "Spicy potato fritter sandwiched in a bun, served with chutneys.",
             benefits: "Provides energy and essential nutrients. A popular street food snack in India.",
             ingredients: ["Potatoes", "Buns", "Chutneys", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
//        Meal(name: "Murmura Chivda",
//             photo: "murmura-chivda",
//             description: "Light and crunchy puffed rice snack mixed with nuts and spices.",
//             benefits: "Low in calories and fat. Provides a quick energy boost and satisfies cravings.",
//             ingredients: ["Puffed rice", "Nuts", "Spices"]),
//        Meal(name: "Kachori",
//             photo: "kachori",
//             description: "Deep-fried pastry filled with a spicy lentil filling.",
//             benefits: "Provides energy and essential nutrients. Can be enjoyed as a tasty snack or breakfast.",
//             ingredients: ["Lentils", "Flour", "Spices"]),
//        Meal(name: "Paneer Pakora",
//             photo: "Paneer-Pakora",
//             description: "Paneer cubes coated in chickpea flour batter and deep-fried until crispy.",
//             benefits: "Rich in protein and calcium. Provides energy and essential nutrients.",
//             ingredients: ["Paneer", "Chickpea flour", "Spices"]),
//        Meal(name: "Khandvi",
//             photo: "Khandvi",
//             description: "Soft and melt-in-the-mouth rolls made from gram flour, yogurt, and spices.",
//             benefits: "High in protein and fiber. Supports digestion and provides sustained energy.",
//             ingredients: ["Gram flour", "Yogurt", "Spices"])
    // Add sample Indian snacks data here
]

// Sample Indian dinner data
let sampleIndianDinners: [Meal] = [
    Meal(name: "Palak Paneer",
            photo: "palak",
            description: "A creamy spinach curry with chunks of paneer (Indian cottage cheese), flavored with spices.",
            benefits: "Rich in iron, calcium, and vitamins. Supports bone health and provides essential nutrients.",
         ingredients: ["Spinach", "Paneer", "Tomatoes", "Onions", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=cRsAQeR5dbI&pp=ygUTcGFsYWsgcGFuZWVyIHJlY2lwZQ%3D%3D"),
       Meal(name: "Dal Tadka",
            photo: "dal",
            description: "Yellow lentils cooked to perfection and tempered with aromatic spices.",
            benefits: "High in protein, fiber, and essential nutrients. Supports digestion and provides energy.",
            ingredients: ["Yellow lentils (toor dal)", "Tomatoes", "Onions", "Garlic", "Cumin seeds"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "Vegetable Biryani",
         photo: "vegebiri",
         description: "A fragrant rice dish cooked with mixed vegetables and aromatic spices.",
         benefits: "Rich in carbohydrates, vitamins, and minerals. Provides sustained energy and essential nutrients.",
         ingredients: ["Basmati rice", "Mixed vegetables (like carrots, peas, potatoes)", "Spices", "Yogurt"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "Chole (Chickpea Curry)",
         photo: "chickpea",
         description: "Spicy chickpea curry cooked with onions, tomatoes, and a blend of Indian spices.",
         benefits: "High in protein, fiber, and antioxidants. Supports digestion and provides essential nutrients.",
         ingredients: ["Chickpeas", "Tomatoes", "Onions", "Ginger", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "Baingan Bharta",
         photo: "baigan",
         description: "Smoky roasted eggplant mashed and cooked with onions, tomatoes, and spices.",
         benefits: "Rich in fiber, vitamins, and antioxidants. Supports digestion and provides essential nutrients.",
         ingredients: ["Eggplant", "Tomatoes", "Onions", "Garlic", "Spices"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
    Meal(name: "Aloo Gobi",
         photo: "alughobi",
         description: "A classic Indian dish made with potatoes and cauliflower, cooked with spices.",
         benefits: "High in vitamins, minerals, and antioxidants. Supports digestion and provides sustained energy.",
         ingredients: ["Potatoes", "Cauliflower", "Tomatoes", "Spices", "Fresh cilantro"], youtubeURL: "https://www.youtube.com/watch?v=2_BkfGRcx3o&pp=ygULcG9oYSByZWNpcGU%3D"),
//    Meal(name: "Paneer Butter Masala",
//         photo: "paneerbutter",
//         description: "Soft paneer cubes cooked in a rich and creamy tomato-based sauce, flavored with butter and spices.",
//         benefits: "Rich in protein, calcium, and vitamins. Supports bone health and muscle growth.",
//         ingredients: ["Paneer", "Tomatoes", "Cream", "Butter", "Spices"]),
//    Meal(name: "Vegetable Pulao",
//         photo: "veg-pulao",
//         description: "Fragrant basmati rice cooked with mixed vegetables and aromatic spices.",
//         benefits: "High in carbohydrates, vitamins, and minerals. Provides sustained energy and essential nutrients.",
//         ingredients: ["Basmati rice", "Mixed vegetables (like carrots, beans, bell peppers)", "Spices", "Ghee"]),
//    Meal(name: "Masoor Dal",
//         photo: "masoor-dal",
//         description: "Red lentils cooked with onions, tomatoes, and a blend of Indian spices.",
//         benefits: "High in protein, fiber, and essential nutrients. Supports digestion and provides energy.",
//         ingredients: ["Red lentils (masoor dal)", "Tomatoes", "Onions", "Garlic", "Turmeric"]),
//    Meal(name: "Puri with Aloo Sabzi",
//         photo: "poori",
//         description: "Deep-fried Indian bread served with spicy potato curry.",
//         benefits: "Provides energy and essential nutrients. Can be enjoyed as a comforting meal.",
//         ingredients: ["Whole wheat flour", "Potatoes", "Tomatoes", "Spices"]),
   ]
    // Add sample Indian dinner data here


// Main ContentView displaying meals based on selection
struct ContentView1: View {
    @State private var selectedMealType = MealType.breakfast
    
    init() {
        // Customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20), // Adjust the font size
            .foregroundColor: UIColor.black // Set the text color
        ]
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16), // Adjust the font size
            .foregroundColor: UIColor.black // Set the text color
        ]
        
        // Set the height of the navigation bar
        appearance.backgroundColor = .clear // Set background color to clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Meal", selection: $selectedMealType) {
                    ForEach(MealType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                MealListView(selectedMealType: selectedMealType)
            }
            .navigationTitle("Recipes for Pregnancy")
            .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title display mode to inline
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
        }
    }
}


// View displaying meals based on selected meal type
// View displaying meals based on selected meal type
struct MealListView: View {
    var selectedMealType: MealType
    
    var body: some View {
        List {
            //Section(header: Text("")) {
            ForEach(sampleIndianBreakfasts, id: \.name) { breakfast in
                if selectedMealType == .breakfast {
                    NavigationLink(destination: MealView(meal: breakfast)) {
                        MealRowView(meal: breakfast)
                    }
                    .navigationBarHidden(true)
                }
                    
            }
        //}
            
            
            //Section(header: Text("")) {
                ForEach(sampleIndianLunches, id: \.name) { lunch in
                    if selectedMealType == .lunch {
                        NavigationLink(destination: MealView(meal: lunch)) {
                            MealRowView(meal: lunch)
                        }
                    }
                        
                }
            //}
            
           // Section(header: Text("")) {
                ForEach(sampleIndianSnacks, id: \.name) { snack in
                    if selectedMealType == .snacks {
                        NavigationLink(destination: MealView(meal: snack)) {
                            MealRowView(meal: snack)
                        }
                    }
                }
          //  }
            
           // Section(header: Text("")) {
                ForEach(sampleIndianDinners, id: \.name) { dinner in
                    if selectedMealType == .dinner {
                        NavigationLink(destination: MealView(meal: dinner)) {
                            MealRowView(meal: dinner)
                        }
                    }
                }
           // }
        }
    }
}

// View for each meal row
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
//        }
//    }
//}
struct MealRowView: View {
    var meal: Meal
    
    var body: some View {
        HStack {
            Image(meal.photo)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            Text(meal.name)
                .font(.headline)
                .padding(.leading, 8) // Add leading padding
        }
    }
}
// Detailed view for each meal
//struct MealView: View {
//    var meal: Meal
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Image(meal.photo)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(10)
//                .padding()
//
//            Text(meal.name)
//                .font(.title)
//                .padding(.horizontal)
//
//            Text(meal.description)
//                .padding(.horizontal)
//                .padding(.top, 4)
//
//            Text("Benefits:")
//                .font(.headline)
//                .padding(.horizontal)
//                .padding(.top, 8)
//
//            Text(meal.benefits)
//                .padding(.horizontal)
//                .padding(.bottom)
//
//            Text("Ingredients:")
//                .font(.headline)
//                .padding(.horizontal)
//                .padding(.top, 8)
//
//            VStack(alignment: .leading, spacing: 4) {
//                ForEach(meal.ingredients, id: \.self) { ingredient in
//                    Text("• \(ingredient)")
//                        .padding(.horizontal)
//                }
//            }
//        }
//    }
//}



struct MealView: View {
    var meal: Meal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(meal.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text(meal.name)
                    .font(.title)
                    .padding(.horizontal)
                
                Text(meal.description)
                    .padding(.horizontal)
                
                Text("Benefits:")
                    .font(.headline)
                    .padding(.horizontal)
                
                Text(meal.benefits)
                    .padding(.horizontal)
                
                Text("Ingredients:")
                    .font(.headline)
                    .padding(.horizontal)
                
                
                ForEach(meal.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .padding(.horizontal)
                    
                }
                
                Button(action: {
                    // Open the YouTube URL for this recipe
                    if let youtubeURL = URL(string: meal.youtubeURL) {
                        UIApplication.shared.open(youtubeURL)
                    }
                }) {
                    Text("Watch on YouTube")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.teal.opacity(0.8))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// ContentView_Previews
struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

