//
//  WaveView.swift
//  Metaball Animation Demo
//
//  Created by Jay Khunt on 22/09/22.
//

import SwiftUI

struct WaveView: View {
    
    @State var ripple: Ripple = Ripple(diameter: 0, isFading: false)
    @State var ripple1: Ripple = Ripple(diameter: 0, isFading: false)
    @State var ripple2: Ripple = Ripple(diameter: 0, isFading: false)
    @State var ripple3: Ripple = Ripple(diameter: 0, isFading: false)
    @State var dropOffset: CGFloat = -200
    @State var isClick = false
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .fill(Color.init(red: 225/255, green: 225/255, blue: 235/255))
                    .frame(width: 30, height: 30)
                    .overlay {
                        Circle()
                            .fill(Color.gray)
                            .blur(radius: 2.0)
                            .offset(x: 2, y: 2)
                    }
                    .overlay {
                        Circle()
                            .fill(Color.white)
                            .blur(radius: 8.0)
                            .offset(x: -2, y: -2)
                    }.offset(y: dropOffset)
                    .opacity(dropOffset == 30 ? 0 : 1)
            }
            .frame(width: 200, height: 600)
            .zIndex(1)
            
            ZStack {
                RippleView(ripple: $ripple).opacity(ripple.isFading ? 0 : 1)
                RippleView(ripple: $ripple1).opacity(ripple1.isFading ? 0 : 1)
                RippleView(ripple: $ripple2).opacity(ripple2.isFading ? 0 : 1)
                RippleView(ripple: $ripple3).opacity(ripple3.isFading ? 0 : 1)
                Rectangle().fill(Color.clear)
                Button {
                    isClick.toggle()
                    withAnimation(.linear(duration: 0.8)) {
                        dropOffset = isClick ? 30 : -200
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.linear(duration: 3.0)) {
                            ripple.isFading = isClick
                            ripple.diameter = isClick ? 300 : 0
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 3.0)) {
                            ripple1.isFading = isClick
                            ripple1.diameter =  isClick ? 300 : 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.linear(duration: 3.0)) {
                            ripple2.isFading = isClick
                            ripple2.diameter =  isClick ? 300 : 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.linear(duration: 3.0)) {
                            ripple3.isFading = isClick
                            ripple3.diameter =  isClick ? 300 : 0
                        }
                    }
                } label: {
                    Text("Click")
                }
            }
            .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
            .background(Color.init(red: 229/255, green: 229/255, blue: 239/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Ripple {
    var diameter: CGFloat
    var lineWidth: CGFloat = 10
    var isFading: Bool
}

struct RippleView: View {
    @Binding var ripple: Ripple
    
    var body: some View {
        Circle()
            .fill(Color.init(red: 225/255, green: 225/255, blue: 235/255))
            .frame(width: ripple.diameter, height: ripple.diameter)
            .overlay {
                Circle().stroke(Color.gray, lineWidth: ripple.lineWidth)
                    .blur(radius: 4.0)
                    .offset(x: 2, y: 2)
            }
            .overlay {
                Circle().stroke(Color.white, lineWidth: ripple.lineWidth)
                    .blur(radius: 4.0)
                    .offset(x: -2, y: -2)
            }
    }
}


struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        WaveView()
    }
}
