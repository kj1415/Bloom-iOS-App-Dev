//import SwiftUI
//
//struct GraphView: View {
//    var dataPoints: [Double] // Array of data points for the graph
//    var attribute: String // Attribute name for labeling
//    
//    var body: some View {
//        VStack {
//            Text("Graph for \(attribute)")
//                .font(.headline)
//                .padding(.bottom, 20)
//            
//            // Line graph view
//            LineChart(dataPoints: dataPoints)
//                .frame(height: 200)
//                .padding(.horizontal)
//        }
//        .padding()
//    }
//}
//
//struct LineChart: View {
//    var dataPoints: [Double] // Array of data points for the graph
//    
//    var body: some View {
//        GeometryReader { geometry in
//            Path { path in
//                for i in 0..<dataPoints.count {
//                    let x = geometry.size.width / CGFloat(dataPoints.count - 1) * CGFloat(i)
//                    let y = geometry.size.height * (1 - CGFloat(dataPoints[i]) / 100) // Normalize the data range
//                    if i == 0 {
//                        path.move(to: CGPoint(x: x, y: y))
//                    } else {
//                        path.addLine(to: CGPoint(x: x, y: y))
//                    }
//                }
//            }
//            .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
//        }
//    }
//}
