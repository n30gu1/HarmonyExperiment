//
//  ContentView.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/18/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ZStack {
            CollectionViewController.Representable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Button("Hello, Harmony!") {
                    print("Hello, Harmony!")
                }
            }
            .frame(alignment: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
