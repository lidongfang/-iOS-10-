//
//  firstClassController.swift
//  Duihao
//
//  Created by lidongfang on 2017/4/11.
//  Copyright © 2017年 lidongfang. All rights reserved.
//




// swift 基础有两大难点就是“可选值”相关知识 还有一个就是“闭包”相关知识


import UIKit

class firstClassController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white;
        // **********************************swift 函数的调用  eg
        setPersonMes(perAddress: "苏州", perName: "lidongfang");
        logPerMes();
        print("返回的数据\(getGasPrice())")
        print("\(containsCharacter(secondString: "f"))包含该f")
        print("计算1,2,3,4,5的平均数是\(changeableMeters(numbers: 1,2,3,4,5))")
//        print("含有可变参数的fun的返回值\(hasVarParameterFuntion())")
        var a = 3 ; var b = 7;
        swapTwoInts(a: &a,b: &b)
        print("a is now \(a), and b is now \(b)")
        
        
        
        
        
        
        
        
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
        // 可选型 类型后面加?    nil 不能用于非可选的常量和变量。如果代码中有常量或者变量需要处理值缺失的情况，把它们声明成对应的可选类型。 如果定义一个可选常量或变量没有提供默认值，它们会被自动设置为 nil,Swift 的 nil 和 Objective-C 的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针，它是一个确定的值，用来表示值的缺失。任何类型的可选都可以被设置为 nil，不只是对象类型   简而言之  可选类型声明一个变量时，默认情况是non-optional的，即必须对这个对象赋予一个非空的值，如果给non-optional类型的变量赋值nil，编辑器就会报错。
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
    
    // 定义函数的外部参数（这样我们在传递参数的时候能够很清晰的看出哪一个参数传递的值是什么），由于我们已经很明确的定义了局部参数，这时候只需在参数名前加“#”（如下#string），但是现在swift升级已经不能这样写了，郁闷，现在命名  firstStirng、secondString 为外部参数，同样可以给参数一个默认值 例如 string 的默认字符串 "defaultString" ，如果默认的参数没有传具体值，那么就是用默认值了
    func containsCharacter(firstStirng string:String = "defaultString",secondString findCharacter:Character) -> Bool {
        for chr in string.characters {
            if chr == findCharacter {
                return true;
            }
        }
        return  false;
    }
    
    // 可变参数  可变参数是怎么回事呢？当然就是参数可以变化的，不固定的，传入的参数的数量是不固定的，如果想说明这个参数是可变参数 那么在这个参数类型后面加上 ... eg :
    func changeableMeters(numbers : Int ...) -> Int {
        var total : Int = 0;
        
        for num in numbers {
            total += num;
        }
        return total/numbers.count;
    }
    
    // 在object_c中函数中的参数可以修改的，也就是说函数参数是可变的，在swift中函数的参数默认的是不变的，也就是swift中参数是let类型的，如果你想让参数变为可变的参数，那么你需要在参数前面加上var 修饰 ,马蒂，swift 又变化了，已经不允许这样写了 ，原来是这样写的 eg：
//    func hasVarParameterFuntion(var firstParameter : String ,secondString:String) -> String {
//        var firstParameter = firstParameter
//        return firstParameter = firstParameter+secondString;
//    }

    
    
    
    
//    正如上面所述：变量参数只能在函数体内被修改。如果需要一个函数可以修改参数值，并且这些修改在函数调用结束后仍然生效，那么就把这个参数定义为输入输出参数（In-Out Parameters）。
//    通过在参数类型前加 inout 关键字定义一个输入输出参数。输入输出参数值被传入函数，被函数修改，然后再被传出函数，原来的值将被替换。
//    
//    只能传入一个变量作为输入输出参数。不能传入常量或者字面量（literal value），因为这些值是不允许被修改的。当传入的实参作为输入输出参数时，需要在实参前加 & 符，表示这个值可以被函数修改
//    注意：输入输出参数不能有默认值，不能是可变参数。如果一个参数被 inout 标记，这个参数就不能被 var 或 let 标记。
//    函数 swapTwoInts 有两个分别叫做 a 和 b 的输出输出参数：
    func swapTwoInts( a: inout Int, b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
    // 闭包函数的写法
//    { (parameters) - > type in statement }  直接用sort函数排序
    
//    let names = ["lily","lucy","tom"];
//    
//    let numbersSorted = names.sort({ (n1:Int, n2: Int) -> Bool in
//        //进行从小到大的排序
//        return n2 > n1
//    })
    
    
    
    
}
