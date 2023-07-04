//
//  CustomScheduler.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct CustomScheduler: View {
    
    struct Day {
        let name: String
        var isSelected: Bool
    }
    let items = ["Todos os dias", "Dias úteis (seg-sex)", "Fins de semana (sáb-dom)", "Personalizado"]
    
    @State var days: [Day] = [
        Day(name: "D", isSelected: false),
        Day(name: "S", isSelected: false),
        Day(name: "T", isSelected: false),
        Day(name: "Q", isSelected: false),
        Day(name: "Q", isSelected: false),
        Day(name: "S", isSelected: false),
        Day(name: "S", isSelected: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                CustomToggle(icon: "repeat", color: .red, title: "Repetir", subtitle: "Personalizado")
            }
            Divider()
            VStack(alignment: .leading, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                    Divider()
                }
            }
            HStack {
                Spacer()
                ForEach(days.indices, id: \.self) { index in
                    Button(action: {
                        days[index].isSelected.toggle()
                    }) {
                        Text(days[index].name)
                            .font(.title3)
                            .foregroundColor(buttonforegroundColor(for: days[index].isSelected))
                            .padding(11)
                            .background(buttonBackgroundColor(for: days[index].isSelected))
                            .clipShape(Circle())
                    }
                    .id(index)
                    
                }
                Spacer()
            }
            .background(Color(.systemGray4).opacity(0.6))
            .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func buttonBackgroundColor(for isSelected: Bool) -> Color {
        return isSelected ? Color.blue : Color(.systemGray5)
    }
    private func buttonforegroundColor(for isSelected: Bool) -> Color {
        return isSelected ? Color.white : Color(.systemGray2)
    }
    
}

struct CustomScheduler_Previews: PreviewProvider {
    static var previews: some View {
        CustomScheduler()
    }
}
