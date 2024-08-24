import Cocoa
import SwiftUI

@objc class CocoaGraphicsDriver: NSObject, ObservableObject {
    @Published var image: NSImage
    private var bitmap: NSBitmapImageRep

    init(width: Int, height: Int, title: String) {
        self.bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height,
                                       bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                                       colorSpaceName: .deviceRGB, bitmapFormat: .alphaFirst, bytesPerRow: width * 4,
                                       bitsPerPixel: 32)!
        
        self.image = NSImage(size: NSSize(width: width, height: height))
        super.init()
        
        self.image.addRepresentation(self.bitmap)
    }

    func updateBitmap(_ newBitmap: [UInt8], width: Int, height: Int) {
        bitmap.bitmapData?.initialize(from: newBitmap, count: width * height * 4)
        self.image = NSImage(size: NSSize(width: width, height: height))
        self.image.addRepresentation(bitmap)
    }

    func listenForEvents() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            switch event.keyCode {
            case 53: // escape 
                NSApplication.shared.terminate(self)
            default:
                print("Key pressed: \(event.charactersIgnoringModifiers ?? "")")
            }
            return event
        }
    }
}
