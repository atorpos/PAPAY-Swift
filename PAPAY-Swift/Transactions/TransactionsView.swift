//
//  TransactionsView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/24/21.
//

import SwiftUI

struct TransactionsView: View {
    @State private var showingPopover = false
    @State private var showingAlert = false
    @State private var showingtransaction = false
    @State var stateVariable = ""
    @State var transation_data = ""
    @State var transaction_count = 0
    @State var transaction_date: [String] = []
    @State var transaction_amount: [String] = []
    @State var transaction_currency: [String] = []
    @State var transaction_request_ref: [String] = []
    @State var transaction_channel: [String] = []
    @State var transaction_type: [String] = []
    @State var transaction_status: [Int] = []
//    @State var transaction_date;[String] = []
    var body: some View {
//        if(self.gettranactions()){
//
//        }
        NavigationView {
            if(transaction_count == 0) {
                Text("No Transaction")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
            } else {
                List {
                    ForEach(0..<Int(transaction_count)) { each in
                        NavigationLink(destination: TransactionDetailsView(Request_reference: transaction_request_ref[each])) {
                            ZStack {
                                HStack(alignment: .center, spacing: 0){
                                    Image("\(transaction_channel[each])_t")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding(10)
                                    VStack(alignment: .leading, spacing: 6) {
                                        if(transaction_type[each] == "Refund") {
                                            Text("-\(transaction_currency[each])  $\(transaction_amount[each]) Refund")
                                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                                .foregroundColor(.red)
                                                .lineLimit(1)
                                        }else {
                                            Text("\(transaction_currency[each])  $\(transaction_amount[each])")
                                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                                .lineLimit(1)
                                        }
                                        Text("\(transaction_date[each])")
                                            .font(.system(size: 13, weight: .ultraLight, design: .monospaced))
                                        Text("\(transaction_request_ref[each])")
                                            .font(.system(size: 11, weight: .ultraLight, design: .monospaced))
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                    if(transaction_status[each] == 1){
                                        Image(systemName: "checkmark.circle")
                                            .font(.system(size: 40, weight: .semibold))
                                            .foregroundColor(.green)
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } else {
                                        Image(systemName: "multiply.circle")
                                            .font(.system(size: 40, weight: .semibold))
                                            .foregroundColor(.red)
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                
                            }
                        }
                       
                    }
                }
                .searchable(text: $stateVariable)
                .listStyle(.plain)
                .navigationTitle("Transactions")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: TransactionSearchView()){
                            Image(systemName: "magnifyingglass.circle")
                                .scaledToFit()
                        }
                    }
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: gettranactions)
    }
    
    var custableview: some View {
        ZStack {
            Text("testing")
        }
    }
    
    func gettranactions() -> Void {
        let connect_model = PapayTransactions()
        transation_data = connect_model.infopapay()
        let responsedata = Data(transation_data.utf8)
        let decoder = JSONDecoder()
//        if let ser_response = try? decoder.decode(ServerResponse.self, from: responsedata) {
//            print("checkout \(ser_response.response)")
//        } else {
//            print("error")
//        }
        do {
            let ser_response = try decoder.decode(TransactionsResponse.self, from: responsedata)
            print("checkout \(String(describing: ser_response.response.message))")
            print("array \(ser_response.payload.transactions.count)")
            transaction_count = ser_response.payload.transactions.count
            for transaction_detail in ser_response.payload.transactions {
                print("\(transaction_detail.created_time)")
                let number_format = String(format: "%.2f", (transaction_detail.order_amount as NSString).doubleValue)
                let date = Date(timeIntervalSince1970: (transaction_detail.created_time as NSString).doubleValue)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "HKT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                self.transaction_date.append(strDate)
                self.transaction_status.append(Int(transaction_detail.status)!)
                self.transaction_type.append(transaction_detail.type)
                self.transaction_amount.append(number_format)
                self.transaction_channel.append(transaction_detail.provider)
                self.transaction_currency.append(transaction_detail.order_currency)
                self.transaction_request_ref.append(transaction_detail.request_reference)
            }
//
//            self.transaction_date.append(ser_response.payload.transactions.)
        } catch {
            print("testing error")
            print(error.localizedDescription)
            print(String(describing: error))
        }
//        return transation_data
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
