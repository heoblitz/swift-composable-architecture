//
//  ContentView.swift
//  AnimationTest
//
//  Created by woody on 10/20/23.
//

import SwiftUI

import ComposableArchitecture

struct ContentCore: Reducer {
  struct State: Equatable {
    var isShowingDetailView: Bool = false
  }
  
  enum Action {
    case showDetailButtonTapped
    case changeShowingDetailView
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .showDetailButtonTapped:
        return .send(.changeShowingDetailView).animation(.default)
        
        //        return .run { send in
        //          await send(.changeShowingDetailView)
        //        }
        //        .animation(.default)
        
      case .changeShowingDetailView:
        state.isShowingDetailView.toggle()
        return .none
      }
    }
    ._printChanges()
  }
}

struct ContentView: View {
  @Namespace private var namespace
  
  private let store: StoreOf<ContentCore>
  @ObservedObject private var viewStore: ViewStoreOf<ContentCore>
  
  init(store: StoreOf<ContentCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    ZStack {
      Color.clear
      
      if !self.viewStore.isShowingDetailView {
        Color.green
          .frame(width: 300, height: 300)
          .matchedGeometryEffect(id: "detail", in: self.namespace)
          .onTapGesture {
            self.viewStore.send(.showDetailButtonTapped)
          }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay {
      if self.viewStore.isShowingDetailView {
        Color.green
          .matchedGeometryEffect(id: "detail", in: self.namespace)
          .onTapGesture {
            self.viewStore.send(.showDetailButtonTapped)
          }
      }
    }
  }
}
