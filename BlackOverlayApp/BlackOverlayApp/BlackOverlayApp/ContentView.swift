import SwiftUI

struct ContentView: View {
    @State private var overlayActive = false
    @State private var tapCount = 0
    @State private var lastTapTime = Date()
    @State private var showHint = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if overlayActive {
                blackOverlayView
            } else {
                menuView
            }
        }
        .preferredColorScheme(.dark)
    }

    var blackOverlayView: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .gesture(
                    TapGesture(count: 2)
                        .onEnded {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                overlayActive = false
                                showHint = true
                            }
                        }
                )

            if showHint {
                VStack {
                    Spacer()
                    Text("double-tap to unlock")
                        .foregroundColor(.white.opacity(0.15))
                        .font(.caption)
                        .padding(.bottom, 50)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showHint = false
                        }
                    }
                }
            }
        }
    }

    var menuView: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 8) {
                Text("Black Overlay")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Covers your screen while other apps run")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Spacer()

            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    overlayActive = true
                    showHint = true
                }
            }) {
                Text("Activate Black Screen")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 40)
            }

            Text("Double-tap anywhere on the black screen to unlock")
                .foregroundColor(.gray.opacity(0.6))
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
                .frame(height: 40)
        }
    }
}

#Preview {
    ContentView()
}
