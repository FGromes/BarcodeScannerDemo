//
//  CameraView.swift
//  Camera Demo
//
//  Created by Florian Gromes on 29.01.24.
//

import SwiftUI
import SwiftData
import VisionKit

struct CameraView: View {
    private static let barHeightFactor = 0.15
    
    private var customTransition: AnyTransition {
        .move(edge: .bottom)
    }
    
    @State var text: String = "no result"
    @State var isScanning: Bool = false
    @State var item: Item?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
//                ViewfinderView(image:  $model.viewfinderImage )
                CameraScannerViewController(startScanning: $isScanning, scanResult: $text, newItem: $item)
                    .onAppear{
                        isScanning = true
                    }
                    .onDisappear{
                        isScanning = false
                    }
                    .overlay(alignment: .top) {
                        Color.black
                            .opacity(0.75)
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .overlay(alignment: .bottom) {
                        Color.black
                            .opacity(0.75)
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                        if let item = item{
                            ItemRowView(item: item)
                                .padding()
                                .background()
                                .clipShape(.rect(cornerRadius: 20))
                                .padding()
                                .id(item.id)
                                .transition(customTransition)
                        }
                    }
                    .background(.black)
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
        }
    }
}


#Preview {
    guard let giotto = dictionary[4008400122625]
    else { return CameraView() }
    let item = Item(ean: giotto.ean,
                    name: giotto.name,
                    category: giotto.category,
                    desc: giotto.desc,
                    imageName: giotto.imageName)
    return CameraView(item: item)
}
