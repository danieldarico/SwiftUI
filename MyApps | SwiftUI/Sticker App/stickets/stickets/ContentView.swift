//
//  ContentView.swift
//  stickers
//
//  Created by Daniel Lameu de Souza on 09/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var number1: String = ""
    @State private var number2: String = ""
    @State private var showResult = false
    @State private var result: Int = 0

    var body: some View {
        VStack {
            VStack {
                
                Text("Dia 1 - Primeiro desafio ✍️")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.indigo)
                TextField("Insira o valor 1: ", text: $number1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Insira o valor 2: ", text: $number2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Calcular") {
                    calculateSum()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                if showResult {
                    Text("O resultado da soma é: \(result)")
                }
            }
        }
    }
    
    func calculateSum() {
        let value1 = Int(number1) ?? 0
        let value2 = Int(number2) ?? 0
        
        result = value1 + value2
        showResult = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
