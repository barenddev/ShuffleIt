import SwiftUI
import Combine
import ShuffleStack

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .yellow, .green, .gray, Color(.systemIndigo)]
    let sufflingPublisher = PassthroughSubject<Direction, Never>()
    var body: some View {
        ScrollView {
            ShuffleStack(colors) { color, translation in
                CardView(color: color, translation: translation)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleAnimation(.easeInOut)
            .stackOffset(30)
            .stackPadding(30)
            .shuffleTrigger(on: sufflingPublisher)
            .onShuffle { context in }
            .onTranslate { translation in }
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .swipeDisabled(true)
            .shuffleTrigger(on: sufflingPublisher)
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleStyle(.rotateIn)
            .shuffleAnimation(.easeIn)
            .shuffleTrigger(on: sufflingPublisher)
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleStyle(.rotateOut)
            .stackOffset(20)
            .shuffleTrigger(on: sufflingPublisher)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    let color: Color
    var translation: CGFloat = 0
    var body: some View {
        VStack {
            Text("Hello")
                .rotationEffect(.degrees(translation * 20))
                .padding(100)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(color)
        .cornerRadius(10)
    }
}

extension Color: Identifiable {
    public var id: Int {
        self.cgColor.hashValue
    }
}
