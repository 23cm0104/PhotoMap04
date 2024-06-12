//
//  ContentView.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/12.
//

import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(){
                UserAnnotation()
            }.mapControls {
                MapUserLocationButton().mapControlVisibility(.visible)
                MapPitchToggle()
                MapCompass()
                MapScaleView().mapControlVisibility(.hidden)
            }
            Button(action: {}, label: {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(.white)
                    .foregroundColor(.blue)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }).padding()
        }
    }
}

#Preview {
    ContentView()
}
