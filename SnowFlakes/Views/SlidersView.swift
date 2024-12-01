//
//  SlidersView.swift
//  SnowFlakes
//
//  Created by Tanner W. Stokes on 12/1/24.
//
import SwiftUI

struct SlidersView: View {
    @Binding var size: Float
    @Binding var birthRate: Float
    let mode: EmitterMode
    var renderer: SnowRenderer?

    var body: some View {
        VStack {
            HStack {
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.5)
                    .frame(width: 25, height: 20)
                Slider(value: $size, in: 1 ... 5, step: 1)
                    .onChange(of: size) { renderer?.changeSize($1) }
                sizeImageForMode
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
            }
            Divider()
            HStack {
                Image("sparse")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
                Slider(value: $birthRate, in: 1 ... 5, step: 1)
                    .onChange(of: birthRate) { renderer?.changeBirthRate($1) }
                Image("dense")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 20)
            }
        }
    }

    private var sizeImageForMode: Image {
        switch mode {
        case .snow:
            return Image("snow")
        case .flakes:
            return Image("flake")
        }
    }
}
