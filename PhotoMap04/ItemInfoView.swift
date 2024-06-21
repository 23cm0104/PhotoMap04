//
//  ItemInfoView.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/18.
//

import SwiftUI

struct ItemInfoView: View {
    @State var address: String?
    @State var imageData: Data?
    @State var comment: String?
    @State var title: String?
    @State var red: Float
    @State var green: Float
    @State var blue: Float
    
    var body: some View {
        ZStack{
            VStack {
                Text("住所: \(address ?? "")").padding()
                Image(uiImage: UIImage(data: imageData!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .padding()
                Text("タイトル: \(title ?? "")").font(.title).padding()
                Text("コメント: \(comment ?? "")").font(.body)
            }
            VStack{
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color(.sRGB, red: Double(red), green: Double(green), blue: Double(blue)))
                        .font(.system(size: 30))
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}
