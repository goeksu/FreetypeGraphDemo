import SwiftUI

struct ContentView: View {
    @StateObject private var graphicsDriver = CocoaGraphicsDriver(width: 800, height: 600, title: "Graphics Demo")

    var body: some View {
        VStack {
            Image(nsImage: graphicsDriver.image)
                .resizable()
                .scaledToFit()
                .frame(width: 800, height: 600)
                .onAppear {
                    graphicsDriver.listenForEvents()
                    updateTestBitmap()
                }
        }
        .frame(width: 800, height: 600)
    }

    // Example test bitmap function
    private func updateTestBitmap() {
        let width = 800
        let height = 600
        var bitmap = [UInt8](repeating: 0, count: width * height * 4)

        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * 4
                bitmap[offset + 0] = UInt8(x % 256)    // Red
                bitmap[offset + 1] = UInt8(y % 256)    // Green
                bitmap[offset + 2] = 128               // Blue
                bitmap[offset + 3] = 255               // Alpha
            }
        }

        graphicsDriver.updateBitmap(bitmap, width: width, height: height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
