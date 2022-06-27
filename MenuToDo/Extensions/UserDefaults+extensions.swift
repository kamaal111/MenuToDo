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
struct UserDefaultObject<Value: Codable>: UserDefaultable {
    let key: Keys
    let container: UserDefaults?

    init(key: Keys, container: UserDefaults? = .standard) {
        self.key = key
        self.container = container
    }

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

private protocol UserDefaultable {
    associatedtype Keys: RawRepresentable where Keys.RawValue == String

    var key: Keys { get }
    var container: UserDefaults? { get }
}

extension UserDefaultable {
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
