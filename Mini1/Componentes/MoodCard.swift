//
//  MoodCard.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct MoodCard: View, Identifiable, Equatable {
    var id = UUID()
    var emoji = ""
    var title: String = ""
    var description: String = ""
    var body: some View {
        HStack(alignment: .center) {
            Text(emoji)
                .font(.system(size: 64))
                .padding(.trailing, 16)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.regular)
            }
            .foregroundColor(.black)
            Spacer() 
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        
    }
}

struct MoodCard_Previews: PreviewProvider {
    static var previews: some View {
        MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
    }
}
