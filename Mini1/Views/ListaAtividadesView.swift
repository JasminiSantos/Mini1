//
//  ListaAtividadesView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI

struct ListaAtividadesView: View {
    @ObservedObject var lista : ListaAtividades
    @Binding var mood : MoodCard
    @State var voltarView : Bool = false
    @State var carregando : Bool = true
    
    @State private var showingEditingSheet = false
    
    var body: some View {
            ScrollView {
                if(!carregando){
                    HStack {
                        Button(action:{
                            voltarView = true
                        }){
                            Text(mood.emoji)
                                .font(.system(size: 40))
                        }
                        .fullScreenCover(isPresented: $voltarView){
                            OnboardingView()
                        }
                        
                        Text("Suas atividades")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        ForEach(lista.lista.indices) { index in
                            if !lista.lista[index].concluida {
                                AtividadeView(atividade: $lista.lista[index])
                                    .cornerRadius(16)
                                    .onTapGesture {
                                        showingEditingSheet = true
                                    }
                                    .sheet(isPresented: $showingEditingSheet) {
                                        EditorAtividadeView()
                                    }
                            }
                        }
                        ForEach(lista.lista.indices) { index in
                            if lista.lista[index].concluida {
                                AtividadeView(atividade: $lista.lista[index])
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
                else{
                    VStack{
                        Text("Modificando suas atividades...")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .onAppear {
                
                Task {
                    for atividade in lista.lista {
                        await ModificadorAtividade().modificar(atividade: atividade, mood: mood)
                    }
                    carregando = false
                }
                
                
            }
    }
}

struct ListaAtividadesView_Previews: PreviewProvider {
    @State static private var moodSelected = MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
    @StateObject static private var lista = ListaAtividades()
    static var previews: some View {
        ListaAtividadesView(lista: lista, mood: $moodSelected)
    }
}
