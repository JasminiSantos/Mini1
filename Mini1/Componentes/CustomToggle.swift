//
//  CustomToggle.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var isToggleOn: Bool
    
    var icon: String
    var color: Color
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(color)
                    .cornerRadius(8)
                    .padding(.trailing, 8)
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color("Texto"))
                    
                    Text(subtitle)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: Color("Verde")))
            }
        }
    }
}
