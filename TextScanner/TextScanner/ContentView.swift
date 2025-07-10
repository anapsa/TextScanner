//
//  ContentView.swift
//  TextScanner
//
//  Created by Ana Paula Sá Barreto Paiva da Cunha on 19/09/24.
//

import SwiftUI
import VisionKit
import Foundation
import AVKit
import Security

struct ContentView: View {
    @EnvironmentObject var viewmodel: ViewModel
    var value: String = ""
    
    var body: some View {
        VStack {
            switch viewmodel.accessStatus {
                case .scannerAvailable:
                    ScannerView()
                case .cameraNotAvailable:
                    Text("Seu dispositivo não possui uma câmera")
                case .scannerNotAvailable:
                    Text("Seu dispositivo não possui suporte para o scanner")
                case .notDetermined:
                    Text("Solicitando acesso a câmera")
                case .cameraAccessNotGranted:
                    Text("Por favor, libere o acesso a câmera nas configurações do dispositivo")

            }
        }
        .ignoresSafeArea()
        .padding()
    }
    

    
}

#Preview {
    ContentView()
}
