//
//  Atividade.swift
//  testChat
//
//  Created by Robson Borges on 23/06/23.
//
import SwiftUI
import Foundation
    



//Classe que guarda todas as informações das atividades bem como possíveis operações
class Atividade: Identifiable , ObservableObject, Equatable {
    static func == (lhs: Atividade, rhs: Atividade) -> Bool {
        return lhs.id == rhs.id && lhs.concluida == rhs.concluida
    }
    
    var ID  = UUID()
    var concluida : Bool
    var mostrarModChat : Bool = false
    private var chatEditou : Bool = false
    private var acao : String
    private var modAcao : String = ""
    private var dataCriacao : Date
    private var dataConclusao : Date? = nil
    
    @Published var modificavel: Bool = false
    
    init(acao: String,concluida: Bool = false){
        self.concluida = concluida
        self.acao = acao
        self.dataCriacao = Date()
    }
    func concluir(){
        self.concluida.toggle()
        self.dataConclusao = Date()
    }
    func setAcao(texto:String){
        self.acao = texto
    }
    func setModificar(acao:String ){
        if(acao.count > 0){
            self.chatEditou = true
            self.mostrarModChat = true
            self.modAcao = acao
        }
    }
    func getChatEditou() -> Bool{
        return self.chatEditou
    }
    func getAcao() -> String {
        return self.acao
    }
    func getModAcao() -> String {
        return self.modAcao
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
        if (self.dataConclusao != nil){
            return self.dataConclusao ?? self.dataCriacao
        }
        return self.dataCriacao
    }
    //Não utilizar, essa função serve apenas para converter uma struct em atividade
    static func createAtividade(atividade: StructAtividade) -> Atividade {
        let act = Atividade(acao: atividade.acao)
        
        act.ID = atividade.ID
        act.concluida = atividade.concluida
        act.mostrarModChat = atividade.mostrarModChat
        act.chatEditou = atividade.chatEditou
        act.acao = atividade.acao
        act.modAcao = atividade.modAcao
        act.dataCriacao = atividade.dataCriacao
        act.dataConclusao = atividade.dataConclusao
        
        return act
    }
    //Não utilizar, essa função serve apenas para converter uma atividade em struct
    static func createStructAtividade(atividade: Atividade) -> StructAtividade{
        let act = StructAtividade(ID: atividade.ID, concluida: atividade.concluida, mostrarModChat: atividade.mostrarModChat, chatEditou: atividade.chatEditou, acao: atividade.acao, modAcao: atividade.modAcao, dataCriacao: atividade.dataCriacao, dataConclusao: atividade.dataConclusao ?? atividade.dataCriacao)
        
        return act
    }
}

struct AtividadeView: View{
    //Atividade que está sendo exibida
    var atividade : Atividade
    //Modo de visualização de edição do card
    let editMod : Bool
    
    @EnvironmentObject var listaAtividades: ListaAtividades
    
    
    var body: some View{
        HStack(alignment: .top){
                //Se não está no modo edição, mostramos o card normal
                if(!editMod){
                    Button(action:{
                        atividade.concluida.toggle()
                        listaAtividades.atualizarAtividade(atividade: atividade)
                    }){
                        Image(systemName: atividade.getConcluida()  ? "checkmark.circle.fill": "circle")
                            .font(.system(size: 34))
                            .foregroundColor(atividade.concluida ? Color("Botao_Apagado") : Color("Verde"))
                    }
                }
                //Se está no modo edição então mostramos essa parte
                else{
                    //Botão de apagar card
                    Button(action:{
                        listaAtividades.remover(atividade: atividade)
                    }){
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 34))
                            .foregroundColor(Color("Vermelho"))
                    }
                }
                Text(atividade.getChatEditou() && atividade.mostrarModChat ? atividade.getModAcao() : atividade.getAcao())
                    .bold()
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .foregroundColor(atividade.concluida ? Color("Placeholder_Texto") : Color("Texto"))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal,16)
                
                if(!editMod){
                    Button(action:{
                        if(!atividade.concluida){
                            atividade.mostrarModChat.toggle()
                            listaAtividades.atualizarAtividade(atividade: atividade)
                        }
                    }){
                        Image(systemName:"wand.and.stars")
                            .font(.system(size: 28))
                            .foregroundColor(atividade.mostrarModChat ? Color("Verde") : Color("Botao_Apagado"))
                    }
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
        let atv = Atividade(acao: "Um texto maior para testar o alinhamento é necessário aqui pois alguns cards podem ter um texto muito grande, e talvez seja necessário limitar a quantidade de caracteres")
        return AtividadeView(atividade: atv,editMod:false)
    }
}
