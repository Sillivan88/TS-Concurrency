//
//  ContentView.swift
//  TS Concurrency
//
//  Created by Thomas Sillmann on 24.09.21.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [String]()
    
    var body: some View {
        photosList
            .task {
                photos.append(contentsOf: await loadImages())
            }
    }
    
    @ViewBuilder private var photosList: some View {
        if photos.isEmpty {
            ProgressView("Loading photos ...")
        } else {
            List {
                ForEach(photos, id: \.self) { photo in
                    Image(photo)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
    
    private func loadImages() async -> [String] {
        await Task.sleep(5 * 1_000_000_000)
        return ["Cockatiel01", "Cockatiel02", "Cockatiel03"]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
