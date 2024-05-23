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
            CollectionViewController.Representable(state: state)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Button("Hello, Harmony!") {
                    state.title = "Hello, Harmony!"
                    state.sections = [.main]
                    state.items = (0 ..< Int.random(in: 1 ... 10)).map { Item(title: "Item \($0)") }
                }
            }
            .frame(alignment: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var state = ViewControllerState()
    static var previews: some View {
        ContentView(state: state)
    }
}
