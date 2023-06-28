//
//  Modificador.swift
//  Mini1
//
//  Created by Robson Borges on 27/06/23.
//
import SwiftUI
import Foundation


struct ModificadorAtividade {
    @ObservedObject var apiRequestManager = ChatRequestManager()
    
    private func promptMakerAction(acao: String, duracao: String) -> String{
        //Aqui vamos compor o prompt para o chat.
        return "Terminar..."
    }
    private func promptMakerDuration(acao: String,duracao: String) -> String{
        let prom = "Simplifique a seguinte atividade : ('" + acao + "','" + duracao + "'). O retorno deve ser o valor da segunda aspas simples se não for possível reduzir esta tarefa, o retorno também deve ser em uma linha só. exemplo entrada( 'Caminhar', 'por 50 minutos')"
        
        return prom
    }
    //chamar a função apenas se precisar modificar
    func modificar(atividade: Atividade,mood: MoodCard){
        let duracao = promptMakerDuration(acao: atividade.getAcao(),duracao: atividade.getDuracao())
        Task{
            let data = await self.apiRequestManager.makeRequest(text: duracao)
            if let data = apiRequestManager.responseData {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let choices = json["choices"] as? [[String: Any]] {
                        if let text = choices[0]["text"] as? String {
                            atividade.setModificar(acao: atividade.getAcao(), duracao: text)
                        }
                    }
                }
            }
        }
        
        
    }
}
