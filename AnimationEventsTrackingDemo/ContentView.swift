//
//  ContentView.swift
//  AnimationStatusReporterDemo
//
//  Created by Serhiy Butz on 2023-05-30.
//

import SwiftUI
import AnimationUtils

struct ContentView: View {

    let diameter: CGFloat = 100
    @State var toggle: Bool = false
    @State var lastEvent: AnimationStatus?

    var body: some View {
        VStack {
            Spacer()
            GeometryReader { proxy in
                Circle()
                    .fill(lastEvent == .started ? .red : .green)
                    .overlay(
                        Text(lastEvent.map({ "\(String(describing: $0))" }) ?? "")
                    )
                    .frame(width: diameter, height: diameter)
                    .position(x: toggle ? proxy.size.width - diameter / 2 : diameter / 2,
                              y: proxy.size.height / 2)
            }
            Button("Toggle") {
                withAnimation(.spring(dampingFraction: 0.4)) {
                    toggle.toggle()
                }
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .padding(50)
        // vvv Tracking is done here
        .reportingAnimationStatus(for: toggle ? 1 : 0) { event in
            lastEvent = event
        }
        // ^^^
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
