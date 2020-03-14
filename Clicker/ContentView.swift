//
//  ContentView.swift
//  Clicker
//
//  Created by Tahminur Rahman on 3/12/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                headerValues()
                MyZoo()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//View that contains all the animals that were already bought
struct MyZoo:View{
    @EnvironmentObject var MyAnimals:Observable
    var body: some View{
        List{
            ForEach(self.MyAnimals.AnimalsBought, id: \.self){pet in
                AnimalInZoo(resident: pet)
            }
        }
    }
}
//Just the header structure with just the funds available and the shop
struct headerValues:View{
    @EnvironmentObject var Cash:Observable
    var body: some View{
        HStack{
            Text("Money: \(Cash.Money)")
            Spacer()
            NavigationLink(destination: Shop()) {
                Text("Shop")
            }
            .foregroundColor(Color(#colorLiteral(red: 0.9482626319, green: 0.5436439514, blue: 0.3307081163, alpha: 1)))
        }
                
    }
}



//Place to buy new animals
struct Shop:View{
    @EnvironmentObject var MyAnimals:Observable
    var body: some View{
        VStack{
            Text("Welcome to the shop")
            Text("Funds: $\(MyAnimals.Money)")
            List{
                ForEach(self.MyAnimals.AnimalsInShop, id: \.self){pet in
                    ProductInShop(product: pet)
                }
            }
        }
    }
}

struct ProductInShop:View{
    @EnvironmentObject var Cash:Observable
    
    @State var product:Animal
    
    var body:some View{
        HStack{
            Button(action: {
                self.Buy()
            }){
                Text(product.picture)
            }
            Text("Cost of animal is: \(product.cost)")
            Text("Generates $\(product.incrementVal) per second")
        }
    }
    //Buy works should make it so that it increments/adds the row to the list outside
    func Buy(){
        if(product.cost<=Cash.Money){
            if(Cash.AnimalsBought.contains(product) == false){
                Cash.Money = Cash.Money - product.cost
                Cash.AnimalsBought.append(product)
            }
            else{
                print("Already bought")
            }
        }
        else{
            print("Not enough funds \(Cash.Money)")
        }
    }
}
//A row for the bought animals in the main view, will generate income on a per second basis
struct AnimalInZoo:View{
    @State var resident:Animal
    @State var number = 1
    @EnvironmentObject var Cash:Observable
    var body: some View{
        HStack{
            Button(action: {self.Cash.Money = self.Cash.Money + self.resident.incrementVal*10}){
                Text(resident.picture)
            }.buttonStyle(BorderlessButtonStyle())
            Text("\(number)")
            Spacer()
            Button(action: {
                self.BuyAnother()
            }){
                Text("Buy Another for: \(resident.cost*number*2)?")
            }.buttonStyle(BorderlessButtonStyle())
        }
    
        
        
    }
    
    func BuyAnother(){
        if(resident.cost*number*2<=Cash.Money){
            number += 1
            Cash.Money -= resident.cost*number*2
        }
        else{
            print("insufficient funds")
        }
    }
}



