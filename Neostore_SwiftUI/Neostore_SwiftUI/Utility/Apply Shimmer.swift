//
//  Apply Shimmer.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 13/02/24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func applyShimmer(if condition: Bool) -> some View {
        if condition {
            self
                .redacted(reason: .placeholder)
                .shimmering()
        } else {
            self
        }
    }
}
