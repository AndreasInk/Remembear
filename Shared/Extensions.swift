//
//  Extensions.swift
//  Extensions
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
struct IdentifiableIndices<Base: RandomAccessCollection>
    where Base.Element: Identifiable {

    typealias Index = Base.Index

    struct Element: Identifiable {
        let id: Base.Element.ID
        let rawValue: Index
    }

    fileprivate var base: Base
}
extension IdentifiableIndices: RandomAccessCollection {
    var startIndex: Index { base.startIndex }
    var endIndex: Index { base.endIndex }

    subscript(position: Index) -> Element {
    Element(id: base[position].id, rawValue: position)
}

    func index(before index: Index) -> Index {
        base.index(before: index)
    }

    func index(after index: Index) -> Index {
        base.index(after: index)
    }
}
extension RandomAccessCollection where Element: Identifiable {
    var identifiableIndices: IdentifiableIndices<Self> {
        IdentifiableIndices(base: self)
    }
}
extension ForEach where ID == Data.Element.ID,
                        Data.Element: Identifiable,
                        Content: View {
    init<T>(
        _ indices: Data,
        @ViewBuilder content: @escaping (Data.Index) -> Content
    ) where Data == IdentifiableIndices<T> {
        self.init(indices) { index in
            content(index.rawValue)
        }
    }
}
