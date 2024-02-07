//
//  InventoryListView.swift
//  HelloWorld1
//
//  Created by Florian Gromes on 28.01.24.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    @Environment(\.modelContext) var context
    @Environment(\.editMode) var editMode
    
    @Query var items: [Item]
    @State private var selection = Set<Item>()
    
    var body: some View {
        NavigationStack{
            List(/*selection: $selection*/){
                ForEach(items){ item in
                    NavigationLink(value: item){
                        ItemRowView(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Inventory")
            .navigationDestination(for: Item.self){ item in
                ItemDetailView(item: item)
            }
            .toolbar{
                EditButton()
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(items[index])
            }
        }
    }
    
    //    private var disableSelection: Bool{
    //        if let mode = editMode?.wrappedValue, mode != .active{
    //            return true
    //        }
    //        return false
    //    }
    //
    //    private var disableDelete: Bool {
    //        if let mode = editMode?.wrappedValue, mode != .inactive {
    //            return true
    //        }
    //        return false
    //    }
}

#Preview {
    ItemListView()
        .modelContainer(for: Item.self, inMemory: true)
}

