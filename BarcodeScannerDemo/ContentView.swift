//
//  ContentView.swift
//  Camera Demo
//
//  Created by Florian Gromes on 27.01.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var search: String = ""
    @State private var isAddingItem = false
    
    var itemQuery: Query<Item, [Item]> {
        var predicate: Predicate<Item>?
        if !search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            predicate = .init(#Predicate {
                $0.name.contains(search)
            })
        }
        return Query(filter: predicate, sort: \.name)
    }
    
    var body: some View {
        ItemListView(_items: itemQuery)
            .searchable(text: $search)
            .sheet(isPresented: $isAddingItem){
                CameraView()
            }
            .overlay{
                addItemButtonView
            }
    }
    
    var addItemButtonView: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button("add",
                       systemImage: "plus",
                       action: { isAddingItem = true })
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
                .padding(30)
            }
        }
    }
}

#Preview {
    ContentView()
}
