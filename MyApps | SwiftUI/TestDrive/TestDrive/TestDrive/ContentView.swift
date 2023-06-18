    //
    //  ContentView.swift
    //  TestDrive
    //
    //  Created by Daniel Lameu de Souza on 03/06/23.



    //  Criar um loop para setar o modelo de menu automaticamente. Armazenar todos os dados em uma array e colocar o loop para fazer automaticamente.

import SwiftUI

struct Model: Hashable {
    let icon: String
    let title: String
    let status: String?
    let color: Color
    
    init(icon: String, title: String, status: String? = nil, color: Color) {
        self.icon = icon
        self.title = title
        self.status = status
        self.color = color
    }
}

struct ContentView: View {
    
    let models = [
        Model(icon: "airplane", title: "Airplane Mode", color: .orange),
        Model(icon: "wifi", title: "Wi-Fi", status: "Marly 5G", color: .blue),
        Model(icon: "wave.3.right", title: "Bluetooth", status: "Not Connected", color: .blue),
        Model(icon: "antenna.radiowaves.left.and.right", title: "Cellular", status: "Off", color: .green),
        Model(icon: "personalhotspot", title: "Personal Hotspot", status: "Off", color: .green)
    ]
    
    var body: some View {
        Form {
            Section {

                    ForEach(models, id: \.self) { model in
                        HStack {
                            Image(systemName: model.icon)
                                .padding(8)
                                .background(model.color)
                                .foregroundColor(.white)
                                .frame(width: 28 , height: 28)
                                .cornerRadius(8)
                            Text(model.title)
                                Spacer()
                            Text(model.status ?? "")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                    }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
