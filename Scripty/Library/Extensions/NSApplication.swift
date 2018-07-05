//
//  NSApplication.swift
//  Scripty
//
//  Created by Ivan Smetanin on 04/07/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

extension NSApplication {

    var shouldLaunchOnStartup: Bool {
        get {
            return LaunchOnStartup.getLaunchAtStartup()
        }
        set (value) {
            LaunchOnStartup.setLaunchAtStartup(value)
        }
    }

}

// TODO: Refactor it. Unclear code
fileprivate class LaunchOnStartup {

    static func setLaunchAtStartup(_ shouldLaunch: Bool) {
        let itemReferences = itemReferencesInLoginItems()
        let alreadyExists = (itemReferences.existingReference != nil)
        let loginItemsReferences = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
        ).takeRetainedValue() as LSSharedFileList?

        guard loginItemsReferences != nil else {
            return
        }

        if !alreadyExists && shouldLaunch {
            let appUrl = URL(fileURLWithPath: Bundle.main.bundlePath) as CFURL
            LSSharedFileListInsertItemURL(
                loginItemsReferences,
                itemReferences.lastReference,
                nil,
                nil,
                appUrl,
                nil,
                nil
            )
        } else if alreadyExists && !shouldLaunch {
            if let itemRef = itemReferences.existingReference {
                LSSharedFileListItemRemove(loginItemsReferences, itemRef)
            }
        }
    }

    static func getLaunchAtStartup() -> Bool {
        return itemReferencesInLoginItems().existingReference != nil
    }

    private static func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItem?, lastReference: LSSharedFileListItem?) {
        let applicationUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
        let loginItemsReferences = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
        ).takeRetainedValue() as LSSharedFileList?

        guard loginItemsReferences != nil else {
            return (nil, nil)
        }

        let loginItems = LSSharedFileListCopySnapshot(loginItemsReferences, nil).takeRetainedValue() as Array

        if loginItems.count == 0 {
            return (nil, kLSSharedFileListItemBeforeFirst.takeRetainedValue())
        }

        let lastItemReference = loginItems.last as! LSSharedFileListItem

        for currentItemReference in loginItems as! [LSSharedFileListItem] {
            if let itemUrl = LSSharedFileListItemCopyResolvedURL(currentItemReference, 0, nil),
                (itemUrl.takeRetainedValue() as URL) == applicationUrl {

                return (currentItemReference, lastItemReference)
            }
        }

        return (nil, lastItemReference)
    }

}
