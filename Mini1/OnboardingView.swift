//
//  ContentView.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct OnboardingView: View {
    let nome: String = "amigo"
    var body: some View {
        VStack {
            Text("Como você está se sentindo, \(nome)?")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 20) {
                MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
                MoodCard(emoji: "😀", title: "Bem", description: "Crie uma meta adicional")
                MoodCard(emoji: "🙂", title: "Normal", description: "Nem bem, nem mal")
                MoodCard(emoji: "🫤", title: "Não tão bem", description: "Simplifique meus hábitos hoje")
            }
            .padding(.horizontal, 20)
            
            GreenButton(title: "Vamos lá!")
                .padding(.horizontal, 20)
                .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .ignoresSafeArea(.container, edges: .all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
