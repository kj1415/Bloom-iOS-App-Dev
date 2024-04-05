import SwiftUI
import HealthKit
import Firebase
import FirebaseFirestore


//struct HealthKitManager {
//    static let shared = HealthKitManager()
//    
//    func getWalkingDistance(completion: @escaping (Result<Double, Error>) -> Void) {
//        // Implement logic to retrieve walking distance from HealthKit
//        // For demonstration purposes, let's assume we have a sample value of walking distance
//        let walkingDistance: Double = 5.0 // Sample value in kilometers
//        completion(.success(walkingDistance))
//    }
//    
//    func getStepCount(completion: @escaping (Result<Int, Error>) -> Void) {
//        // Implement logic to retrieve step count from HealthKit
//        // For demonstration purposes, let's assume we have a sample value of step count
//        let stepCount: Int = 1000 // Sample value
//        completion(.success(stepCount))
//    }
//    
//    func getHeartRate(completion: @escaping (Result<Int, Error>) -> Void) {
//        // Implement logic to retrieve heart rate from HealthKit
//        // For demonstration purposes, let's assume we have a sample value of heart rate
//        let heartRate: Int = 75 // Sample value in bpm
//        completion(.success(heartRate))
//    }
//    
//    func getHoursOfSleep(completion: @escaping (Result<Double, Error>) -> Void) {
//        // Implement logic to retrieve hours of sleep from HealthKit
//        // For demonstration purposes, let's assume we have a sample value of hours of sleep
//        let hoursOfSleep: Double = 8.0 // Sample value in hours
//        completion(.success(hoursOfSleep))
//    }
//}


struct HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    
    func getWalkingDistance(completion: @escaping (Result<Double, Error>) -> Void) {
        guard let walkingDistanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Walking distance type not found"])))
            return
        }
        
        let query = HKStatisticsQuery(quantityType: walkingDistanceType, quantitySamplePredicate: nil, options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch walking distance"])))
                }
                return
            }
            let distanceInMeters = sum.doubleValue(for: HKUnit.meter())
            let distanceInKilometers = distanceInMeters / 1000.0
            completion(.success(distanceInKilometers))
        }
        
        healthStore.execute(query)
    }
    
    func getStepCount(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Step count type not found"])))
            return
        }
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: nil, options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch step count"])))
                }
                return
            }
            let stepCount = Int(sum.doubleValue(for: HKUnit.count()))
            completion(.success(stepCount))
        }
        
        healthStore.execute(query)
    }
    
    func getHeartRate(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Heart rate type not found"])))
            return
        }
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: nil, options: .discreteMostRecent) { query, result, error in
            guard let result = result, let mostRecentSample = result.mostRecentQuantity() else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch heart rate"])))
                }
                return
            }
            let heartRate = Int(mostRecentSample.doubleValue(for: HKUnit.init(from: "count/min")))
            completion(.success(heartRate))
        }
        
        healthStore.execute(query)
    }
    
    func getHoursOfSleep(completion: @escaping (Result<Double, Error>) -> Void) {
        guard let sleepAnalysisType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sleep analysis type not found"])))
            return
        }
        
        let query = HKSampleQuery(sampleType: sleepAnalysisType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            guard let samples = samples else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch sleep data"])))
                }
                return
            }
            var totalSleepHours = 0.0
            for sample in samples {
                if let sample = sample as? HKCategorySample {
                    let start = sample.startDate
                    let end = sample.endDate
                    let duration = end.timeIntervalSince(start) / 3600.0 // Convert seconds to hours
                    totalSleepHours += duration
                }
            }
            completion(.success(totalSleepHours))
        }
        
        healthStore.execute(query)
    }
}
struct VitalsRectangleCard: View {
    var title: String
    var value: String
    var symbol: String
    var color: Color
    var action: () -> Void
    
    @State private var showValue = false

    var body: some View {
        Button(action: {
            action()
            showValue.toggle()
        }) {
            VStack {
                if showValue {
                    Text(value)
                        .font(.title)
                        .padding(.top, 20)
                        .foregroundColor(.white)
                } else {
                    VStack {
                        Image(systemName: symbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .frame(width: 130, height: 130)
            .background(
                Circle()
                    .fill(color)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                            .padding(2)
                    )
            )
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                    .padding(2)
            )
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


   private var today: Date {
       Date()
   }

struct HomePageView: View {
    @State private var currentWeek: CGFloat = 0
    @State private var userName: String = ""
    @State private var lastMenstrualCycle: Date = Date()
    @State private var isProfilePagePresented = false
    @State private var currentDateIndex: Int = 0
    @State private var babyHeight: String = "0.0" // Default value is "0.0"
    @State private var babyWeight: String = "0.0"
    @State private var walkingDistance: Double?
    @State private var stepsCount: Int?
    @State private var heartRate: Int?
    @State private var hoursOfSleep: Double?

    let calendar = Calendar.current
    // List of baby lengths for each week in centimeters
    private let babyHeights: [String] = [
        "1.6",  // 8 weeks
        "2.3",  // 9 weeks
        "3.1",  // 10 weeks
        "4.1",  // 11 weeks
        "5.4",  // 12 weeks
        "7.4",  // 13 weeks
        "8.7",  // 14 weeks
        "10.1", // 15 weeks
        "11.6", // 16 weeks
        "13",   // 17 weeks
        "14.2", // 18 weeks
        "15.3", // 19 weeks
        "16.4", // 20 weeks
        "26.7", // 21 weeks
        "27.8", // 22 weeks
        "28.9", // 23 weeks
        "30",   // 24 weeks
        "34.6", // 25 weeks
        "35.6", // 26 weeks
        "36.6", // 27 weeks
        "37.6", // 28 weeks
        "38.6", // 29 weeks
        "39.9", // 30 weeks
        "41.1", // 31 weeks
        "42.4", // 32 weeks
        "43.7", // 33 weeks
        "45",   // 34 weeks
        "46.2", // 35 weeks
        "47.4", // 36 weeks
        "48.6", // 37 weeks
        "49.8", // 38 weeks
        "50.7", // 39 weeks
        "51.2" // 15 weeks
        
    ]


        // List of baby weights for each week
        private let babyWeights: [String] = [
            "1",    // 8 weeks
                "2",    // 9 weeks
                "4",    // 10 weeks
                "7",    // 11 weeks
                "14",   // 12 weeks
                "23",   // 13 weeks
                "43",   // 14 weeks
                "70",   // 15 weeks
                "100",  // 16 weeks
                "140",  // 17 weeks
                "190",  // 18 weeks
                "240",  // 19 weeks
                "300",  // 20 weeks
                "360",  // 21 weeks
                "430",  // 22 weeks
                "501",  // 23 weeks
                "600",  // 24 weeks
                "660",  // 25 weeks
                "760",  // 26 weeks
                "875",  // 27 weeks
                "1005", // 28 weeks
                "1153", // 29 weeks
                "1319", // 30 weeks
                "1502", // 31 weeks
                "1702", // 32 weeks
                "1918", // 33 weeks
                "2146", // 34 weeks
                "2383", // 35 weeks
                "2622", // 36 weeks
                "2859", // 37 weeks
                "3083", // 38 weeks
                "3288", // 39 weeks
                "3462"   // 15 weeks
              
            // Add more weights for each week...
        ]

    var body: some View {
        ScrollView{
            let today = Date()
            VStack {
                // Navigation Bar
                HStack {
                    Spacer();
                    
                    
                    NavigationLink(destination: Settings(), isActive: $isProfilePagePresented) {
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
                    
                    Button(action: {
                        isProfilePagePresented = true
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.cyan)
                            .padding(.trailing, 40)
                    }
                    
                    
                }
                .padding(.top, 10)
                
                
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(Color.gray, lineWidth: 5)
                                .opacity(0.3)
                                .frame(width: 180, height: 180)
                                .alignmentGuide(.top) { $0[.top] }
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(min(1.0, currentWeek / 40.0))) // Normalize to the range [0, 1]
                                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)) // Adjust the lineWidth to make it smaller
                                .foregroundColor(Color.blue)
                                .rotationEffect(Angle(degrees: 270))
                                .frame(width: 180, height: 180) //
                            Image("img8")
                                .resizable()
                                .frame(width: 75, height: 75) // Adjust the frame size to make it smaller
                                .foregroundColor(.blue)
                        }
                        .padding(.leading,-20)
                        VStack(alignment: .leading) {
                            Text("Height: \(babyHeight) cm")
                            
                            Text("Weight: \(babyWeight) grams")
                        }
                        .padding(.leading,40)
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundColor(Color.white.opacity(0.4))
                        .overlay(
                            Text("You are \(Int((currentWeek))) weeks Pregnant")
                                .foregroundColor(.teal)
                                .font(.subheadline)
                            
                                .padding(.top,10)
                                .padding(.leading,30)
                        )
                }
                
                
//                Slider(value: $currentWeek, in: 1...40, step: 1)
//                    .frame(width:360,height: 20) // Adjust the height of the slider
//                    .padding(.horizontal)
//                    .disabled(true) // Prevent user interaction with the slider
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        if let walkingDistance = walkingDistance {
                            VStack {
                                VitalsRectangleCard(title: "Walking Distance", value: formatValue(walkingDistance, unit: "km"), symbol: "figure.walk", color: Color.teal.opacity(0.8)) {
                                    print("Walking Distance: \(walkingDistance)")
                                }
                               .frame(width: 150, height: 150) // Adjust size of the card
                                Spacer() // Add spacer to prevent overlapping
                            }
                        }
                        if let heartRate = heartRate {
                            VStack {
                                VitalsRectangleCard(title: "Heart Rate", value: formatValue(Double(heartRate), unit: "bpm"), symbol: "heart.fill", color: Color.teal.opacity(0.8)) {
                                    print("Heart Rate: \(heartRate)")
                                }
                               .frame(width: 150, height: 150) // Adjust size of the card
                                Spacer() // Add spacer to prevent overlapping
                            }
                        }
                        if let stepsCount = stepsCount {
                            VStack {
                                VitalsRectangleCard(title: "Steps", value: formatValue(Double(stepsCount)), symbol: "shoeprints.fill", color: Color.teal.opacity(0.8)) {
                                    print("Steps: \(stepsCount)")
                                }
                               .frame(width: 150, height: 150) // Adjust size of the card
                                Spacer() // Add spacer to prevent overlapping
                            }
                        }
                        if let hoursOfSleep = hoursOfSleep {
                            VStack {
                                VitalsRectangleCard(title: "Sleep", value: formatValue(hoursOfSleep, unit: "hrs"), symbol: "moon.zzz.fill", color: Color.teal.opacity(0.8)) {
                                    print("Sleep: \(hoursOfSleep)")
                                }
                               .frame(width: 150, height: 150) // Adjust size of the card
                                Spacer() // Add spacer to prevent overlapping
                            }
                        }
                    }
                   .padding()
                }

                VStack(spacing: 10) {
                    Text("Prenatal Nuggets:") // Text field with the title
                    //.font(.title3)
                    //.font(.custom("SF Pro", size: 22))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top,30)
                        .padding()
                        .frame(alignment: .leading)
                    InfoSection(title: "Baby 🍼", data: babyData(forWeek: Int(currentWeek)), color: Color(red: 1.0, green: 0.8, blue: 0.8)) // Dark teal
                    InfoSection(title: "Mother 🤰🏻", data: motherData(forWeek: Int(currentWeek)), color: Color(red: 1.0, green: 0.85, blue: 0.7)) // Light teal
                    InfoSection(title: "Useful Advice 🌷", data: adviceData(forWeek: Int(currentWeek)), color: Color(red: 0.27, green: 0.70, blue: 0.70)) // Dark teal
                }
                .padding(.horizontal)
                .padding(.bottom)
                
            }
            
            Text("Recommendations") // Text field with the title
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top,30)
                .padding()
                .frame(alignment: .leading)
            LargeSquareButtonsScrollView()
            .padding(.top,10)
//            .onAppear {
//                // Update current week
//                let currentDate = Date()
//                currentWeek = calculateCurrentWeek(from: currentDate, and: lastMenstrualCycle)
//
//                // Fetch user data from Firestore
//                fetchUserData()
//                updateBabyHeightAndWeight(for: Int(currentWeek))
//            }
            MilestoneTrackerView()
        }
                    .onAppear {
                        // Update current week
                        let currentDate = Date()
                        currentWeek = calculateCurrentWeek(from: currentDate, and: lastMenstrualCycle)
        
                        // Fetch user data from Firestore
                        fetchUserData()
                        updateBabyHeightAndWeight(for: Int(currentWeek))
                        requestHealthKitAuthorization()
                    }
    }
    
    private func formatValue(_ value: Double, unit: String? = nil) -> String {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           formatter.maximumFractionDigits = 1

           if let unit = unit {
               return "\(formatter.string(from: NSNumber(value: value)) ?? "") \(unit)"
           } else {
               return formatter.string(from: NSNumber(value: value)) ?? ""
           }
       }

    private func requestHealthKitAuthorization() {
        let healthStore = HKHealthStore()
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead) { (success, error) in
            if !success {
                if let error = error {
                    print("HealthKit authorization request failed: \(error.localizedDescription)")
                }
            } else {
                self.fetchHealthData()
            }
        }
    }


    private func fetchHealthData() {
        HealthKitManager.shared.getWalkingDistance { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let distance):
                    self.walkingDistance = distance
                case .failure(let error):
                    print("Failed to fetch walking distance: \(error.localizedDescription)")
                }
            }
        }

        HealthKitManager.shared.getStepCount { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let steps):
                    self.stepsCount = steps
                case .failure(let error):
                    print("Failed to fetch step count: \(error.localizedDescription)")
                }
            }
        }

        HealthKitManager.shared.getHeartRate { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate):
                    self.heartRate = rate
                case .failure(let error):
                    print("Failed to fetch heart rate: \(error.localizedDescription)")
                }
            }
        }

        HealthKitManager.shared.getHoursOfSleep { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let hours):
                    self.hoursOfSleep = hours
                case .failure(let error):
                    print("Failed to fetch hours of sleep: \(error.localizedDescription)")
                }
            }
        }
    }


    
    private func updateBabyHeightAndWeight(for week: Int) {
            guard week > 0 && week <= babyHeights.count else {
                return
            }
            babyHeight = babyHeights[week - 1]
            babyWeight = babyWeights[week - 1]
        }
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    // Helper function to calculate the current week of pregnancy
    private func calculateCurrentWeek(from currentDate: Date, and lastMenstrualCycleDate: Date) -> CGFloat {
        let daysSinceLastCycle = calendar.dateComponents([.day], from: lastMenstrualCycleDate, to: currentDate).day!
        let weeksSinceLastCycle = CGFloat(daysSinceLastCycle) / 7
        return weeksSinceLastCycle
    }

    // Helper function to calculate the date for a given index
    private func calculateDate(for index: Int) -> Date {
        return calendar.date(byAdding: .day, value: index, to: lastMenstrualCycle)!
    }

    private func getWeekRange() -> [Int] {
        return Array(1...40)
    }

    
    private func currentDateIndexFor(_ date: Date) -> Int {
        let startIndex = calendar.startOfDay(for: lastMenstrualCycle)
        let endIndex = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startIndex, to: endIndex)
        return components.day!
    }
    
    // Fetch user data from Firestore
    private func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: UID is nil")
            return
        }

        let db = Firestore.firestore()
        db.collection("details").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                if let lastMenstrualCycleTimestamp = document["lastMenstrualCycle"] as? Timestamp {
                    self.lastMenstrualCycle = lastMenstrualCycleTimestamp.dateValue()

                    // Update other data dependent on user details if needed
                    let currentDate = Date()
                    self.currentWeek = calculateCurrentWeek(from: currentDate, and: self.lastMenstrualCycle)
                    updateBabyHeightAndWeight(for: Int(self.currentWeek))
                }
            } else {
                print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    
    private func babyData(forWeek week: Int) -> String {
        // Define text for each week
        let babyData: [String] = [
            // Week 1 to 40
            "Fertilization occurs. The fertilized egg, called a zygote, begins to divide rapidly.",
            "The zygote travels down the fallopian tube and implants itself into the uterine lining.",
            "The zygote develops into a blastocyst with an inner cell mass that will become the embryo and an outer cell mass that will become the placenta.",
            "The embryo develops a neural tube, which will become the brain and spinal cord. The heart begins to form.",
            "The heart continues to develop, and blood begins to circulate. Limb buds start to appear.",
            "Facial features, such as eyes, ears, and nostrils, begin to form. The brain continues to develop.",
            "Arms and legs become more defined, and fingers and toes start to form. The embryo begins to move, although it's too early for the mother to feel.",
            "Organs and tissues continue to develop. The embryo's tail starts to disappear.",
            "The embryo is now called a fetus. Facial features become more distinct, and external genitalia begin to develop.",
            "The fetus can move its limbs, although movements are still small and uncoordinated. Tooth buds begin to form.",
            "Facial features are fully formed, although they may still look disproportionate. The fetus can swallow and urinate.",
            "The fetus is now about the size of a plum. It can open and close its fists and mouth.",
            "The fetus's intestines begin to move from the umbilical cord into the abdomen.",
            "Fine hair called lanugo begins to cover the fetus's body. It can make facial expressions, such as frowning.",
            "The fetus can sense light and may be able to hear sounds from the outside world.",
            "The fetus's skin is transparent and covered with vernix, a protective substance. It can suck its thumb.",
            "The fetus's skeleton starts to harden, and it begins to store fat under its skin.",
            "The fetus's movements become more coordinated, and the mother may start to feel kicks.",
            "The fetus's senses continue to develop, and it can now perceive touch.",
            "The fetus is now halfway through gestation. It may start to develop patterns of wakefulness and sleep.",
            "Eyebrows and eyelashes start to appear, and the fetus's taste buds develop.",
            "The fetus's lungs continue to develop, and it begins to produce surfactant, a substance that helps the lungs inflate after birth.",
            "The fetus's hearing is well-developed, and it can recognize its mother's voice.",
            "The fetus's skin becomes less wrinkled as it accumulates more fat.",
            "The fetus's brain continues to develop, and it may start to exhibit more complex behaviors, such as yawning.",
            "The fetus's eyes open for the first time, although they lack pigmentation.",
            "The fetus's lungs continue to mature, and it may be able to survive outside the womb with intensive medical care.",
            "The fetus's movements become more vigorous as it grows larger.",
            "The fetus's brain undergoes rapid development, and it begins to regulate its own body temperature.",
            "The fetus's bones are fully developed, but they are still soft and pliable.",
            "The fetus's immune system begins to mature as it produces its own antibodies.",
            "The fetus's toenails and fingernails are fully formed, and its head may engage in the mother's pelvis in preparation for birth.",
            "The fetus's bones continue to harden, although its skull remains soft to facilitate passage through the birth canal.",
            "The fetus's kidneys are fully developed, and it can urinate regularly.",
            "The fetus's movements may decrease as it grows larger and has less room to maneuver.",
            "The fetus continues to gain weight rapidly as it prepares for birth.",
            "The fetus is considered full-term and is ready for birth. It may position itself head-down in the mother's pelvis.",
            "The fetus's lungs are fully mature, and it begins to produce more surfactant to facilitate breathing after birth.",
            "The fetus's head may engage deeper into the pelvis, putting pressure on the mother's bladder and causing frequent urination.",
            "The fetus is considered overdue if it has not been born by this point. It may continue to grow and gain weight until labor begins."
          
            
            
            // Add more weeks...
        ]
        
        // Return corresponding text for the given week
        return babyData[min(max(week - 1, 0), babyData.count - 1)]
    }
    
    // Helper function to retrieve mother data for the given week
    private func motherData(forWeek week: Int) -> String {
        // Define text for each week
        let motherData: [String] = [
            // Week 1 to 40
            "Menstruation ends, and the uterus prepares for ovulation by building up its lining.",
            "Ovulation occurs, and the egg is fertilized by sperm in the fallopian tube.",
            "The fertilized egg implants itself into the uterine lining, and hormonal changes begin to support pregnancy.",
            "The uterus continues to grow and stretch to accommodate the growing embryo. Some women may experience early pregnancy symptoms like fatigue and nausea.",
            "Hormonal changes continue, and the uterus expands to make room for the developing fetus. Many women begin to experience more noticeable pregnancy symptoms like morning sickness and breast tenderness.",
            "The uterus rises out of the pelvic cavity, and the abdomen begins to visibly swell. Some women may start to feel fetal movements.",
            "The uterus continues to grow, and the mother's center of gravity shifts forward. The skin may stretch and become itchy as the abdomen expands.",
            "The uterus is now about the size of a cantaloupe, and the mother may start to experience backaches and pelvic discomfort as her body adjusts to the added weight.",
            "The uterus continues to expand, and the mother may notice changes in her skin, such as darkening of the nipples and the appearance of stretch marks.",
            "The uterus is now the size of a grapefruit, and the mother's abdomen may be noticeably rounded. She may experience shortness of breath and heartburn as the uterus presses against her diaphragm and stomach.",
            "The uterus rises above the pelvic bones, and the mother's abdomen becomes more prominent. Some women may develop varicose veins and hemorrhoids due to increased pressure on blood vessels.",
            "The uterus reaches the rib cage, and the mother may feel short of breath and have difficulty sleeping due to the size of her abdomen.",
            "The uterus continues to grow, and the mother may experience increased vaginal discharge and urinary frequency.",
            "The uterus may push against the mother's rib cage, causing discomfort and difficulty breathing. Braxton Hicks contractions may occur as the uterus prepares for labor.",
            "The uterus is now at its largest size, and the mother may experience discomfort and pressure in her pelvic area. Some women may leak colostrum, a precursor to breast milk, from their nipples.",
            "The mother may feel a decrease in fetal movement as the baby prepares for birth. She may also experience increased fatigue and difficulty sleeping.",
            "The mother's body begins to prepare for labor as the cervix softens and thins out. Some women may lose their mucus plug, a thick plug of mucus that seals the cervix.",
            "The mother may experience pre-labor symptoms like backache, cramps, and diarrhea as her body prepares for labor. Braxton Hicks contractions may become more frequent and intense.",
            "The mother may experience signs of impending labor, such as the rupture of the amniotic sac (water breaking) and the onset of regular contractions.",
            "The mother enters active labor, and contractions become stronger, longer, and more frequent. She may feel intense pressure in her lower back and pelvis.",
            "The mother continues to progress through labor, and the cervix dilates fully (10 centimeters). She may feel the urge to push as the baby moves down the birth canal.",
            "The mother reaches the second stage of labor, known as the pushing stage. She actively pushes with each contraction to help the baby move through the birth canal.",
            "The mother enters the third stage of labor, which involves the delivery of the placenta. She may experience mild contractions as the uterus contracts to expel the placenta.",
            "The mother enters the fourth stage of labor, also known as the recovery stage. She may feel shaky and exhausted but relieved that the delivery is over.",
            "The mother's body begins to recover from the physical demands of labor. She may experience postpartum bleeding (lochia) and uterine contractions as the uterus returns to its pre-pregnancy size.",
            "The mother's body continues to recover, and she may experience breast engorgement as her milk comes in. She may also experience mood swings and emotional changes known as the baby blues.",
            "The mother's body adjusts to the demands of breastfeeding, and she may experience nipple soreness and discomfort as she learns to breastfeed her baby.",
            "The mother's hormones stabilize, and she begins to settle into her new role as a parent. She may experience changes in appetite, energy levels, and sleep patterns.",
            "The mother's body continues to heal, and she may gradually return to her pre-pregnancy weight and shape. She may also experience changes in her menstrual cycle and libido.",
            "The mother's body fully recovers from the physical demands of pregnancy and childbirth. She may feel more confident and comfortable in her role as a mother.",
            "The mother's body may undergo long-term changes as a result of pregnancy and childbirth, such as changes in pelvic floor function and abdominal muscle strength.",
            "The mother may experience changes in her menstrual cycle and fertility as her body returns to its normal reproductive function.",
            "The mother may experience changes in her body image and self-esteem as she adjusts to the physical and emotional demands of motherhood.",
            "The mother may experience changes in her relationship with her partner and other family members as she navigates the challenges and joys of parenting.",
            "The mother may experience changes in her social life and priorities as she focuses on caring for her newborn and adjusting to her new role as a parent.",
            "The mother may experience changes in her sleep patterns and energy levels as she adapts to the demands of caring for a newborn.",
            "The mother may experience changes in her emotional well-being and mental health as she navigates the ups and downs of early parenthood.",
            "The mother may experience changes in her work-life balance and career aspirations as she juggles the responsibilities of work and parenting.",
            "The mother may experience changes in her social support network and seek out resources and support groups to help her navigate the challenges of motherhood.",
            "The mother may experience changes in her physical health and well-being as she prioritizes self-care and makes time for exercise, relaxation, and personal hobbies.",
            "The mother may experience changes in her family dynamics and relationships as she integrates her new baby into her family unit."
        ]
        
        // Return corresponding text for the given week
        return motherData[min(max(week - 1, 0), motherData.count - 1)]
    }
    private func adviceData(forWeek week: Int) -> String {
        // Define text for each week
        let adviceData: [String] = [
            // Week 1 to 40
            "Take a prenatal vitamin containing folic acid to support your baby's neural tube development.",
            "Stay hydrated by drinking plenty of water throughout the day.",
            "Get plenty of rest and prioritize sleep to support your overall health and well-being.",
            "Eat a balanced diet rich in fruits, vegetables, lean proteins, and whole grains to support your baby's growth and development.",
            "Avoid alcohol, tobacco, and recreational drugs to protect your baby's health and development.",
            "Exercise regularly with activities like walking, swimming, or prenatal yoga to stay active and reduce stress.",
            "Attend your first prenatal appointment to establish prenatal care and monitor your baby's growth and development.",
            "Discuss any concerns or questions with your healthcare provider, and be open and honest about your health history and lifestyle.",
            "Start tracking your baby's movements and kick counts to monitor your baby's health and well-being.",
            "Consider signing up for childbirth education classes to prepare for labor, delivery, and newborn care.",
            "Stay informed about the changes happening in your body and your baby's development by reading reputable pregnancy resources and books.",
            "Practice relaxation techniques like deep breathing, meditation, or visualization to manage stress and anxiety.",
            "Communicate openly with your partner about your feelings, fears, and expectations for pregnancy and parenthood.",
            "Start thinking about your birth plan and preferences for labor and delivery, including pain management options and birth preferences.",
            "Explore different childbirth education options and prenatal classes to prepare for labor, delivery, and newborn care.",
            "Continue to prioritize self-care and relaxation techniques to manage stress and promote overall well-being.",
            "Attend regular prenatal check-ups and screenings to monitor your baby's growth and development.",
            "Stay active with low-impact exercises like walking, swimming, or prenatal yoga to maintain your fitness and energy levels.",
            "Start thinking about your postpartum recovery plan and resources for support after childbirth.",
            "Discuss your birth plan and preferences with your healthcare provider and make any necessary adjustments.",
            "Stay hydrated and eat a balanced diet to support your energy levels and overall health.",
            "Stay connected with your support network of family, friends, and healthcare providers for emotional and practical support.",
            "Prepare your home for the arrival of your baby by setting up the nursery, gathering essential supplies, and completing any necessary tasks.",
            "Practice relaxation techniques like deep breathing, meditation, or visualization to manage stress and anxiety.",
            "Continue to attend regular prenatal check-ups and screenings to monitor your baby's growth and development.",
            "Stay active with gentle exercises like walking, swimming, or prenatal yoga to maintain your fitness and flexibility.",
            "Prepare for childbirth by practicing breathing techniques, relaxation exercises, and labor positions with your partner or support person.",
            "Stay informed about your birthing options and preferences for labor and delivery, including pain management techniques and birth positions.",
            "Review your postpartum recovery plan and resources for support after childbirth, including breastfeeding support and newborn care classes.",
            "Stay connected with your healthcare provider and support network for emotional and practical support throughout pregnancy and childbirth.",
            "Practice self-care and prioritize rest and relaxation to manage stress and promote overall well-being.",
            "Prepare for labor and delivery by packing your hospital bag, finalizing your birth plan, and discussing your preferences with your healthcare provider.",
            "Stay hydrated and eat a balanced diet to support your energy levels and overall health.",
            "Stay active with gentle exercises like walking, swimming, or prenatal yoga to maintain your fitness and flexibility.",
            "Stay connected with your support network of family, friends, and healthcare providers for emotional and practical support.",
            "Review your childbirth education materials and practice relaxation techniques, breathing exercises, and labor positions with your partner or support person.",
            "Prepare for the early postpartum period by stocking up on essential supplies, arranging for postpartum support, and creating a plan for breastfeeding and newborn care.",
            "Stay informed about your labor and delivery options and preferences for pain management, birth positions, and interventions.",
            "Continue to attend regular prenatal check-ups and screenings to monitor your baby's growth and development.",
            "Stay active with gentle exercises like walking, swimming, or prenatal yoga to maintain your fitness and flexibility.",
            "Prepare for childbirth by practicing relaxation techniques, breathing exercises, and labor positions with your partner or support person.",
            "Stay connected with your support network of family, friends, and healthcare providers for emotional and practical support throughout pregnancy and childbirth.",
            "Review your postpartum recovery plan and resources for support after childbirth, including breastfeeding support and newborn care classes.",
            "Practice self-care and prioritize rest and relaxation to manage stress and promote overall well-being.",
            "Stay informed about your birthing options and preferences for labor and delivery, including pain management techniques and birth positions.",
            "Review your postpartum recovery plan and resources for support after childbirth, including breastfeeding support and newborn care classes.",
            "Stay connected with your healthcare provider and support network for emotional and practical support throughout pregnancy and childbirth.",
            "Prepare for labor and delivery by practicing relaxation techniques, breathing exercises, and labor positions with your partner or support person.",
            "Stay hydrated and eat a balanced diet to support your energy levels and overall health.",
            "Stay active with gentle exercises like walking, swimming, or prenatal yoga to maintain your fitness and flexibility.",
            "Prepare for childbirth by packing your hospital bag, finalizing your birth plan, and discussing your preferences with your healthcare provider.",
            "Stay connected with your support network of family, friends, and healthcare providers for emotional and practical support.",
            "Review your childbirth education materials and practice relaxation techniques, breathing exercises, and labor positions with your partner or support person.",
            "Prepare for the early postpartum period by stocking up on essential supplies, arranging for postpartum support, and creating a plan for breastfeeding and newborn care.",
            "Stay informed about your labor and delivery options and preferences for pain management, birth positions, and interventions.",
            "Continue to attend regular prenatal check-ups and screenings to monitor your baby's growth and development.",
            "Stay active with gentle exercises like walking, swimming, or prenatal yoga to maintain your fitness and flexibility.",
            "Prepare for childbirth by practicing relaxation techniques, breathing exercises, and labor positions with your partner or support person.",
            "Stay connected with your support network of family, friends, and healthcare providers for emotional and practical"
            
        ]
        
        // Return corresponding text for the given week
        return adviceData[min(max(week - 1, 0), adviceData.count - 1)]
    }

    

}

struct MilestoneTrackerView: View {
    @State private var selectedWeight: Int = 40
    @State private var affirmationInput: String = ""
    @State private var milestoneEntries: [(date: Date, weight: Int, affirmation: String)] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Milestone Tracker")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .padding(.leading, 110)

            Picker("Weight", selection: $selectedWeight) {
                ForEach(40..<151, id: \.self) { weight in
                    Text("\(weight)")
                }
            }
            .labelsHidden() // Hide the default labels
            .padding(.bottom, 8)
            .padding(.leading, 50)

            TextField("Enter affirmations", text: $affirmationInput)
                .padding(.bottom, 8)
                .padding(.leading, 50)

            HStack {
                Button(action: addMilestone) {
                    Text("Add Milestone")
                        .foregroundColor(.white)
                        .padding(.leading,0)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.teal.opacity(0.8))
                        .cornerRadius(20)
                }
                .padding(.leading,80)

                NavigationLink(destination: GraphView(data: milestoneEntries.map { entry in
                    GraphData(date: entry.date, weight: Double(entry.weight), affirmation: entry.affirmation)
                })) {
                    Text("Graph")
                        .foregroundColor(.white)
                        .frame(alignment: .trailing)
                        .padding(.leading, 0)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.teal.opacity(0.8))
                        .cornerRadius(20)
                }

            }
        }
        .padding()
    }

    private func addMilestone() {
        let date = Date()
        let existingEntryForDate = milestoneEntries.first { entry in
            Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
        
        // Check if there are already two entries for the current day
        if let _ = existingEntryForDate, milestoneEntries.count > 1 {
            // Show an alert or handle the case where the user tries to add more than two milestones per day
            // For simplicity, we'll print a message here
            print("You have already added two milestones for today.")
            return
        }
        
        milestoneEntries.append((date: date, weight: selectedWeight, affirmation: affirmationInput))
        affirmationInput = ""
    }
}

struct MilestoneTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneTrackerView()
    }
}

struct GraphPlotView: View {
    let entry: GraphData

    private let maxWeight: Double = 150 // Maximum weight for scaling
    private let circleSize: CGFloat = 10 // Base size of the Circle

    // Calculate the scaling factor based on weight
    private var scaleFactor: CGFloat {
        let weightRatio = CGFloat(entry.weight / maxWeight)
        return circleSize + (circleSize * weightRatio)
    }

    var body: some View {
        VStack {
            Text("\(entry.date, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(.gray)
            Circle()
                .foregroundColor(.teal)
                .frame(width: scaleFactor, height: scaleFactor) // Scale the size of the Circle
        }
        .padding(.vertical, 10)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}




struct GraphView: View {
    let data: [GraphData]

    var body: some View {
        VStack {
            Text("Milestone Tracker")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            Spacer()

            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(data) { entry in
                        GraphPlotView(entry: entry)
                            .onTapGesture {
                                // Display affirmation when plot is tapped
                                let affirmation = entry.affirmation.isEmpty ? "No affirmation entered" : entry.affirmation
                                showAlert(title: "Affirmation", message: affirmation)
                            }
                    }
                }
                .padding()
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

// Other code remains the same


struct GraphData: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
    let affirmation: String
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        // Example data for preview
        GraphView(data: [])
    }
}





struct WeekButton: View {
    let week: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            if !isSelected {
                action()
            }
        }) {
            Text("Week \(week)")
                .font(.headline)
                .frame(width: 80, height: 40) // Adjust width to accommodate the text "Week X"
                .foregroundColor(isSelected ? .white : .black)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
                .clipShape(Capsule()) // Use Capsule shape instead of Circle for weeks
        }
        .disabled(!isSelected) // Disable interaction if the week is already selected
    }
}



struct InfoSection: View {
    var title: String
    var data: String
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(color.opacity(0.8)) // Use provided color with opacity
            .overlay(
                VStack(alignment: .leading) {
                    Text(title)
                                            .font(.custom("SF Pro", size: 23)) // Changed font to SF Pro
                                            .fontWeight(.bold) // Made title bold
                                            .foregroundColor(.black)
                                            .padding(.top, 5) // Adjusted top padding
                                            .frame(maxWidth: .infinity, alignment: .leading) // Align title to the left
                                            .padding(.leading) // Add leading padding for alignment
                                            .padding(.bottom,10)
                                        
                                        Text(data)
                                            .font(.custom("SF Pro", size: 18)) // Changed font to SF Pro
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading) // Align data to the left
                                            .padding(.leading) // Add leading padding for alignment
                                            .padding(.bottom,40)
                }
            )
            .frame(width: 380, height: 180, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, -40) // Adjust vertical padding to overlap edges
    }
}


struct LargeSquareButton<Destination: View>: View {
    var systemImageName: String
    var title: String
    var color: Color
    var destinationScreen: Destination

    var body: some View {
        NavigationLink(destination: destinationScreen) {
            VStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(color)

                Text(title)
                    .foregroundColor(color)
                    .fontWeight(.bold)
                    .padding(.top, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
        .buttonStyle(PlainButtonStyle())
    }
}





struct LargeSquareButtonsScrollView: View {
    var body: some View {
        HStack(spacing: 20) { // Reduce the spacing between squares
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.teal.opacity(0.3))
                .overlay(
                    LargeSquareButton(systemImageName: "fork.knife.circle", title: "Mom's recipes", color: .cyan, destinationScreen: ContentView1())
                )
                .navigationBarBackButtonHidden(true)
                .frame(width: 150, height: 150) // Adjust the size of the square
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.teal.opacity(0.3))
                .overlay(
                    LargeSquareButton(systemImageName: "figure.run", title: "Exercise", color: .cyan, destinationScreen: ExercisePage())
                )
                .navigationBarBackButtonHidden(true)
                .frame(width: 150, height: 150) // Adjust the size of the square
            
//            RoundedRectangle(cornerRadius: 0)
//                .foregroundColor(.cyan.opacity(0.8))
//                .overlay(
//                    LargeSquareButton(systemImageName: "cross.case", title: "Appointments", color: .cyan, destinationScreen: AppointmentBookingView())
//                )
//                .frame(width: 80, height: 80) // Adjust the size of the square
        }
        .padding(.bottom, 40)
    }
}


extension Date {
    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
}


extension Calendar {
    func generateDates(startDate: Date, endDate: Date) -> [Date] {
        var dates = [Date]()
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = self.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

