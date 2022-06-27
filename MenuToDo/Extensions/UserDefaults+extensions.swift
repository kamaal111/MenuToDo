//
//  UserDefaults+extensions.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import Foundation

extension UserDefaults {
    @UserDefaultObject(key: .menubarIcon)
    static var menubarIcon: IconNames?
}

@propertyWrapper
class UserDefaultObject<Value: Codable>: UserDefaultBase<UserDefaultObject.Keys> {
    enum Keys: String {
        case menubarIcon
    }

    var wrappedValue: Value? {
        get { value }
        set { setValue(newValue) }
    }

    var projectedValue: UserDefaultObject { self }

    private var value: Value? {
        guard let container = container else { return nil }

        let data: Data?
        if let standardValue = staleStandardValueData {
            container.setValue(standardValue, forKey: constructedKey)
            UserDefaults.standard.removeObject(forKey: constructedKey)
            data = standardValue
        } else {
            data = container.object(forKey: constructedKey) as? Data
        }

        guard let data = data else { return nil }

        return try? JSONDecoder().decode(Value.self, from: data)
    }

    private func setValue(_ newValue: Value?) {
        guard let container = container else { return }

        if staleStandardValueData != nil {
            UserDefaults.standard.removeObject(forKey: constructedKey)
        }

        guard let newValue = newValue, let data = try? JSONEncoder().encode(newValue) else { return }

        container.set(data, forKey: constructedKey)
    }
}

class UserDefaultBase<Key: RawRepresentable> where Key.RawValue == String {
    let key: Key
    let container: UserDefaults?

    init(key: Key, container: UserDefaults? = .standard) {
        self.key = key
        self.container = container
    }

    func removeValue() {
        container?.removeObject(forKey: constructedKey)
    }

    fileprivate var constructedKey: String {
        "\(Constants.App.bundleIdentifier).UserDefaults.\(key.rawValue)"
    }

    fileprivate var staleStandardValueData: Data? {
        guard container == .standard else { return nil }
        return UserDefaults.standard.object(forKey: constructedKey) as? Data
    }
}
