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
    @State private var count = 0
    @FocusState private var newItemIsFocused: Bool
    
    
    var body: some View {
        VStack {
            HStack {
                Text("🛒 Shopping Cart")
                    .font(.title)
                    .foregroundColor(Color.gray)
                    .bold()
                    .padding()
            }
            
            HStack {
                TextField("New item", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($newItemIsFocused)
                
                Button( action: {
                    
                    addItem()
                }) {
                    Text("Add item")
                        .bold()
                        .padding(7)

                }
            }
            
            .padding()
            
            Text("Itens Added: \(count)")
                .bold()
                .font(.callout)
                .foregroundColor(.blue)
            
            List {
                ForEach(shoppingItems, id: \.self) { item in
                    HStack {
                        Text(item)
                            .foregroundColor(.blue)
                            .bold()
                        Spacer()
                        Button(action: {
                            removeLastItem()
                        }) {
                            Image(systemName: "cart.badge.minus")
                                .foregroundColor(.red)
                        }
                    }
                }
                
            }
               
            if !shoppingItems.isEmpty {
                Button("Clear all") {
                    count = 0
                    clearAll()
                }
                .foregroundColor(.white)
                .bold()
                .padding(6)
                .background(Color.black)
                .cornerRadius(25)
            }
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Hide Keyboard") {
                    newItemIsFocused = false
                }
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(25)
                .padding(6)
            }
        }
    }
    
    func addItem() {
        if !newItem.isEmpty {
            shoppingItems.append(newItem)
            newItem = ""
            count += 1
        }

    }
    
    func removeLastItem() {
        if !shoppingItems.isEmpty {
            shoppingItems.removeLast()
            count -= 1
        }
    }
    func clearAll() {
        if !shoppingItems.isEmpty {
            shoppingItems.removeAll()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
