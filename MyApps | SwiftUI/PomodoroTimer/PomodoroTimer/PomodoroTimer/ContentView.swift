import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 25 * 60 
    @State private var isActive = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let minutesFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter
    }()
    
    private let secondsFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("Pomodoro Timer 🍎")
                .font(.callout)
                
            Text(formatTime(timeRemaining))
                .font(.system(size: 60))
                .fontDesign(.rounded)
                .bold()
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining) / CGFloat(25 * 60))
                    .stroke(Color.pink, lineWidth: 20)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: 90))
                
                Image(systemName: "applelogo")
                    .font(.system(size: 80))
                    .frame(width: 50, height: 50)
            }
            .padding()
            
            HStack {
                Button(action: {
                    startTimer()
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
                .padding()
                
                Button(action: {
                    pauseTimer()
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.indigo)
                }
                .padding()
                
                Button(action: {
                    resetTimer()
                }) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.pink)
                }
                .padding()
            }
        }
        .onReceive(timer) { _ in
            if isActive && timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
    
    private func startTimer() {
        isActive = true
    }
    
    private func pauseTimer() {
        isActive = false
    }
    
    private func resetTimer() {
        isActive = false
        timeRemaining = 25 * 60
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let formattedMinutes = minutesFormatter.string(from: NSNumber(value: minutes)) ?? "00"
        
        let remainingSeconds = seconds % 60
        let formattedSeconds = secondsFormatter.string(from: NSNumber(value: remainingSeconds)) ?? "00"
        
        return "\(formattedMinutes):\(formattedSeconds)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
