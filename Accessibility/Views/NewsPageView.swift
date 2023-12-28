//
//  NewsPageViewView.swift
//  Accessibility
//
//  Created by Tekla on 12/27/23.
//

import SwiftUI

struct NewsPageView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @Environment(\.sizeCategory) var sizeCategory
    
    @State var articles = [
        Article(
            author: "John Doe",
            title: "Mock Article 1",
            description: "This is a mock article for testing purposes.",
            publishedAt: Date(),
            content: "This is the content of the mock article 1."
        ),
        Article(
            author: "Jane Smith",
            title: "Mock Article 2",
            description: "Another mock article to test SwiftUI views.",
            publishedAt: Date(),
            content: "This is the content of the mock article 2."
        )    ]
    
    var body: some View {
        NavigationView{
            NewsUITableViewRepresentable(articles: $articles)
            Text("Some text here")
        }
        .onAppear() {
            viewModel.fetchNews()
        }
    }
}

struct NewsUITableViewRepresentable: UIViewRepresentable {
    @Binding var articles: [Article]
    
    func makeUIView(context: Context) -> some UIView {
        let tableView = UITableView()
        tableView.backgroundColor = .systemIndigo
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.accessibilityLabel = "News Article list"
        tableView.isAccessibilityElement = true
        return tableView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Table View updated")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(source: articles)
    }
    
    class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
        var source: [Article]
        
        init(source: [Article]) {
            self.source = source
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            source.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = source[indexPath.row].title
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            let scaledFont = fontMetrics.scaledFont(for: UIFont.systemFont(ofSize: 17))
            cell.textLabel?.font = scaledFont
            cell.isAccessibilityElement = true
            cell.accessibilityLabel = source[indexPath.row].title
            return cell
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewsPageView()
        }
    }
}
