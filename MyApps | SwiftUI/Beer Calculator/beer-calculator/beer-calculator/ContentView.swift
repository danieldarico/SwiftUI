    //
    //  ContentView.swift
    //  beer-calculator
    //
    //  Created by Daniel Lameu de Souza on 30/05/23.
    //

    import SwiftUI
    import Foundation


    struct ContentView: View {
        @State private var mlInput: String = ""
        @State private var priceInput: String = ""
        @State private var beerOptions: [(ml: Int, price: Double)] = []

        var body: some View {
            VStack() {
                Text("Calculadora de Bebidas")
                    .font(.system(size: 30))
                    .bold()
                    .padding()
                Text("Encontre a opção com maior custo-benefício para comprar sua bebida!")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)

                VStack(alignment: .leading) {
                    Text("Quantidade de ml:")
                        .bold()
                    TextField("Digite a quantidade", text: $mlInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Preço da Bebida:")
                        .bold()
                    TextField("Digite o preço", text: $priceInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                HStack { // Added HStack for buttons alignment
                    Button(action: {
                        clearBeerOptions()
                    }) {
                        Text("Limpar tudo")
                            .padding()
                            .bold()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    
                    .disabled(beerOptions.isEmpty)
                    
                    
                    Button(action: {
                        addBeerOption()
                    }) {
                        Text("Adicionar opções")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .bold()
                            
                    }
                    .padding()
                }
                

                if !beerOptions.isEmpty {
                    Text("Opções adicionadas:")
                        .font(.headline)
                        .padding()

                    ForEach(beerOptions, id: \.ml) { option in
                        let pricePer100ml = calculatePricePer100ml(ml: option.ml, price: option.price)
                        let formattedPricePer100ml = formatDecimal(number: pricePer100ml)
                        Text("A opção de \(option.ml)ml custa R$ \(formattedPricePer100ml) para cada 100ml")
                            .padding()
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }

                    if let bestOption = findBestOption() {
                        let formattedPrice = formatDecimal(number: bestOption.price)
                        Text("Melhor opção: \(bestOption.ml) ml por R$ \(formattedPrice)")
                            .font(.headline)
                            .bold()
                            .padding()
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
        }

        func calculatePricePer100ml(ml: Int, price: Double) -> Double {
               return (price / Double(ml)) * 100
           }

           func formatDecimal(number: Double) -> String {
               let formatter = NumberFormatter()
               formatter.minimumFractionDigits = 0
               formatter.maximumFractionDigits = 2
               formatter.numberStyle = .decimal
               
               if let formattedString = formatter.string(from: NSNumber(value: number)) {
                   return formattedString
               } else {
                   return ""
               }
           }

           func findBestOption() -> (ml: Int, price: Double)? {
               guard let bestOption = beerOptions.min(by: { (option1, option2) -> Bool in
                   let pricePer100ml1 = calculatePricePer100ml(ml: option1.ml, price: option1.price)
                   let pricePer100ml2 = calculatePricePer100ml(ml: option2.ml, price: option2.price)
                   return pricePer100ml1 < pricePer100ml2
               }) else {
                   return nil
               }

               return bestOption
           }

           func addBeerOption() {
               guard let ml = Int(mlInput), let price = Double(priceInput) else {
                   return
               }

               beerOptions.append((ml: ml, price: price))

               // Reset input fields
               mlInput = ""
               priceInput = ""
           }

           func clearBeerOptions() {
               beerOptions.removeAll()
           }
       }

       struct ContentView_Previews: PreviewProvider {
           static var previews: some View {
               ContentView()
           }
       }
