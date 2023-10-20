//
//  AnimationTestApp.swift
//  AnimationTest
//
//  Created by woody on 10/20/23.
//

import SwiftUI

import ComposableArchitecture

let store = Store(initialState: ContentCore.State()) {
  ContentCore()
}

@main
struct AnimationTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(store: store)
    }
  }
}
