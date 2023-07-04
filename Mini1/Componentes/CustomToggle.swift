//
//  CustomToggle.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct CustomToggle: View {
    @State private var isToggleOn = false
    
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
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .padding()
            }
        }
    }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggle(icon: "clock.fill", color: .purple, title: "Title", subtitle: "Subtitle")
    }
}
