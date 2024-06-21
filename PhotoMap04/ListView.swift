//
//  ListView.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/16.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: MarkerItem.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updateTime", ascending: false)],
        animation: .default)
    private var items: FetchedResults<MarkerItem>
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        EditMarkerItemView(editItem: item)
                    } label: {
                        VStack{
                            HStack{
                                Image(uiImage: UIImage(data: item.imageData!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                Text(item.title ?? "")
                                    .font(.title2)
                            }
                            Text("作成時間: \(item.dateFormatter(date: item.createdTime ?? Date()))")
                                .font(.footnote)
                            Text("更新時間: \(item.dateFormatter(date: item.updateTime ?? Date()))")
                                .font(.footnote)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ListView()
}
