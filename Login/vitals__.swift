//import SwiftUI
//import HealthKit
//import Charts
//
//
//struct VitalsPage: View {
//    // HealthKit variables
//    @State private var walkingDistance: Double?
//    @State private var stepsCount: Int?
//    @State private var heartRate: Int?
//    @State private var hoursOfSleep: Double?
//
//    // HealthKit store
//    private let healthStore = HKHealthStore()
//
//    var body: some View {
//        ScrollView {
//            VStack {
////                HStack {
////                    Text("Vitals")
////                        .font(.largeTitle)
////                        .fontWeight(.bold)
////                        .padding(.top, 20)
////                        .foregroundColor(.black)
////                        .frame(maxWidth: .infinity, alignment: .center) // Center align the text
////
////                    Spacer()
////                }
//
//                HStack(spacing: 20) {
//                    VitalsRectangleCard(title: "Walking Distance", value: formatValue(walkingDistance, unit: "km"), symbol: "figure.walk", color: Color.teal.opacity(0.9))
//                    VitalsRectangleCard(title: "Heart Rate", value: formatValue(heartRate, unit: "bpm"), symbol: "heart.fill", color: Color.teal.opacity(0.9))
//                }
//                .padding()
//
//                HStack(spacing: 20) {
//                    VitalsRectangleCard(title: "Steps", value: formatValue(stepsCount), symbol: "shoeprints.fill", color: Color.teal.opacity(0.9))
//                    VitalsRectangleCard(title: "Sleep", value: formatValue(hoursOfSleep, unit: "hrs"), symbol: "moon.zzz.fill", color: Color.teal.opacity(0.9))
//                }
//                .padding()
//            }
//        }
//        .foregroundColor(.black)
//        .background(Color.white.opacity(0.1)) // You can use a custom color if needed
//        .onAppear {
//            requestHealthKitAuthorization()
//            fetchData()
//        }
//    }
//
//    private func requestHealthKitAuthorization() {
//        // Request authorization to read health data
//        let typesToRead: Set<HKObjectType> = [
//            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//            HKObjectType.quantityType(forIdentifier: .heartRate)!,
//            HKObjectType.quantityType(forIdentifier: .stepCount)!,
//            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
//        ]
//
//        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
//            if !success {
//                // Handle the error
//                print("HealthKit authorization request failed.")
//            }
//        }
//    }
//
//    private func fetchData() {
//        // Fetch health data
//        fetchWalkingDistance()
//        fetchHeartRate()
//        fetchStepsCount()
//        fetchHoursOfSleep()
//    }
//
//    private func fetchWalkingDistance() {
//        let walkingType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
//        let query = HKStatisticsQuery(quantityType: walkingType, quantitySamplePredicate: nil, options: .cumulativeSum) { (_, result, error) in
//            guard let result = result, let sum = result.sumQuantity() else {
//                print("Error fetching walking distance: \(error?.localizedDescription ?? "")")
//                return
//            }
//            DispatchQueue.main.async {
//                walkingDistance = sum.doubleValue(for: HKUnit.meterUnit(with: .kilo))
//            }
//        }
//        healthStore.execute(query)
//    }
//
//    private func fetchHeartRate() {
//        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
//        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: nil, options: .discreteAverage) { (_, result, error) in
//            guard let result = result, let average = result.averageQuantity() else {
//                print("Error fetching heart rate: \(error?.localizedDescription ?? "")")
//                return
//            }
//            DispatchQueue.main.async {
//                heartRate = Int(average.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
//            }
//        }
//        healthStore.execute(query)
//    }
//
//    private func fetchStepsCount() {
//        let stepsType = HKObjectType.quantityType(forIdentifier: .stepCount)!
//        let query = HKStatisticsQuery(quantityType: stepsType, quantitySamplePredicate: nil, options: .cumulativeSum) { (_, result, error) in
//            guard let result = result, let sum = result.sumQuantity() else {
//                print("Error fetching steps count: \(error?.localizedDescription ?? "")")
//                return
//            }
//            DispatchQueue.main.async {
//                stepsCount = Int(sum.doubleValue(for: HKUnit.count()))
//            }
//        }
//        healthStore.execute(query)
//    }
//
//    private func fetchHoursOfSleep() {
//        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
//        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (_, samples, error) in
//            guard let samples = samples as? [HKCategorySample] else {
//                print("Error fetching sleep data: \(error?.localizedDescription ?? "")")
//                return
//            }
//            let totalSleepHours = samples.reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }
//            DispatchQueue.main.async {
//                hoursOfSleep = totalSleepHours / 3600 // Convert seconds to hours
//            }
//        }
//        healthStore.execute(query)
//    }
//
//    private func formatValue<T>(_ value: T?, unit: String? = nil) -> String {
//        return value.map { "\(($0)) \(unit ?? "")" } ?? "N/A"
//    }
//}
//
//struct VitalsPage_Previews: PreviewProvider {
//    static var previews: some View {
//        VitalsPage()
//    }
//}
//
//struct VitalsRectangleCard: View {
//    var title: String
//    var value: String
//    var symbol: String
//    var color: Color
//
//    var body: some View {
//        VStack {
//            Rectangle()
//                .fill(color)
//                .frame(width: UIScreen.main.bounds.width / 2.2, height: 250)
//                .overlay(
//                    VStack {
//                        Image(systemName: symbol)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 10)
//
//                        Text(value)
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 20)
//
//                        Text(title)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                    }
//                    .padding()
//                )
//        }
//        .cornerRadius(20)
//        .shadow(radius: 5)
//    }
//}
//
