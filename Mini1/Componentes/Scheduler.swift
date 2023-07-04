//
//  Scheduler.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct Scheduler: View {
    @State private var selected = Date()
    var icon: String
    var color: Color
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            CustomToggle(icon: icon, color: color, title: title, subtitle: subtitle)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.33)
                        .foregroundColor(.gray)
                    , alignment: .bottom
                )
                .padding(.horizontal)
            DatePicker("Select Hour", selection: $selected, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct Scheduler_Previews: PreviewProvider {
    static var previews: some View {
        Scheduler(icon: "clock.fill", color: .purple, title: "Title", subtitle: "Subtitle")
    }
}
