//
//  SWCarouselViewModel.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/17.
//

import Foundation
import Combine
import SwiftUI

public class SWCarouselViewModel: ObservableObject {
    public var timerInterval: TimeInterval {
        didSet {
            restartTimer()
        }
    }
    public var itemCount: Int
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>!
    var timerCancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    @Published var currentIndex: Int = 1
    @Published public var realCurrentIndex: Int = 0
    
    @MainActor
    public init(timerInterval: TimeInterval = 5, itemCount: Int) {
        self.timerInterval = timerInterval
        self.itemCount = itemCount
        startTimer()
        $currentIndex.sink {[unowned self] index in
            self.adjustForLooping(currentIndex: index)
            self.adjustRealCurrentIndex(currentIndex: index)
        }.store(in: &cancellables)
    }
    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    func startTimer() {
        if timerInterval > 0, timerCancellable == nil {
            timer = Timer.publish(every: timerInterval, on: .main, in: .common).autoconnect()
            timerCancellable = timer.sink {[unowned self] _ in
                self.incrementIndex()
            }
        }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    func incrementIndex() {
        if itemCount <= 1 { return }
        withAnimation(.easeInOut) {
            self.currentIndex += 1
        }
    }

    @MainActor
    func adjustForLooping(currentIndex: Int) {
        if itemCount <= 1 { return }

        if currentIndex == itemCount + 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.currentIndex = 1
            }
        } else if currentIndex == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.currentIndex = self.itemCount
            }
        }
    }
    
    func adjustRealCurrentIndex(currentIndex: Int) {
        let index = currentIndex - 1
        if index < 0 {
            realCurrentIndex = itemCount - 1
        } else if index == itemCount {
            realCurrentIndex = 0
        } else {
            realCurrentIndex = index
        }
    }
}
