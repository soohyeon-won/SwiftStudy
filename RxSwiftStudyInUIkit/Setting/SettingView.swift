//
//  SettingView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/6/24.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var config: Config = .shared

    var body: some View {
        VStack {
            Text("codeView의 font size 조절기")
            Text(String(describing: config.codeViewFontSize)).font(.title)
            HStack {
                Button {
                    config.codeViewFontSize += 1
                    print("Config.shared.codeViewFontSize: \(config.codeViewFontSize)")
                } label: {
                    Text("+").font(.title2)
                }
                Button {
                    guard config.codeViewFontSize > 0 else { return }
                    config.codeViewFontSize -= 1
                } label: {
                    Text("-").font(.title2)
                }
            }
        }
    }
}
