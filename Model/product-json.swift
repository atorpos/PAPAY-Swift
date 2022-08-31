//
//  product-json.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/15/22.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let body_html: String
    let vendor: String
    let product_type: String
    let create_at: String
    let handle: String
    let status: String
    let tags: String
    let variants: [String: Variants]
    let options: [String: Options]
    let images: [String: Images]
}

struct Variants: Codable {
    let v_id: Int
    let v_productid: Int
    let v_title: String
    let v_price: Double
    let v_sku: String
    let v_position: Int
    let v_grams: Double
    let v_grams_unit: String
    let v_inventory_item_id: Int
    let v_inventory_quantity: Int
    let v_requires_shipping: Bool
}

struct Options: Codable {
    
}

struct Images: Codable {
    let i_id: Int
    let i_productid: Int
    let i_position: Int
    let i_created_at: String
    let i_updated_at: String
    let i_alt: String
    let i_width: Int
    let i_height: Int
    let i_src: String
}

struct sp_Entry: Codable {
    let products: [String: Product]
}
