//
//  ContentView.swift
//  ShoppingKart
//
//  Created by Daniel Lameu de Souza on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var shoppingItems: [String] = []
    @State var newItem = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cart")
                    .foregroundColor(Color.pink)
                    .bold()
                Text("Lista de Compras")
                    .font(.title)
                    .foregroundColor(Color.pink)
                    .bold()
                    .padding()
            }
            
            HStack {
                TextField("Novo item", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addItem()
                }) {
                    Text("Adicionar")
                        .foregroundColor(.white)
                        .bold()
                        .padding(6)
                        .background(.pink)
                        .cornerRadius(25)
                }
            }
            .padding()
            
            List {
                ForEach(shoppingItems, id: \.self) { item in
                    Text(item)
                        .foregroundColor(.pink)
                        .bold()
                }
            }
        }
        .padding()
    }
    
    func addItem() {
        shoppingItems.append(newItem)
        newItem = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
