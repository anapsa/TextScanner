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
                    Text("Your device doesn't have a camera")
                case .scannerNotAvailable:
                    Text("Your devide doesn't have support for scanner ")
                case .notDetermined:
                    Text("Requesting caamera access")
                case .cameraAccessNotGranted:
                    Text("Please provide access to the camera in settings")

                
            }
        }
        .padding()
    }
    

    
}
struct ScannerView: View{
    @EnvironmentObject var viewmodel: ViewModel
    var body: some View{
        VStack {
            ScannerController(recognizedItems:$viewmodel.recognizedItems)
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewmodel.recognizedItems) { item in
                            Group {
                                switch item {
                                case .text(let recognizedText):
                                    Text(recognizedText.transcript) 
                                default:
                                    Text("Unknown Value")
                                }
                            }
                        }
                    }
                }
            }
        }
    
    }
}
#Preview {
    ContentView()
}
