//
//  ContentView.swift
//  Clip
//
//  Created by Oskar Wong on 6/13/22.
//

import SwiftUI
import CoreMedia

struct ContentView: View {
    let catlog = [
        "genora","espresso","bluebottles","icecoffee","lamazcco","lousanna"
    ]
    @State var product_items = []
    @State var product_array_no = 0
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Hello, world!")
                        .padding()
                    Text(gettoken())
                    Text("Total items \(product_items.count)")
//                    Text(get_productlist())
                    
                }
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0...product_array_no, id: \.self){ no_of_item in
                            NavigationLink{
                                ItemDetailsView(words: catlog[no_of_item])
                            } label: {
                                ZStack {
                                    Image(catlog[no_of_item])
                                        .aspectRatio(contentMode: .fit)
//                                    Text(catlog[no_of_item])
                                }
                                .frame(width: 200, height: 250)
                                .cornerRadius(20)
//                                Color.orange.frame(width: 200, height: 250)
                                
                            }
                        }
                    }
                }
                Spacer()
                Text("Pay now")
                Spacer()
            }
            .navigationTitle("Payment Asia")
            .onAppear(perform: get_array)
//            .onAppear(perform: fetchData{(dict, error) in
//                print(dict)
//            })
        }
        
    }
    func get_array() {
        let decoder = JSONDecoder()
        let get_shop_response = get_productlist()
       
        
        let json_resulst = get_shop_response.data(using: .utf8)!
        do {
            let ser_response = try decoder.decode(shopify_response.self, from: json_resulst)
            for items in ser_response.products {
                let product_item = [shopify_items(title: items.title, img_src: items.image.src, descriptions: items.body_html)]
                product_items.append(product_item)
            }
        } catch {
            print(String(describing: error))
        }
        product_array_no = product_items.count - 1
        print("product array \(product_items[0])")
    }
}

func gettoken() -> String {
    let appgroup:String = "group.com.paymentasia.papayswift"
    let testStr: String! = UserDefaults(suiteName: appgroup)?.string(forKey: "qrcode") ?? ""
    
    return testStr ?? "no token"
}

func get_productlist()->String {
    let decoder = JSONDecoder()
    let shop_connect = ShopifyConnection()
    let get_result = shop_connect.connect_shopify()

    let json_result = get_result.data(using: .utf8)!
    do {
        let ser_response = try decoder.decode(shopify_response.self, from: json_result)
//        print("get result \(ser_response.products)")
        for items in ser_response.products {
            print(items.title)
        }
        
    } catch {
        print(String(describing: error))
    }
    return get_result
}

func fetchData(completion: @escaping(NSDictionary?, Error?) ->Void) {
//    let decoder = JSONDecoder()
    var request = URLRequest(url: URL(string: "https://vigorgems.myshopify.com/admin/api/2022-07/products.json")!,timeoutInterval: Double.infinity)
    request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")

    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
        guard let data = data else {return}
        
        do {
            
//            if let decode_value:[String: Any]? = try JSONDecoder().decode(sp_Entry.self, from: data) {
//                completion(decode_value, nil)
//            }
//            print(data)
//            let ser_response = try decoder.decode(shopify_response.self, from: data)
//                print("print \(ser_response)")
            
            
            if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary{
                completion(array, nil)
            }
        }catch {
            print(error)
            completion(nil, error)
            
        }
    }
    task.resume()
    
}
func fetchJson() {
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
