

import SwiftUI
import Foundation


struct ContentView: View {
    @ObservedObject var viewModel: PillReminderViewModel
       
       var body: some View {
           ZStack {
               VStack {
                   Spacer(minLength: 95)
                   /// Show 'add a pill' screen
                   if viewModel.navigationStyle == .addPillReminder {
                       AddPillView(viewModel: viewModel.pillViewModel, baseViewModel: viewModel)
                       
                   /// Show main 'Today' screen
                   } else {
                       /// Show no reminders view when necessary
                       if viewModel.hasReminders == false {
                           NoRemindersView()
                           
                       /// Show a list of pill reminders
                       } else {
                           RemindersListView(viewModel: viewModel)
                       }
                   }
               }
               
               /// Navigation view
               VStack {
                   CustomNavigationView(viewModel: viewModel)
                   Spacer()
               }
           }
           .onAppear(perform: {
               self.viewModel.getUpdatedRemindersList()
           })
           .background(viewModel.hasReminders ? Color(.white).brightness(0.70) : Color(.white).brightness(0.60))
           .edgesIgnoringSafeArea(.bottom)
       }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PillReminderViewModel())
            .preferredColorScheme(.dark)
    }
}

/// View model to add a pill
class AddPillViewModel: ObservableObject {
    @Published private var addPillModel = ReminderModel.buildDefaultModel()
    
    
    
    /// Set when the pill was added to the list
    var addedPill: Bool = false
    
    var pillDosage: Int {
        addPillModel.pillDosage
    }
    
    var pillType: PillType {
        addPillModel.pillType
    }
    
    var alertTitle: String {
        addedPill ? NSLocalizedString("Great Job", comment: "") : NSLocalizedString("Something's missing", comment: "")
    }
    
    var alertMessage: String {
        addedPill ? NSLocalizedString("Your pill reminder has been added", comment: "") : NSLocalizedString("Make sure you entered the pill name and selected a time", comment: "")
    }
    
    var dateRange: ClosedRange<Date> {
        var startDateComponents = DateComponents()
        var endDateComponents = DateComponents()
        
        switch addPillModel.selectedDailyInterval {
        case .morning:
            startDateComponents.hour = 0
            endDateComponents.hour = 11
            endDateComponents.minute = 59
        case .noon:
            startDateComponents.hour = 12
            endDateComponents.hour = 16
            endDateComponents.minute = 59
        case .evening:
            startDateComponents.hour = 17
            endDateComponents.hour = 23
            endDateComponents.minute = 59
        }
        
        return Calendar.current.date(from: startDateComponents)!...Calendar.current.date(from: endDateComponents)!
    }
    
    func formattedTime(interval: DailyTimeInterval) -> String {
        addPillModel.formattedTime(interval: interval)
    }
    
    // MARK: - User's actions
    func didEnterPillName(_ name: String) {
        addPillModel.pillName = name
    }
    
    func didSelectDailyInterval(_ interval: DailyTimeInterval) {
        addPillModel.selectedDailyInterval = interval
        #if !os(watchOS)
        didSelectDailyDate(date: nil)
        #endif
    }
    #if !os(watchOS)
    func didSelectDailyDate(date: Date?) {
        if addPillModel.selectedDailyInterval == .morning {
            addPillModel.morningDate = date?.keepTimeOnly
        } else if addPillModel.selectedDailyInterval == .noon {
            addPillModel.noonDate = date?.keepTimeOnly
        } else {
            addPillModel.eveningDate = date?.keepTimeOnly
        }
    }
    #endif
    
    func updatePillDosage(_ dosage: Int) {
        addPillModel.pillDosage = dosage
    }
    
    func updatePillType(_ type: PillType) {
        addPillModel.pillType = type
    }
    
    func addPillReminder() {
        if addPillModel.isValid {
            addPillModel.savePillReminder()
            addedPill = true
            #if !os(watchOS)
            requestPushNotificationsPermissions()
            #endif
        } else { addedPill = false }
    }
    #if !os(watchOS)
    private func requestPushNotificationsPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if !granted || error != nil {
                /// User declined push notification permissions
            }
        }
    }
    #endif
}


/// Pill type
enum PillType: String, CaseIterable {
    case blue = "regular_blue"
    case white = "regular_white"
    case orange = "regular_orange"
    case polygon = "polygon_blue"
    case red = "regular_red"
    case Needle = "Needle"
}

/// Daily time interval
enum DailyTimeInterval: String, CaseIterable {
    case morning = "Morning"
    case noon = "Noon"
    case evening = "Evening"
}

/// Main model to hold details about a pill reminder
class ReminderModel: ObservableObject, Identifiable {
    var id: String = ""
    var pillName: String
    @Published var pillDosage: Int
    @Published var pillType: PillType = .blue
    var selectedDailyInterval: DailyTimeInterval = .morning
    @Published var didTakePill: Bool = false
    
    /// Daily time intervals
    var morningDate: Date?
    var noonDate: Date?
    var eveningDate: Date?
    
    /// Reset taken indicator if needed
    private var recordDay: Int = 0 {
        didSet {
            if let currentDay = Calendar.current.dateComponents([.day], from: Date()).day, recordDay != currentDay {
                self.didTakePill = false
            }
        }
    }
    
    /// Initializer
    init(id: String, pillName: String, pillDosage: Int, pillType: PillType, selectedDailyInterval: DailyTimeInterval,
         didTakePill: Bool, morningDate: Date?, noonDate: Date?, eveningDate: Date?) {
        self.id = id
        self.pillName = pillName
        self.pillDosage = pillDosage
        self.pillType = pillType
        self.selectedDailyInterval = selectedDailyInterval
        self.didTakePill = didTakePill
        self.morningDate = morningDate
        self.noonDate = noonDate
        self.eveningDate = eveningDate
    }
    
    /// Determine if the model is valid
    var isValid: Bool {
        !pillName.isEmpty && (morningDate != nil || noonDate != nil || eveningDate != nil)
    }
    
    /// Formatted time
    func formattedTime(interval: DailyTimeInterval) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        var date = morningDate
        if interval == .noon {
            date = noonDate
        } else if interval == .evening {
            date = eveningDate
        }
        guard let selectedDate = date else {
            return "NONE"
        }
        return formatter.string(from: selectedDate)
    }
    
    /// Formatted dosage
    var formattedDosage: String {
        NSLocalizedString("Take \(pillDosage) Dose\(pillDosage > 1 ? "s" : "")", comment: "")
    }
    
    /// Return dictionary from the model
    var dictionary: [String: Any] {
        var data = [String: Any]()
        data["id"] = id
        data["name"] = pillName
        data["dosage"] = pillDosage
        data["type"] = pillType.rawValue
        data["morning"] = morningDate
        data["noon"] = noonDate
        data["evening"] = eveningDate
        data["taken"] = false
        if let day = Calendar.current.dateComponents([.day], from: Date()).day {
            data["recordDay"] = day
        }
        return data
    }
    
    /// Notification schedule date details
    var notificationDate: DateComponents? {
        var components: DateComponents?
        if let morning = morningDate {
            components = Calendar.current.dateComponents([.hour, .minute], from: morning)
        } else if let noon = noonDate {
            components = Calendar.current.dateComponents([.hour, .minute], from: noon)
        } else if let evening = eveningDate {
            components = Calendar.current.dateComponents([.hour, .minute], from: evening)
        }
        return components
    }
    
    /// Custom initializer
    static func build(dictionary: [String: Any]) -> ReminderModel? {
        if let id = dictionary["id"] as? String, let name = dictionary["name"] as? String,
            let dosage = dictionary["dosage"] as? Int, let type = dictionary["type"] as? String, let taken = dictionary["taken"] as? Bool {
            let model = ReminderModel(id: id, pillName: name, pillDosage: dosage, pillType: PillType(rawValue: type) ?? .blue, selectedDailyInterval: .morning, didTakePill: taken, morningDate: dictionary["morning"] as? Date, noonDate: dictionary["noon"] as? Date, eveningDate: dictionary["evening"] as? Date)
            model.recordDay = dictionary["recordDay"] as? Int ?? 0
            return model
        }
        return nil
    }
    
    static func buildDefaultModel() -> ReminderModel {
        return ReminderModel(id: "", pillName: "", pillDosage: 1, pillType: .blue, selectedDailyInterval: .morning, didTakePill: false, morningDate: nil, noonDate: nil, eveningDate: nil)
    }
    
    /// Mark pill as taken
    func markPillTaken() {
        didTakePill = !didTakePill
        var data = [String: Any]()
        if let dictionary = UserDefaults.standard.dictionary(forKey: "reminders") {
            data = dictionary
            if var details = data[id] as? [String: Any] {
                details["taken"] = didTakePill
                if let day = Calendar.current.dateComponents([.day], from: Date()).day {
                    details["recordDay"] = day
                }
                data[id] = details
            }
            UserDefaults.standard.set(data, forKey: "reminders")
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Save pill reminder
    func savePillReminder() {
        var data = [String: Any]()
        if let savedData = UserDefaults.standard.dictionary(forKey: "reminders") { data = savedData }
        
        if morningDate != nil {
            var updatedDictionary = dictionary
            updatedDictionary.removeValue(forKey: "noon")
            updatedDictionary.removeValue(forKey: "evening")
            data[UUID().uuidString] = updatedDictionary
        }
        
        if noonDate != nil {
            var updatedDictionary = dictionary
            updatedDictionary.removeValue(forKey: "morning")
            updatedDictionary.removeValue(forKey: "evening")
            data[UUID().uuidString] = updatedDictionary
        }
        
        if eveningDate != nil {
            var updatedDictionary = dictionary
            updatedDictionary.removeValue(forKey: "morning")
            updatedDictionary.removeValue(forKey: "noon")
            data[UUID().uuidString] = updatedDictionary
        }
        
        UserDefaults.standard.set(data, forKey: "reminders")
        UserDefaults.standard.synchronize()
    }
}

struct ReminderModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

/// Main view model to bind the view to the model and holds the business logic of the app
class PillReminderViewModel: ObservableObject {
   
    
    @Published private var navigationModel = NavigationModel(title: NSLocalizedString("Today", comment: ""), subtitle: "No medication saved", style: .reminders)
    @Published private var addPillViewModel = AddPillViewModel()
    
    /// Change the content for navigation view when user taps "+" or "x" button on the top right corner
    private func changeNavigationModelContent() {
        let style = navigationModel.style
        navigationModel.title = style == .addPillReminder ? NSLocalizedString("Add Medication", comment: "") : NSLocalizedString("Today", comment: "")
        navigationModel.subtitle = style == .addPillReminder ? NSLocalizedString("Just a few taps below", comment: "") : progressSubtitle
    }
    
    /// Navigation content
    var navigationTitle: String {
        navigationModel.title
        
    }
   
    
    var navigationSubtitle: String {
        navigationModel.subtitle
    }
    
    var navigationStyle: NavigationViewStyle {
        navigationModel.style
    }
   
    /// Reminders details
    var reminders = [ReminderModel]()

    var hasReminders: Bool {
        reminders.count > 0
    }
    
    var progressSubtitle: String {
        hasReminders ? NSLocalizedString("It's time for your meds", comment: "") : NSLocalizedString("No medication saved", comment: "")
    }
    
    func reminders(forInterval interval: DailyTimeInterval) -> [ReminderModel] {
        let models = reminders
            .filter({ interval == .morning ? $0.morningDate != nil : interval == .noon ? $0.noonDate != nil : $0.eveningDate != nil })
        switch interval {
        case .morning:
            if models.count > 0 {
                return models.count > 1 ? models.sorted(by: { $0.morningDate! < $1.morningDate! }) : models
            }
        case .noon:
            if models.count > 0 {
                return models.count > 1 ? models.sorted(by: { $0.noonDate! < $1.noonDate! }) : models
            }
        case .evening:
            if models.count > 0 {
                return models.count > 1 ? models.sorted(by: { $0.eveningDate! < $1.eveningDate! }) : models
            }
        }
        return models
    }
    
    /// Add pill view model
    var pillViewModel: AddPillViewModel {
        addPillViewModel
    }
    
   
    // MARK: - User's actions
    func getUpdatedRemindersList() {
        if navigationStyle == .reminders {
            if let storedData = UserDefaults.standard.dictionary(forKey: "reminders") {
                storedData.forEach { (pillId, pillDetails) in
                    if var details = pillDetails as? [String: Any] {
                        details["id"] = pillId
                        if let model = ReminderModel.build(dictionary: details), !self.reminders.contains(where: { $0.id == pillId }) {
                            self.reminders.append(model)
                        }
                    }
                }
            }
            setupRemindersNotifications()
            changeNavigationModelContent()
        }
    }
    
    func addPill() {
        navigationModel.style = .addPillReminder
        addPillViewModel = AddPillViewModel()
        changeNavigationModelContent()
    }
    
    func exitAddPillScreen() {
        navigationModel.style = .reminders
        getUpdatedRemindersList()
    }
   
    func pillReminderSelected(id: String) {
        guard let index = reminders.firstIndex(where: { $0.id == id }) else { return }
        reminders[index].markPillTaken()
        getUpdatedRemindersList()
    }
    
    func deleteReminder(id: String) {
        guard let index = reminders.firstIndex(where: { $0.id == id }) else { return }
        reminders.remove(at: index)
        deleteRemindersIfNeeded()
    }
    
    
    // MARK: - Reminders updates
    private func deleteRemindersIfNeeded() {
        if var storedData = UserDefaults.standard.dictionary(forKey: "reminders") {
            storedData.forEach { (pillId, pillDetails) in
                if !self.reminders.compactMap({ $0.id }).contains(pillId) {
                    storedData.removeValue(forKey: pillId)
                }
            }
            UserDefaults.standard.set(storedData, forKey: "reminders")
            UserDefaults.standard.synchronize()
            getUpdatedRemindersList()
            removeNotificationsIfNeeded()
        }
    }
    
    private func setupRemindersNotifications() {
        reminders.forEach { (reminder) in
            if let notificationComponents = reminder.notificationDate, !UserDefaults.standard.bool(forKey: reminder.id) {
                let content = UNMutableNotificationContent()
                content.title = NSLocalizedString("It's time to take your \(reminder.pillName)", comment: "")
                content.sound = .default
                let trigger = UNCalendarNotificationTrigger(dateMatching: notificationComponents, repeats: true)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    if let errorMessage = error?.localizedDescription {
                        print("NOTIFICATION ERROR: \(errorMessage)")
                    } else {
                        UserDefaults.standard.set(true, forKey: reminder.id)
                        UserDefaults.standard.synchronize()
                    }
                }
            }
        }
    }
    
    private func removeNotificationsIfNeeded() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (request) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            request.forEach { (request) in
                if !self.reminders.compactMap({ $0.id }).contains(request.identifier) {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
                    print("REMOVED NOTIFICATION")
                }
                if let components = request.trigger as? UNCalendarNotificationTrigger {
                    print("TITLE: \(request.content.title)\nDATE: \(components.dateComponents)\n")
                }
            }
        }
    }
}

/// Main model to configure the navigation view
struct NavigationModel {
    let localizedString = NSLocalizedString("LOCALIZED-STRING-KEY", comment: "Describe what is being localized here")
   
    var title: String
   
    var subtitle: String
    var style: NavigationViewStyle
}
extension String {
    func localized() -> String {
        let path = Bundle.main.path(forResource: "en.lproj", ofType: "es-419.lproj")!
        if let bundle = Bundle(path: path) {
            let str = bundle.localizedString(forKey: self, value: nil, table: nil)
            return str
        }
        return ""
    }
}


/// Picker type
enum AddPillPickerType {
    case none, interval, dateTime
}

/// Will allow users to add a pill to the reminders list
struct AddPillView: View {
    @State var pillName: String = ""
    @State var scheduleDate: Date = Date()
    @State var scheduleInterval: Int = 0
    @State var pickerType: AddPillPickerType = .none
    @State var addPillSelected: Bool = false

    /// Add Pill view model
    @ObservedObject var viewModel: AddPillViewModel
    @ObservedObject var baseViewModel: PillReminderViewModel
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color(.systemTeal).brightness(0.70).edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    /// Add the pill name
                    pillNameSection
                    
                    /// Add pill interval
                    pillIntervalSection
                    
                    /// Pill dosage stepper
                    Section(header: Text("How many do you take?").font(.system(size: 20)).bold().foregroundColor(.black)) {
                        InputStepper(viewModel: viewModel)
                    }
                    
                    /// Pill type icon
                    Section(header: Text("Choose a pill icon").font(.system(size: 20)).bold().foregroundColor(.black)) {
                        PillTypeSelector(viewModel: viewModel)
                        
                    }
                    
                    Spacer()
                    Spacer()
                }
                .applyCustomListStyle()
                .listStyle(GroupedListStyle())
            }
            
            /// Add Pill sticky button
            addPillStickyFooter
            
            /// Interval and time picker
            pickerFooterView
        }
        
    }
    
    /// Pill name section
    var pillNameSection: some View {
        Section(header: Text("What's the medication?").font(.system(size: 20)).bold().foregroundColor(.black)) {
            ZStack {
//                RoundedShadowView().frame(height: 50).padding(.top, -40)
                TextField("Enter medication name here", text: $pillName.onChange({ (name) in
                    self.viewModel.didEnterPillName(name)
                })).padding(.top, -30).padding(.leading, 15).padding(.trailing, 15).font(.title3)
            }
        }.padding(.top, 40)
    }
    
    /// Pill interval section
    var pillIntervalSection: some View {
        Section(header: Text("How often do you take it?").font(.system(size: 20)).bold().foregroundColor(.black)) {
            VStack {
                /// Time of day interval wit horizontal pickers
                HStack(spacing: 15) {
                    ForEach(0..<DailyTimeInterval.allCases.count, content: { index in
                        DropDownSelector(label: self.viewModel.formattedTime(interval: DailyTimeInterval.allCases[index]),
                                         title: DailyTimeInterval.allCases[index].rawValue, didSelect: {
                                            self.viewModel.didSelectDailyInterval(DailyTimeInterval.allCases[index])
                                            self.pickerType = self.pickerType != .dateTime ? .dateTime : .none
                                            self.generator.notificationOccurred(.success)
                        })
                    })
                }
            }
        }
        
    }
    
    
    /// Add this Pill sticky button
    var addPillStickyFooter: some View {
        ZStack {
            VStack {
                Spacer()
                Color.white.frame(height: 100)
            }
            .edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                ZStack {
                    Color(.gray).brightness(0.70).frame(height: 100)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(#colorLiteral(red: 0.1568627451, green: 0.3505882353, blue: 0.3925490196, alpha: 1)))
                        .frame(height: 50)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                        .alert(isPresented: $addPillSelected, content: { () -> Alert in
                            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK"), action: {
                                if self.viewModel.addedPill { self.baseViewModel.exitAddPillScreen() }
                            }))
                        })
                        .onTapGesture {
                            self.generator.notificationOccurred(.success)
                            self.viewModel.addPillReminder()
                            self.addPillSelected = true
                    }
                    Text("Add this Medication").foregroundColor(.white).bold().offset(x: 0, y: -10)
                }
               
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    /// Pickers footer view
    var pickerFooterView: some View {
        VStack {
            if pickerType != .none {
                Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.217702227))
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture { self.pickerType = .none }
                ZStack {
                    //bruh
                    Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).layoutPriority(0).frame(width: UIScreen.main.bounds.width).offset(x: 0, y: -10)
                    if pickerType == .dateTime {
                        dailyTimePicker.layoutPriority(1)
                    }
                }
                .offset(x: 0, y: pickerType == .none ? 450 : 0).animation(.spring())
            }
        }
    }
    
    /// Daily time picker
    var dailyTimePicker: some View {
        DatePicker(selection: $scheduleDate.onChange({ (date) in
            self.viewModel.didSelectDailyDate(date: date)
        }), in: viewModel.dateRange, displayedComponents: .hourAndMinute) {
            EmptyView()
        }
        
        .labelsHidden()
        .datePickerStyle(WheelDatePickerStyle())
    }
}

// MARK: - Canvas Preview
struct AddPillView_Previews: PreviewProvider {
    static var previews: some View {
        AddPillView(viewModel: AddPillViewModel(), baseViewModel: PillReminderViewModel())
            //.preferredColorScheme(.dark)
    }
}

/// Custom views struct to encapsulate most of the custom views used by the application
struct CustomView: View {
    var body: some View {
        VStack {
            RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
                .frame(height: 120)
                .foregroundColor(.secondary)
                .edgesIgnoringSafeArea(.top)
            ReminderView(reminderModel: ReminderModel.buildDefaultModel())
            RoundedShadowView()
                .frame(height: 50)
            DropDownSelector(label: "Is the time correct?")
            HStack {
                DropDownSelector(label: "8:00 AM", title: NSLocalizedString("Morning", comment: ""))
                DropDownSelector(label: "12:00 PM", title: NSLocalizedString("Noon", comment: ""))
                DropDownSelector(label: "8:00 AM", title: NSLocalizedString("Evening", comment: ""))
            }
            InputStepper(viewModel: AddPillViewModel())
            PillTypeSelector(viewModel: AddPillViewModel())
            Spacer()
        }
    }
}

/// Rounded corner shape by providing which corners to be rounded
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/// Plus/Close button
struct PlusCloseButton: View {
    @ObservedObject var viewModel: PillReminderViewModel
    private let buttonSize: CGFloat = 35
    private let buttonWeight: CGFloat = 7
    
    let generator = UINotificationFeedbackGenerator()
 
    
    var body: some View {
        let navigationStyle = viewModel.navigationStyle
        let rotationAngle = Angle(degrees: navigationStyle == .reminders ? 0 : 45)
        
        return ZStack {
            RoundedRectangle(cornerRadius: buttonWeight/2).frame(width: buttonSize, height: buttonWeight)
            RoundedRectangle(cornerRadius: buttonWeight/2).frame(width: buttonWeight, height: buttonSize)
        }
        .rotationEffect(rotationAngle).animation(.default)
        .onTapGesture {
            self.generator.notificationOccurred(.success)
            if navigationStyle == .reminders {
                self.viewModel.addPill()
            } else {
                self.viewModel.exitAddPillScreen()
            }
        }
        .foregroundColor(.white)
    }
}

/// Triangle shape used for drop down items in 'add a pill' screen
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

/// Drop down selection for 'add a pill' screen
struct DropDownSelector: View {
    
    var label: String
    var title: String?
    var didSelect: (() -> Void)?
    
    var body: some View {
        VStack {
            if title != nil {
                Text(title!)
                    .foregroundColor(.secondary)
                    .padding(.bottom, -8)
            }
            ZStack {
                RoundedShadowView()
                HStack {
                    Text(label)
                        .padding(.leading, 8)
                        .font(Font.custom("Helvetica", size: 16))
                        .minimumScaleFactor(0.3)
                       
                    Triangle()
                        .rotationEffect(Angle(degrees: 180))
                        .frame(width: 15, height: 12)
                }
            }
            .frame(height: 50)
            .onTapGesture {
                self.didSelect?()
                
            }
        }
    }
}

/// Input Stepper to in/decrease dosage
struct InputStepper: View {
    private let stepperButtonSize: CGFloat = 25
    @ObservedObject var viewModel: AddPillViewModel
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedShadowView()
            HStack(spacing: 45) {
                stepperButton(increase: false)
                Text("\(viewModel.pillDosage)")
                stepperButton(increase: true)
            }
        }
        .frame(height: 50)
    }
    
    func stepperButton(increase: Bool) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.3960784314, green: 0.6980392157, blue: 0, alpha: 1)))
                .frame(width: stepperButtonSize, height: stepperButtonSize)
            Text(increase ? "+" : "-")
                .font(Font.custom("Helvetica", size: 25)).bold()
                .foregroundColor(.white)
                .offset(x: 0.5, y: -1.5)
        }
        .opacity(!increase && self.viewModel.pillDosage == 1 ? 0.5 : 1.0)
        .onTapGesture {
            self.generator.notificationOccurred(.success)
            self.viewModel.objectWillChange.send()
            if !increase && self.viewModel.pillDosage == 1 { return }
            let dosage = increase ? self.viewModel.pillDosage + 1 : self.viewModel.pillDosage - 1
            self.viewModel.updatePillDosage(dosage)
        }
    }
}

/// Pill type selector
struct PillTypeSelector: View {
    @ObservedObject var viewModel: AddPillViewModel
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedShadowView()
            HStack {
                Spacer()
                ForEach(0..<PillType.allCases.count) { index in
                    Image(PillType.allCases[index].rawValue)
                        .opacity(self.viewModel.pillType == PillType.allCases[index] ? 1.0 : 0.4)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            self.generator.notificationOccurred(.success)
                            self.viewModel.objectWillChange.send()
                            self.viewModel.updatePillType(PillType.allCases[index])
                    }
                }
                Spacer()
            }
        }
        .frame(height: 50)
    }
}

/// Rounded Shadow View
struct RoundedShadowView: View {
    var customOpacity: Double = 0.5
    var body: some View {
        /// Background view with shadow
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .opacity(customOpacity)
    }
}

/// Reminder view
struct ReminderView: View {
    @ObservedObject var reminderModel: ReminderModel
    var reminderDailyInterval: DailyTimeInterval = .morning
    
    var body: some View {
        ZStack {
            RoundedShadowView(customOpacity: reminderModel.didTakePill ? 0.35 : 0.5)
            /// Pill name, Details and Time
            HStack {
                Image(reminderModel.pillType.rawValue)
                    .frame(width: 45)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(reminderModel.pillName)
                        .font(Font.custom("Helvetica", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(2)
                    Text(reminderModel.formattedDosage)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(reminderModel.formattedTime(interval: reminderDailyInterval))
                    .padding(.bottom, 40)
                    .foregroundColor(.black)
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .opacity(reminderModel.didTakePill ? 0.35 : 1.0)
        }
        .foregroundColor(.clear)
        .frame(height: 90)
    }
}

/// Helps hiding the line separator for a list as well as clear color for header view
struct CustomListViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .black
            UITableView.appearance().allowsSelection = false
            UITableViewCell.appearance().selectionStyle = .none
            UITableViewCell.appearance().backgroundColor = .systemTeal
            UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
        }
    }
}

// MARK: - Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func applyCustomListStyle() -> some View {
        modifier(CustomListViewModifier())
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

extension Date {
    var keepTimeOnly: Date {
        var components = DateComponents()
        components.hour = Calendar.current.component(.hour, from: self)
        components.minute = Calendar.current.component(.minute, from: self)
        return Calendar.current.date(from: components)!
    }
}

// MARK: - Canvas Preview
struct CustomViews_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
            .preferredColorScheme(.dark)
    }
}


//
/// Navigation View Style
enum NavigationViewStyle {
    case reminders, addPillReminder
}

/// Custom navigation view with bottom rounded corners
struct CustomNavigationView: View {
    // Bottom corner radius
    private let cornerRadius: CGFloat = 30
    
    // Navigation view colors
    private let blueColor: Color = Color(.systemTeal).opacity(0.9)
    private let orangeColor: Color = Color(.systemTeal).opacity(0.8)
    
    // Navigation view model
    @ObservedObject var viewModel: PillReminderViewModel

    var body: some View {
        let style = viewModel.navigationStyle
        let title = viewModel.navigationTitle
        let subtitle = viewModel.navigationSubtitle
        
        return ZStack(alignment: .leading) {
            /// Navigation shape with bottom rounded corners
            RoundedCorner(radius: cornerRadius,
                          corners: [.bottomLeft, .bottomRight])
                .foregroundColor(style == .reminders ? blueColor : orangeColor)
                .edgesIgnoringSafeArea(.top)
                .animation(.easeIn)
            HStack {
                VStack(alignment: .leading) {
                    /// Navigation title is mandatory
                    Text(title)
                        .font(Font.custom("Helvetica", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    /// Navigation subtitle is optional
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(Font.custom("Helvetica", size: 25))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                PlusCloseButton(viewModel: viewModel).padding(.trailing, 25)
            }
            .padding(.top, 20)
            .padding(.leading, 22)
            .padding(.bottom, 30)
        }
        .frame(height: 120)
    }
}


// MARK: - Canvas Preview
struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(viewModel: PillReminderViewModel())
    }
}

/// Will show no reminders for scenario when user first time launched the app without any reminders set
struct NoRemindersView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("pills")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .center)
            
            Text("No Reminders")
                .font(.title)
                .foregroundColor(.black)
                .bold()
                .padding(.top, 20)
                
            Text("You don't have any medication added to your list yet")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.leading, 35)
                .padding(.trailing, 35)
            Spacer()
            Spacer()
        }
    }
}


// MARK: - Canvas Preview
struct NoRemindersView_Previews: PreviewProvider {
    static var previews: some View {
        NoRemindersView()
            .preferredColorScheme(.light)
    }
}

/// Will show a list of reminders
struct RemindersListView: View {
    @ObservedObject var viewModel: PillReminderViewModel
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        List {
            Spacer(minLength: 1)
            ForEach(0..<DailyTimeInterval.allCases.count) { index in
                if self.viewModel.reminders(forInterval: DailyTimeInterval.allCases[index]).count > 0 {
                    Section(header: Text(DailyTimeInterval.allCases[index].rawValue).font(.system(size: 20)).bold().padding(.bottom, -10)) {
                        ForEach(self.viewModel.reminders(forInterval: DailyTimeInterval.allCases[index])) { reminder in
                            ReminderView(reminderModel: reminder, reminderDailyInterval: DailyTimeInterval.allCases[index])
                                .onTapGesture {
                                    self.generator.notificationOccurred(.success)
                                    self.viewModel.pillReminderSelected(id: reminder.id)
                            }
                            .onLongPressGesture {
                                self.generator.notificationOccurred(.error)
                                self.viewModel.deleteReminder(id: reminder.id)
                            }
                        }
                    }
                }
            }
        }
        .applyCustomListStyle()
        .environment(\.defaultMinListRowHeight, 110)
        .listStyle(GroupedListStyle())
        .padding(.top, -145)
    }
}

// MARK: - Canvas Preview
struct RemindersListView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView(viewModel: PillReminderViewModel())
    }
}
