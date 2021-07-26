//
//  QuizInputView.swift
//  QuizInputView
//
//  Created by Andreas on 7/25/21.
//

import Combine
import WebKit
import SwiftUI
import SwiftSoup

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // TODO
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // TODO
        decisionHandler(.allow)
    }
}

class WebViewModel: ObservableObject {
    let webView: WKWebView
    
    private let navigationDelegate: WebViewNavigationDelegate
    
    init() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = WebViewNavigationDelegate()
        
        webView.navigationDelegate = navigationDelegate
        setupBindings()
    }
    
    @Published var urlString: String = "https://share.streamlit.io/andreasink/quiz-api/main/main.py"
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false
    @Published var text: String = "Python is an interpreted high-level general-purpose programming language. Python's design philosophy emphasizes code readability with its notable use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects."
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
        
        webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)
        
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        webView.load(URLRequest(url: url))
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
            //print(html)
            self.getQuizFromStreamlit(html: "\(html)")
        
        })
        }
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
    var recievedInput = false
    func inputTextToStreamlit(html: String) {
        if !recievedInput {
        do {
           
            //print(html)
            let doc = try? SwiftSoup.parse(html)

            let div: Element = try doc?.select("input").first() ?? Element(Tag("a"), "a") // <div></div>
            if div.tag().toString() != "a" {
           // try div.text(text) // <div>five &gt; four</div>
                let jsFunc = "document.getElementByClass(\"\("input")\").value = \"\(text)\""
                    webView.evaluateJavaScript(jsFunc, completionHandler: nil)
                print(1)
                recievedInput = true
        print(div)
            } else {
                print(2)
                
              
            }
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    }
    func getQuizFromStreamlit(html: String) {
        if !recievedInput {
        do {
       
        let document = try SwiftSoup.parse(html)
            print( try document.getElementsContainingText(" ").toString())
        let categories: Elements = try document.select("[class~=\("css-j8zjtb eyqtai90")]")
            print(try categories.toString())
        } catch {
        }
        }
    }
}


struct QuizInputView: View {
    
    @StateObject var model = WebViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
           
                
                ZStack {
                    WebView(webView: model.webView)
                        .ignoresSafeArea()
                        .onAppear() {
                            model.loadUrl()
                        }
                    
                }
                
            }
        }
        
    }
    
}

  
 
