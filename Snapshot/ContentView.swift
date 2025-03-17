//
//  ContentView.swift
//  Snapshot
//
//  Created by Javier Calatrava on 17/3/25.
//

import SwiftUI

struct RootView: View {
    @State var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ContentView(navigationPath: $navigationPath)
                .navigationDestination(for: String.self) { destination in
                    switch destination {
                    case "SecondView":
                        SecondView(navigationPath: $navigationPath)
                    case "ThirdView":
                        ThirdView(navigationPath: $navigationPath)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}

struct ContentView: View {
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Text("First View")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                navigationPath.append("SecondView")
            }) {
                Text("Go to second viee")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("incrementButton")
        }
        .navigationTitle("First View")
    }
    
    func testButtonPress() {
        navigationPath.append("SecondView")
    }
}

struct SecondView: View {
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                navigationPath.append("ThirdView")
            }) {
                Text("Go to third view")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Second View")
    }
}

struct ThirdView: View {
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Text("Third View")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                // Pop to root
                navigationPath.removeLast(navigationPath.count) // Empty stack
            }) {
                Text("Get back to first view")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Third view")
    }
}
