//
//  Atividade.swift
//  testChat
//
//  Created by Robson Borges on 23/06/23.
//
import SwiftUI
import Foundation
    
class Atividade: Identifiable , ObservableObject{
    let ID  = UUID()
    var concluida : Bool
    var mostrarModChat : Bool = false
    private var chatEditou : Bool = false
    private var acao : String
    private var duracao : String
    private var modAcao : String = ""
    private var modDuracao : String = ""
    private var dataCriacao : Date
    private var dataConclusao : Date? = nil
    
    init(acao: String,duracao: String,concluida: Bool = false){
        self.concluida = concluida
        self.acao = acao
        self.duracao = duracao
        self.dataCriacao = Date()
    }
    func concluir(){
        self.concluida.toggle()
        self.dataConclusao = Date()
    }
    func setAcao(texto:String){
        self.acao = texto
    }
    func setDuracao(texto: String){
        self.duracao = texto
    }
    func setModificar(acao:String ,duracao:String ){
        self.chatEditou = true
        self.mostrarModChat = true
        self.modAcao = acao
        self.modDuracao = duracao
    }
    func getChatEditou() -> Bool{
        return self.chatEditou
    }
    func getAcao() -> String {
        return self.acao
    }
    func getDuracao() -> String {
        return self.duracao
    }
    func getModAcao() -> String {
        return self.modAcao
    }
    func getModDuracao() -> String {
        return self.modDuracao
    }
    func getConcluida() -> Bool{
        return self.concluida
    }
    func getDataConcluida() -> Date? {
        if self.concluida{
            return self.dataConclusao
        }
        print("Atividade não concluida, Data de conclusão não existe.")
        return nil
    }
    func getDataCriacao() -> Date{
//        return self.dataConclusao == nil ?? self.dataCriacao
        if (self.dataConclusao != nil){
            return self.dataConclusao ?? self.dataCriacao
        }
        return self.dataCriacao
    }
}


class ListaAtividades : Identifiable, ObservableObject{
    @Published var lista = [Atividade(acao: "Ler 'O Hobbit'", duracao: "30 páginas"),
                Atividade(acao: "Caminhar", duracao: "50 minutos"),
                 Atividade(acao: "Beber água", duracao: "8 copos",concluida: true),
                Atividade(acao: "Consumir frutas e vegetais diariamente", duracao: "5 porções"),
                Atividade(acao: "Dormir", duracao: "7-8 horas"),
                Atividade(acao: "Praticar meditação", duracao: "15 minutos")]
    
}

struct AtividadeView: View{
    @Binding var atividade : Atividade
    @State var edit : Bool = false
    
    var body: some View{
            HStack{
                
                Button(action:{
                    edit.toggle()
                    atividade.concluida.toggle()
                }){
                    Image(systemName: atividade.getConcluida()  ? "checkmark.circle.fill": "circle")
                        .font(.system(size: 34))
                }
                VStack{
                    Text(atividade.getChatEditou() && atividade.mostrarModChat ? atividade.getModAcao() : atividade.getAcao())
                        .bold()
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                    
//                    Text(atividade.getChatEditou() && atividade.mostrarModChat ? atividade.getModDuracao() : atividade.getDuracao())
//                        .font(.system(size: 20))
//                        .frame(maxWidth: .infinity,alignment:.leading)
//                        .foregroundColor(.black)
//                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                .padding()
                Button(action:{
                    if(!atividade.concluida){
                        edit.toggle()
                        atividade.mostrarModChat.toggle()
                    }
                }){
                    Image(systemName:"wand.and.stars")
                        .font(.system(size: 28))
                        .foregroundColor(atividade.mostrarModChat ? Color(.systemGreen) : Color(.systemGray4))
                }
                
                
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .cornerRadius(16)
        }
        
    
}

struct AtividadeView_Previews: PreviewProvider{
    
    static var previews: some View{
        let atv = Atividade(acao: "Ler 'O Hobbit'", duracao: "30 páginas")
        return AtividadeView(atividade: .constant(atv))
    }
}
