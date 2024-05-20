//
//  ContentView.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/18/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var state: ViewControllerState
    
    var body: some View {
        ZStack {
            CollectionViewController.Representable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Button("Hello, Harmony!") {
                    state.title = "Hello, Harmony!"
                }
            }
            .frame(alignment: .bottom)
            .onChange(of: state.title) {
                print($0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var state = ViewControllerState()
    static var previews: some View {
        ContentView(state: state)
    }
}
