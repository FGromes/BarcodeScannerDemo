//
//  ItemRowView.swift
//  Camera Demo
//
//  Created by Florian Gromes on 04.02.24.
//

import SwiftUI

struct ItemRowView: View {
    @State var item: Item
    var body: some View {
        HStack {
            item.image
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            VStack(alignment: .leading){
                Text(item.name)
                    .bold()
                Text(item.ean.description)
            }
            Spacer()
        }
    }
}

#Preview {
    let item = Item(ean: 1, name: "test", category: .Other, desc: "test desc.", imageName: "carrot")
    return ItemRowView(item: item)
}
