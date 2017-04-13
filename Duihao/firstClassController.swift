//
//  firstClassController.swift
//  Duihao
//
//  Created by lidongfang on 2017/4/11.
//  Copyright © 2017年 lidongfang. All rights reserved.
//

import UIKit

class firstClassController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPersonMes(perAddress: "苏州", perName: "lidongfang");
        logPerMes();
        print("返回的数据\(getGasPrice())")
        // ************ swift ***********/
        let constanceFloat : Float = 90;
        let with  = "体重是";
        let personMES : String  = with + String(constanceFloat)+"kg";
        print(personMES);
        
        // 常见数组和字典
        var arr = ["ni","hao","ma"];
        var dic = ["name":"lily","weith":"90"];
        dic ["age"] = "5";
        var emptyArr = Array<String>();
        var emptyA = [String]();
        
        var emptyDic = Dictionary<String,Float>();
        emptyArr .append("shopping");
        emptyArr .append("is happy");
        emptyDic .updateValue(12, forKey: "age");
        arr .append(contentsOf: emptyArr)
        emptyA.append(contentsOf: emptyArr);
        print(arr);
        print(dic);
        print(emptyArr);
        print(emptyDic);
        // 可选型 类型后面加?    nil 不能用于非可选的常量和变量。如果代码中有常量或者变量需要处理值缺失的情况，把它们声明成对应的可选类型。 如果定义一个可选常量或变量没有提供默认值，它们会被自动设置为 nil,Swift 的 nil 和 Objective-C 的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针，它是一个确定的值，用来表示值的缺失。任何类型的可选都可以被设置为 nil，不只是对象类型
        var optionString : String? = "lucy";
        optionString = nil;
        if optionString != nil {
            optionString = "kitty";
        }else{
            print("option value is nil");
        }
        
        // switch 运行到每个case 自动跳出break
        let vegatable = "pepper";
        switch vegatable {
        case "pepper":
            print("this vegatable is \(vegatable)");
        default:
            print("dont know!");
        }
        // for in 遍历
        let interstingsNumbers=[
            "first":[1,3,4,5],
            "second":[7,9,0],
            "third" :[12,45,78]
        ];
        var largest = 0;
        for (_,numbers) in interstingsNumbers {
            for num in numbers {
                if num>largest {
                    largest=num;
                    print("the largest is \(largest)");
                }
            }
        }
        // while 语句
        while largest>45{
            print("has find the largest number!!!")
            break;
        }
        // for in .. 表示区间 也可以用传统的
        var sumNum = 0;
        
        for i in 0 ..< 10 {
            sumNum+=i;
        }
        print("the sum numbers is \(sumNum)")
        // 泛型  在< >中创建一个名字来创建一个泛型函数或者一个类型
        print(repeatFun(item: "sh", times: 5));
        
        // 如果用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值（if判断一下）
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    var address:String!;
    var name : String! ;
    func setPersonMes(perAddress:String?,perName:String?) {
        self.address=perAddress;
        self.name=perName;
    }

    func logPerMes() {
        print("person name is \(self.name) address is \(self.address)")
    }
    
    func getGasPrice() -> ([Int],Int,Double) {
        return ([12,34],56,78);
    }
    
    //泛型  在< >中创建一个名字来创建一个泛型函数或者一个类型
    func repeatFun<itemType>(item : itemType,times:Int) -> [itemType] {
        var result = [itemType]();
        for _ in 0..<times {
            result .append(item);
        }
        return result;
    }
}
