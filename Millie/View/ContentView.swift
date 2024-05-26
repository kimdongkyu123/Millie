//
//  ContentView.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: verticalSizeClass == .regular ? 1 : 5)
        NavigationStack(path: $navigationRouter.destinations) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.news?.articles ?? []) { data in
                        NewsItemView(data: data,
                                     isVertical: verticalSizeClass == .regular,
                                     visitedList: viewModel.visitedList) {
                            if let url = data.url {
                                viewModel.visitedList.insert(url)
                                navigationRouter.push(to: .webView(url: url))
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: NavigationDestination.self) {
                switch $0 {
                case .webView(let url):
                    NewsWebView(url: URL(string: url)!)
                }
            }
        }
        .task {
            viewModel.execute()
        }
    }
}

struct NewsItemView: View {
    
    let data: Article
    let isVertical: Bool
    let visitedList: Set<String>
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometry in
                if let url = data.urlToImage, let imageUrl = URL(string: url) {
                    let cachedImage = ImageUtils.shared.getChcheImage(url: url)
                    AsyncImage(url: cachedImage ?? imageUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: geometry.size.height)
                                .clipped()
                                .task {
                                    ImageUtils.shared.saveCacheImage(url: url, image: image)
                                }
                        default:
                            Color.gray
                        }
                    }.frame(height: geometry.size.height)
                } else {
                    Color.gray
                }
            }

            Text(data.title ?? "-")
                .lineLimit(1)
                .font(Font.system(size: 15))
                .foregroundStyle(visitedList.contains(data.url ?? "") ? Color.red : Color.black)
                .padding(.horizontal, isVertical ? 16 : 0)
                .padding(.top, isVertical ? 10 : 0)

            Text(data.publishedAt?.parsingDate ?? "-")
                .font(Font.system(size: 13))
                .padding(.horizontal, isVertical ? 16 : 0)
                .padding(.bottom, isVertical ? 10 : 0)
        }
        .frame(height: isVertical ? 300 : 120)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationRouter())
}
