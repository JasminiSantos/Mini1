//
//  ContentView.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct OnboardingView: View {
    let nome: String = "amigo"
    @StateObject var lista = ListaAtividades()
    @State var nextPage : Bool = false
    @State var moodSelected =  MoodCard(emoji: "Error", title: "Error", description: "Error")
    @State var isEnabled: Bool = false
    @State var cardOpacity = 1.0
    
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
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 10)
                    
                    ForEach(moodCards) { moodCard in
                        Button(action: {
                            moodSelected = moodCard
                            self.cardOpacity = 0.5
                            isEnabled = true
                        }) {
                            moodCard.body
                                .padding(4)
                                .opacity(moodSelected == moodCard ? 1.0 : cardOpacity)
                                .animation(.easeInOut)
                        }
                    }
                }
                .frame(maxWidth: 320)
                
                Button(action: {
                    
                    for atividade in lista.lista {
                        ModificadorAtividade().modificar(atividade: atividade, mood: moodSelected)
                    }
    
                    nextPage = true
                }) {
                    Text(isEnabled ? "Vamos lá!" : "Selecione uma opção")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .foregroundColor(isEnabled ? Color.white : Color.gray)
                        .padding()
                        .background(isEnabled ? Color.green : Color(.systemGray4))
                        .cornerRadius(10)
                }
                .disabled(!isEnabled)
                .padding(20)
                .fullScreenCover(isPresented: $nextPage){
                    ListaAtividadesView(lista: lista, mood:$moodSelected)
                }
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
