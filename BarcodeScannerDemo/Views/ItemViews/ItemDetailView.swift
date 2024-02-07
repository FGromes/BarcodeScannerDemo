//
//  ItemDetailView.swift
//  Camera Demo
//
//  Created by Florian Gromes on 04.02.24.
//

import SwiftUI

struct ItemDetailView: View {
    @State var item: Item
    
    var body: some View {
        Form{
            HStack{
                Text("Name")
                Spacer()
                Text("\(item.name)")
            }
            HStack{
                Text("EAN Number")
                Spacer()
                Text("\(item.ean)")
            }
            HStack{
                Text("Category")
                Spacer()
                Text("\(item.category.rawValue)")
            }
            HStack{
                Text("Description")
                Spacer()
                Text("\(item.desc)")
            }
        }
    }
}

#Preview {
    let item = Item(ean: 1, name: "test", category: .Other, desc: "test desc.", imageName: "carrot")
    return ItemDetailView(item: item)
}
