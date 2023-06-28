//
//  ContentView.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct OnboardingView: View {
    let nome: String = "amigo"
    @State var nextPage : Bool = false
    @State var selectedMoodCard: MoodCard? = nil
    
    let moodCards = [
        MoodCard(emoji: "😆", title: "Ambicioso", description: "Me desafie!"),
        MoodCard(emoji: "😀", title: "Determinado", description: "Quero ir além."),
        MoodCard(emoji: "🙂", title: "Normal", description: "Vou seguir meus planos."),
        MoodCard(emoji: "😔", title: "Cansado", description: "Diminua a intensidade."),
        MoodCard(emoji: "☹️", title: "Desmotivado", description: "Simplifique minhas tarefas.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
        
                
                VStack(alignment: .leading, spacing: 20) {
                    Spacer(minLength: 50)
                    Text("Como você está se sentindo, \(nome)?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ForEach(moodCards) { moodCard in
                        Button(action: {
                            selectedMoodCard = moodCard
                        }) {
                            moodCard.body
                                .padding(4)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedMoodCard == moodCard ? Color.blue : Color.white)
                                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                                )
                        }
                    }
                }
                
                Button(action: {
                    if selectedMoodCard != nil {
                        nextPage = true
                    }
                }) {
                    GreenButton(title: "Vamos lá!")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 50)
            }
        }
        .padding(.horizontal, 20)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
