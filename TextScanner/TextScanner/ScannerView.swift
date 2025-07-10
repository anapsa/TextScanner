//
//  ScannerView.swift
//  TextScanner
//
//  Created by Ana Paula Sá Barreto Paiva da Cunha on 09/07/25.
//
import SwiftUI
import VisionKit

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
                                    Text("Texto desconhecido")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
