//
//  TapRippleView.swift
//  Metaball Animation Demo
//
//  Created by Jay Khunt on 22/09/22.
//

import SwiftUI

struct TapRippleView: View {
    @State private var touches: [Touch] = []

    struct Touch: Identifiable {
        let id = UUID()
        let location: CGPoint
    }

    var body: some View {
        ZStack {
            Color.blue
            ripplesLayer
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    touches.append(
                        Touch(location: value.location)
                    )
                }
        )
        .edgesIgnoringSafeArea(.all)
    }

    var ripplesLayer: some View {
        ForEach(touches.suffix(5)) { touch in
            RippleView()
                .position(
                    x: touch.location.x,
                    y: touch.location.y
                )
        }
    }

    struct RippleView: View {
        @State private var isHidden = false
        @State private var size: CGFloat = 50

        var body: some View {
            Circle()
                .fill(Color.white.opacity(isHidden ? 0 : 0.5))
                .frame(width: size, height: size)
                .transition(.opacity)
                .animation(.easeOut(duration: 0.5), value: isHidden)
                .onAppear {
                    withAnimation {
                        isHidden = true
                        size = 200
                    }
                }
        }
    }
}


struct TapRippleView_Previews: PreviewProvider {
    static var previews: some View {
        TapRippleView()
    }
}
