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
    private func promptMakerDuration(mood: MoodCard,active: Atividade) -> String{
        var prom = ""
        if(mood.title == "Ambicioso"){
            prom = "crie uma versão extremamente mais difícil desta tarefa, sugerindo apenas uma etapa dela de forma extremamente sintetizada e objetiva. Caso necessário, altere a localização da tarefa para um local mais acessível (exemplo: casa, quarteirão, garagem, etc) e, se aplicável, altere a quantidade de tempo (horas, minutos). Não modifique tarefas de rotina básica (exemplo: higiene básica, alimentação que não envolve dieta, comprar mantimentos essenciais, etc): (" + active.getAcao() + "," + active.getDuracao() + ")"
        }
        else if(mood.title == "Determinado"){
            prom = "crie uma versão levemente mais elaborada desta tarefa, sugerindo apenas uma etapa dela de forma extremamente sintetizada e objetiva. Caso necessário, altere a localização da tarefa para um local mais acessível (exemplo: casa, quarteirão, garagem, etc) e, se aplicável, altere a quantidade de tempo (horas, minutos). Não modifique tarefas de rotina básica (exemplo: higiene básica, alimentação que não envolve dieta, etc) : (" + active.getAcao() + "," + active.getDuracao() + ")"
        }
        else if (mood.title == "Cansado"){
            prom = "crie uma versão levemente menos elaborada desta tarefa, sugerindo apenas uma etapa dela de forma extremamente sintetizada e objetiva. Caso necessário, altere a localização da tarefa para um local mais acessível (exemplo: casa, quarteirão, garagem, etc) e, se aplicável, altere a quantidade de tempo (horas, minutos). Não modifique tarefas de rotina básica (exemplo: higiene básica, alimentação que não envolve dieta, etc) : (" + active.getAcao() + "," + active.getDuracao() + ")"
        }
        else if (mood.title == "Desmotivado"){
            prom = "crie uma versão extremamente mais fácil desta tarefa, sugerindo apenas uma etapa dela de forma extremamente sintetizada e objetiva. Caso necessário, altere a localização da tarefa para um local mais acessível (exemplo: casa, quarteirão, garagem, etc) e, se aplicável, altere a quantidade de tempo (horas, minutos). Não modifique tarefas de rotina básica (exemplo: higiene básica, alimentação que não envolve dieta, etc) : (" + active.getAcao() + "," + active.getDuracao() + ")"
        }
        return prom
    }
    //chamar a função apenas se precisar modificar
    func modificar(atividade: Atividade,mood: MoodCard) async {
        if(!atividade.concluida){
            let duracao = self.promptMakerDuration(mood: mood, active: atividade)
            if !duracao.isEmpty {
                let data = await self.apiRequestManager.makeRequest(text: duracao)
                if let data = apiRequestManager.responseData {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let choices = json["choices"] as? [[String: Any]] {
                            if let text = choices[0]["text"] as? String {
                                atividade.setModificar(acao: text, duracao: atividade.getDuracao())
                            }
                        }
                    }
                }
                
            }
        }
    }
}
