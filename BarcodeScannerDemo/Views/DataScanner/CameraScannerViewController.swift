//
//  CameraScannerViewController.swift
//  Camera Demo
//
//  Created by Florian Gromes on 02.02.24.
//

import SwiftUI
import UIKit
import VisionKit
import SwiftData
import os.log

struct CameraScannerViewController: UIViewControllerRepresentable {
    @Environment(\.modelContext) private var context
    
    @Binding var startScanning: Bool
    @Binding var scanResult: String
    @Binding var newItem: Item?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [
//                .text(textContentType: .dateTimeDuration),
                .barcode()],
            qualityLevel: .fast,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true)
        
        viewController.delegate = context.coordinator

        return viewController
    }
    
    func updateUIViewController(_ viewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? viewController.startScanning()
        } else {
            viewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraScannerViewController
        init(_ parent: CameraScannerViewController) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
                case .text(let text):
                    parent.scanResult = text.transcript
                case .barcode(let code):
                    parent.scanResult = code.payloadStringValue ?? "Barcode error"
                    print("\(String(describing: code.payloadStringValue))")
                    if let temp = code.payloadStringValue,
                       let ean = Int(temp),
                       let article = dictionary[ean]{
                        withAnimation{
                            parent.newItem = Item(ean: article.ean,
                                                  name: article.name,
                                                  category: article.category,
                                                  desc: article.desc,
                                                  imageName: article.imageName)
                        }
                        if let item = parent.newItem{
                            parent.context.insert(item)
                        }
                    }
                default:
                    break
            }
        }
    }
}
