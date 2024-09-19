//
//  ModelView.swift
//  TextScanner
//
//  Created by Ana Paula Sá Barreto Paiva da Cunha on 19/09/24.
//

import SwiftUI
import VisionKit
import Foundation
import AVKit


enum AccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}
@MainActor
final class ViewModel: ObservableObject {
    @Published var accessStatus: AccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var textContentType: DataScannerViewController.TextContentType?

    var recognizedDataType: DataScannerViewController.RecognizedDataType = .text(
        languages: ["pt-BR", "en-US"]
    )
    private var scannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    func requestDataScannerAccessStatus () async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            accessStatus = .cameraNotAvailable
            return
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                if(scannerAvailable) {
                    accessStatus = .scannerAvailable
                } else {
                    accessStatus = .scannerNotAvailable
                }
            case .restricted:
                accessStatus = .cameraAccessNotGranted
            case .denied:
                accessStatus = .cameraAccessNotGranted
            case .notDetermined:
                let result = await AVCaptureDevice.requestAccess(for: .video)
                if (result) {
                    if(scannerAvailable) {
                        accessStatus = .scannerAvailable
                    } else {
                        accessStatus = .scannerNotAvailable
                    }
                } else {
                    accessStatus = .cameraAccessNotGranted
                }
            default: break
            
            
        }
    }
}
