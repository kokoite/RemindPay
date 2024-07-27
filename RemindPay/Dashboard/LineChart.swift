//
//  LineChart.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 27/07/24.
//

import SwiftUI
import Charts

struct LineChartData: Identifiable {
    let id = UUID()
    let key: String
    let value: Int
}

struct LineChart: View {
    let data = [
        LineChartData(key: "J", value: 62),
        LineChartData(key: "F", value: 65),
        LineChartData(key: "M", value: 70),
        LineChartData(key: "A", value: 80),
        LineChartData(key: "My", value: 80),
        LineChartData(key: "Jn", value: 82),
        LineChartData(key: "Jl", value: 75)
    ]

    var body: some View {
        VStack {
            Text("Weight Chart")
                .font(.headline)
                .padding(.bottom, 10)
            Chart(data) { item in

                LineMark(x: .value("Months", item.key), y: .value("Weight", item.value))
                    .foregroundStyle(.pink)
                    .symbol {
                        Circle()
                            .fill(.pink)
                            .frame(width: 12, height: 12)
                    }
                    .interpolationMethod(.cardinal)

                PointMark(x: .value("Months", item.key), y: .value("Weight", item.value))
                    .opacity(0)
                    .foregroundStyle(.pink)
                    .annotation {
                        Text("\(item.value)")
                            .foregroundStyle(.pink)
                            .font(.headline)
                    }
            }
            .chartLegend(.hidden)
            .chartXAxisLabel("Months", alignment: .center)
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 4)) { value in
                    AxisValueLabel().font(.headline)
                    AxisTick()
                    AxisGridLine()
                }
            }
            .chartXAxis(content: {
                AxisMarks { value in
                    AxisValueLabel().font(.headline)

                }
            })
            .chartYScale(domain: 50...90)
            .frame(height: 300)
        }
        .padding()
        .clipShape(.rect)
    }
}

#Preview {
    LineChart()
}
