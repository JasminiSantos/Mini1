//
//  ContentView.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 22/06/23.
//

import SwiftUI

struct OnboardingView: View {
    let nome: String = "Jasmini"
    var body: some View {
        VStack(alignment: .center) {
            Text("Como você está se sentindo, \(nome)?")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 30) {
                MoodCard()
                MoodCard()
                MoodCard()
                MoodCard()
            }
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
