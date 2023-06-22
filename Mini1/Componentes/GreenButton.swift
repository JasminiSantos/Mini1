//
//  GreenButton.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct GreenButton: View {
    let title: String
    var body: some View {
        Button(action: {
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}

struct GreenButton_Previews: PreviewProvider {
    static var previews: some View {
        GreenButton(title: "Vamos lá!")
    }
}
