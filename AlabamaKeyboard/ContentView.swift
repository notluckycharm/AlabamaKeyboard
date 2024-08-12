import SwiftUI
import UIKit

struct ContentView: View {
    @State private var example: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
            VStack {
                Text("Use this space to test the Keyboard")
                
                // Use a UIKitRepresentable to integrate UITextView with SwiftUI
                TextViewRepresentable(text: $example)
                    .frame(height: 300)
                    .padding()
                    .cornerRadius(2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding()
        }
    }
}

struct TextViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.delegate = context.coordinator
        
        // Set the custom keyboard if needed
        // textView.inputView = YourCustomKeyboardView()
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewRepresentable
        
        init(_ parent: TextViewRepresentable) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

#Preview {
    ContentView()
}
