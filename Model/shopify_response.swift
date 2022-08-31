//
//  shopify_response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 8/2/22.
//

import Foundation

struct shopify_response: Codable {
    let products: [Let_products]
}
struct Let_products:Codable {
    let id: Int
    let title: String
    let body_html:String
    let vendor: String
    let product_type: String
    let variants:[Let_variants]
    let options:[Shop_option]
    let images:[Shop_image]
    let image:Shop_image
}
struct Let_variants: Codable{
    let id: Int
    let product_id: Int
    let title: String
    let price: String
    let sku: String
    let option1: String
    let option2: String?
    let option3: String?
    let barcode: String?
    let grams: Int?
    let weight: Double?
    let weight_unit: String?
    let inventory_item_id: Int?
    let inventory_quantity: Int?
    
}


struct Products: Codable {
    let id: Int
    let title: String
    let body_html: String
    let vendor: String
    let product_type: String
    let created_at: String
    let handle: String
    let updated_at: String
    let published_at: String
    let tags: String
    let variants:[Variant]
    let options: [Shop_option]
    let images: [Shop_image]
}

struct Variant: Codable {
    let id: Int
    let product_id: Int
    let title: String
    let price: String
    let sku: String
    let position: String
    let inventory_policy: String
    let inventory_managment: String
    let option1: String
    let option2: String
    let option3: String
    let barcode: String
    let grams: String
    let weight: String
    let weight_unit: String
    let inventory_item_id: String
    let inventory_quantity: String
    let presentment_prices:[String]
    let requires_shipping: String
}

struct Shop_option: Codable {
    let id: Int
    let product_id: Int
    let name: String
    let position: Int
    let values: [String]
}

struct Shop_image: Codable {
    let id: Int
    let product_id: Int
    let position: Int
    let alt: String?
    let width: Int
    let height: Int
    let src: String
    let variant_ids: [String]
    
}
