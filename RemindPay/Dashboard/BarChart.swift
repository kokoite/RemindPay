//
//  PieChart.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 26/07/24.
//

import SwiftUI
import Charts

struct SalesData: Identifiable {
    let id = UUID()
    let month: String
    let sales: Double
}

struct BarChart: View {
    var data = [
        SalesData(month: "January", sales: 200),
        SalesData(month: "February", sales: 150),
        SalesData(month: "March", sales: 300),
        SalesData(month: "April", sales: 250),
        SalesData(month: "May", sales: 400)
    ]
    var body: some View {
        VStack {
            Text("Yearly revenue")
                .font(.headline)
            Chart(data) { item in
                BarMark(x: .value("Monthly data", item.month), y: .value("Money", item.sales))
                    .foregroundStyle(.pink)
                    .cornerRadius(6)

            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 300)

        }.padding()
    }
}

#Preview {
    BarChart()
}
