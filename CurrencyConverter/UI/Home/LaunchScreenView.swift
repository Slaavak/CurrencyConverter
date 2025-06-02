//
//  LaunchScreenView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 02/06/2025.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var logoScale: CGFloat = 0.5
    @State private var logoRotation: Double = 0
    @State private var showText = false
    @State private var backgroundColor = Color(.systemBackground)

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1), value: backgroundColor)

            VStack(spacing: 20) {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .scaleEffect(logoScale)
                    .rotationEffect(.degrees(logoRotation))
                    .onAppear {
                        withAnimation(.easeOut(duration: 1)) {
                            self.logoScale = 1
                            self.logoRotation = 360
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut(duration: 1)) {
                                self.showText = true
                                self.backgroundColor = Color.green.opacity(0.1)
                            }
                        }
                    }

                if showText {
                    Text("Currency Converter")
                        .font(.title)
                        .fontWeight(.bold)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
