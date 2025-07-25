//
//  HighlightedText.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct HighlightedText: View {
    let fullText: String
    let highlightedTexts: [String]
    var highlightColor: AppColor = .primaryNormal
    var highlightColors: [AppColor] = []
    var font: AppFontStyle? = nil
    var defaultColor: AppColor = .textAlternative

    // MARK: - body
    var body: some View {
        Text(buildAttributedString())
            .foregroundColor(defaultColor.color)
    }

    
    // MARK: - buildAttributedString
    private func buildAttributedString() -> AttributedString {
        var attributedString = AttributedString(fullText)
        let fullNSString = NSString(string: fullText)

        let pairs: [(String, AppColor)] = {
            if highlightedTexts.count == highlightColors.count && !highlightedTexts.isEmpty {
                return Array(zip(highlightedTexts, highlightColors))
            } else {
                return highlightedTexts.map { ($0, highlightColor) }
            }
        }()

        for (text, color) in pairs {
            applyHighlight(
                to: &attributedString,
                in: fullNSString,
                highlightedText: text,
                highlightColor: color
            )
        }

        return attributedString
    }

    // MARK: - applyHighlight
    private func applyHighlight(
        to attributedString: inout AttributedString,
        in fullNSString: NSString,
        highlightedText: String,
        highlightColor: AppColor
    ) {
        var searchRange = NSRange(location: 0, length: fullNSString.length)

        while searchRange.location != NSNotFound {
            searchRange = fullNSString.range(of: highlightedText, options: [], range: searchRange)
            if searchRange.location != NSNotFound,
               let range = Range(searchRange, in: fullText),
               let attRange = Range(range, in: attributedString) {

                attributedString[attRange].foregroundColor = highlightColor.color

                if let font = font {
                    attributedString[attRange].font = UIFont(name: font.pretendard.rawValue, size: font.size)
                }

                let nextLocation = searchRange.location + searchRange.length
                if nextLocation < fullNSString.length {
                    searchRange = NSRange(location: nextLocation, length: fullNSString.length - nextLocation)
                } else {
                    break
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack {
        HighlightedText(
            fullText: "This is a sample text with some highlighted parts.",
            highlightedTexts: ["text", "highlighted", "This is"],
            font: .subtitle1
        )
        .fontStyle(.caption1)
        .padding()
        
        HighlightedText(
            fullText: "This is a sample text with some highlighted parts.",
            highlightedTexts: ["text", "highlighted", "This is"],
            highlightColors: [.primaryNormal,
                              .primaryAlternative,
                              .orange],
            font: .title1
        )
        .fontStyle(.subtitle1)
        .padding()
        
        HighlightedText(
            fullText: "Test Test Test Test 123 123 123 456 456 456",
            highlightedTexts: ["Test", "123", "456"],
            highlightColors: [.primaryNormal,
                              .primaryAlternative,
                              .orange],
            font: .title1
        )
        .padding()
    } // : VS
}
