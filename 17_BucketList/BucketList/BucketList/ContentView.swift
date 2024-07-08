//
//  ContentView.swift
//  BucketList
//
//  Created by Prathamesh Sonawane on 02/07/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 21.0000, longitude: 78.0000),
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        )
    )
    
    @State private var mapStyle = MapStyle.standard
    @State private var mapStyles = ["Standard", "Hybrid"]
    @State private var selectedMapStyle = "Standard"
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(mapStyle)
                .onChange(of: selectedMapStyle, { oldValue, newValue in
                    switch(newValue) {
                    case "Standard":
                        mapStyle = MapStyle.standard
                        
                    case "Hybrid":
                        mapStyle = MapStyle.hybrid
                        
                    default:
                        mapStyle = MapStyle.standard
                    }
                })
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) {
                    viewModel.update(location: $0)
                }
            }
            
            Picker("Select Map Style", selection: $selectedMapStyle) {
                ForEach(mapStyles, id: \.self) { mapStyle in
                    Text(mapStyle)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
