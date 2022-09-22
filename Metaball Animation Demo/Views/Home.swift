//
//  Home.swift
//  Metaball Animation Demo
//
//  Created by Jay Khunt on 22/09/22.
//

import SwiftUI

struct Home: View {
    
    @State var drawOffset: CGSize = .zero
    @State var startAnimation = false
    
    @State var type: String = "Single"
    
    var body: some View {
        //MARK: Single Metaball Animation
        VStack {
            Text("Metaball Animation")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
            
            Picker(selection: $type) {
                Text("Metaball")
                    .tag("Single")
                Text("Clubbed")
                    .tag("Clubbbed")
            } label: {
                
            }.pickerStyle(.segmented)
                .padding(.horizontal, 15)

            if type == "Single" {
                SingleMetaViewball()
            } else {
                ClubbedView()
            }
        }
    }
    
    @ViewBuilder
    func ClubbedView() -> some View {
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"), Color("Gradient2")], startPoint: .top, endPoint: .bottom))
            .mask({
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) {_ in
                    Canvas { context, size in
                        context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                        context.addFilter(.blur(radius: 35))
                        context.drawLayer { ctx in
                            for index in 1...15 {
                                if let resolveView = ctx.resolveSymbol(id: index) {
                                    ctx.draw(resolveView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        ForEach(1...15, id: \.self) { index in
                            let offset = (startAnimation ? CGSize(width: .random(in: -180...180), height: .random(in: -240...240)) : .zero )
                            ClubbedRoundedRectangle(offset: offset)
                                .tag(index)
                        }
                    }
                }
            })
        .contentShape(Rectangle())
        .onTapGesture {
            startAnimation.toggle()
        }
    }
    
    @ViewBuilder
    func ClubbedRoundedRectangle(offset: CGSize = .zero) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
            // MARK: Adding Animation [Less Than TimeLine View Refresh Rate]
            .animation(.easeInOut(duration: 4), value: offset)
    }
    
    @ViewBuilder
    func SingleMetaViewball() -> some View {
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"), Color("Gradient2")], startPoint: .top, endPoint: .bottom))
            .mask {
                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    context.addFilter(.blur(radius: 35))
                    context.drawLayer { ctx in
                        for index in [1,2] {
                            if let resolveView = ctx.resolveSymbol(id: index) {
                                ctx.draw(resolveView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball()
                        .tag(1)
                    
                    Ball(offset: drawOffset)
                        .tag(2)
                }
            }.gesture(
                DragGesture()
                    .onChanged({ value in
                        drawOffset = value.translation
                    }).onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            drawOffset = .zero
                        }
                    })
            )
    }
    
    @ViewBuilder
    func Ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
