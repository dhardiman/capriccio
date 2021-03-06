//
//  FeatureFilesFetcher.swift
//  Capriccio
//
//  Created by Franco on 03/09/2018.
//

import Foundation

public final class FeatureFilesFetcher {
    private let fileManager: FileManaging
    
    public init(fileManager: FileManaging = FileManager.default) {
        self.fileManager = fileManager
    }
    
    public func featureFiles(atPath path: String) -> [String] {
        let directoryContents: [String]
        
        do {
            directoryContents = try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            fatalError("Unable to get files list at path \(path)")
        }
        
        return directoryContents.filter { $0.hasSuffix(".feature") }.map { path + "/" + $0 }
    }
}
