//
//  HelperClass.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 10/08/24.
//

import Foundation
import UIKit


// MARK: - Protocol definition
public protocol Reusable: AnyObject {
    /// The reuse identifier to use when registering and later dequeuing a reusable cell
    static var reuseIdentifier: String { get }
}

public typealias NibReusable = Reusable & NibLoadable

// MARK: - Default implementation

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


public protocol NibLoadable: AnyObject {
    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: UINib { get }
}

// MARK: - Default implementation
public extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: - Support for instantiation from NIB
public extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}


// MARK: Reusable support for UITableView & UICollectionView

public extension UICollectionView {
    /**
     Register a NIB-Based `UITableViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
     
     - parameter cellType: the `UITableViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)
     
     - parameter cellType: the `UITableViewCell` (`Reusable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UITableViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A `Reusable`, `UITableViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
}



// MARK: Reusable support for UITableView

public extension UITableView {
    /**
     Register a NIB-Based `UITableViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
     
     - parameter cellType: the `UITableViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)
     
     - parameter cellType: the `UITableViewCell` (`Reusable`-conforming) subclass to register
     
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UITableViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A `Reusable`, `UITableViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
    /**
     Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable` & `NibLoadable`)
     
     - parameter headerFooterViewType: the `UITableViewHeaderFooterView` (`Reusable` & `NibLoadable`-conforming)
     subclass to register
     
     - seealso: `register(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)
     
     - parameter headerFooterViewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register
     
     - seealso: `register(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable {
            self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
     
     - parameter viewType: The view class to dequeue
     
     - returns: A `Reusable`, `UITableViewHeaderFooterView` instance
     
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableHeaderFooterView(withIdentifier:)`
     */
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
        where T: Reusable {
            guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
                fatalError(
                    "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the header/footer beforehand"
                )
            }
            return view
    }
}
