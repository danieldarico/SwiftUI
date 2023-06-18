//
//  ContentView.swift
//  mymarket
//
//  Created by Daniel Lameu de Souza on 11/06/23.
//

import SwiftUI
import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
    var totalPrice: Double {
        return Double(quantity) * price
    }
}

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var newProductName = ""
    @State private var newProductQuantity = ""
    @State private var newProductPrice: Double?  // Alteração: Mudança para Double opcional
    @State private var selectedProducts: Set<Product> = []
    
    var totalSpent: Double {
        return products.reduce(0) { $0 + $1.totalPrice }
    }
    
    var body: some View {
        VStack {
            
            Section(header: Text("Novo Produto")) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Nome do Produto")
                    TextField("Nome", text: $newProductName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Quantidade")
                    TextField("0", text: $newProductQuantity)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Preço por Unidade")
                    TextField("0", text: Binding(
                        get: {
                            if let price = newProductPrice {
                                return String(price)
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            newProductPrice = Double(newValue)
                        })
                    )
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                
                Button(action: addProduct) {
                    Text("Adicionar")
                }
            }
            
            .padding()
            
            Divider()
            
            List(selection: $selectedProducts) {
                ForEach(products) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text("\(product.quantity)")
                        Spacer()
                        Text(formatPrice(product.price))  // Utiliza a função formatPrice
                        Spacer()
                        Text(formatPrice(product.totalPrice))  // Utiliza a função formatPrice
                    }
                    .contentShape(Rectangle())
                }
                .onDelete(perform: removeProducts)
                .onMove(perform: moveProducts)
                
                HStack {
                    Spacer()
                    Text("Total gasto:")
                    Text(formatPrice(totalSpent))  // Utiliza a função formatPrice
                        .bold()
                }
                .padding(.vertical)
            }
            
            Divider()
            
            HStack {
                Button(action: clearAll) {
                    Text("Limpar tudo")
                }
                .disabled(products.isEmpty)
                
                Spacer()
            }
            .padding()
        }
        .environment(\.editMode, .constant(selectedProducts.isEmpty ? EditMode.inactive : EditMode.active))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton()
                
                Button(action: removeSelectedProducts) {
                    Image(systemName: "trash")
                }
                .disabled(selectedProducts.isEmpty)
            }
        }
    }
    
    func addProduct() {
        guard !newProductName.isEmpty,
              let quantity = Int(newProductQuantity)
        else {
            return
        }
        
        let product = Product(name: newProductName, quantity: quantity, price: newProductPrice ?? 0)  // Utiliza o valor padrão de 0 se o preço for nulo
        products.append(product)
        
        newProductName = ""
        newProductQuantity = ""
        newProductPrice = nil  // Alteração: Reinicia o valor para nulo
        
        hideKeyboard()
    }
    
    func removeProducts(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
    
    func moveProducts(from source: IndexSet, to destination: Int) {
        products.move(fromOffsets: source, toOffset: destination)
    }
    
    func clearAll() {
        products.removeAll()
    }
    
    func removeSelectedProducts() {
        products.removeAll { selectedProducts.contains($0) }
        selectedProducts.removeAll()
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
