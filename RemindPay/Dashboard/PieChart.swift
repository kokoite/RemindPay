//
//  PieChart.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 26/07/24.
//

import SwiftUI
import Charts

struct GymPieData: Identifiable {
    let id = UUID()
    let key: String
    let value: Int
    let color: Color
}

struct PieChart: View {
    let data = [

        GymPieData(key: "New joiner", value: 20, color: .pink),
        GymPieData(key: "Plan renewed", value: 40, color: .blue)
    ]
    var body: some View {
        VStack {
            Text("Monthly revenue")
                .font(.headline)

            Chart(data) { item in

                SectorMark(angle: .value(item.key, item.value),
                           angularInset: 10
                )
                .cornerRadius(5)
                .foregroundStyle(item.color)
            }
            .frame(height: 150)
        }
    }
}

#Preview {
    PieChart()
}
