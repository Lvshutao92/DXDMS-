//
//  SwiftViewController.swift
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var dataArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    var tableview = UITableView()
    var page = NSInteger()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "66666"
        self.view.backgroundColor = UIColor.init(red: 99, green: 99, blue: 99, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("您好")
        }
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableview)
        
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        tableview.tableFooterView = footView
        
//        self.setupRefresh()
    
        self.lodpost()
        
        
        
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您确定要离开hangge.com吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let model:PaiDanModel = self.dataArry.object(at: indexPath.row) as! PaiDanModel
//        cell.textLabel?.text = model.card_model.realName + model.card_model.positionName
//        cell.textLabel?.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let second = Swift_second_controller()
        second.navigationItem.title = "second"
        self.navigationController?.pushViewController(second, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func lodpost() {
        let dic:NSDictionary = ["":""]
        let str = AFNPostTools.shared.KURLNSString(str: "product/productseries/page?currentPage=1&pageSize=10&sortName=id&sortType=desc")
        AFNPostTools.shared.postWithPath(path: str as String, paras: dic as! Dictionary<String, Any>, success: { (data) in
            print(data)
        }) { (error) in
            print(error)
        }
    }
    
    
    
    
    func setupRefresh(){
        weak var weakSelf = self
        self.tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            weakSelf?.lodA()
        })
        self.tableview.mj_header.beginRefreshing()
        self.tableview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            weakSelf?.lodB()
        })
    }
    func lodA() {
        self.tableview.mj_footer.endRefreshing()
        weak var weakSelf = self
        page = 1
        let dic = ["businessId":Manager.redingwenjianming("bianhao.text"),
                   "personId":Manager.redingwenjianming("id.text"),
                   "page":String(page)]
        NetWorkTools.shared.request(requestType: .POST, urlString: NetWorkTools.shared.KURLNSString(str: "servlet/salary/mysalary/detailhtm") as String, parameters: dic as [String : AnyObject]) { (json) in
            let dct = json as! NSDictionary
            
            weakSelf?.dataArry.removeAllObjects()
            print(dct)
//            let arr = (dct["cardResultList"]! as! NSArray).mutableCopy() as! NSMutableArray
//            for i in 0..<arr.count {
//                let dic = arr.object(at: i)
//                let model  = PaiDanModel.mj_object(withKeyValues: dic) as PaiDanModel
//                let model1 = PaidanModel1.mj_object(withKeyValues: model.card) as PaidanModel1
//                model.card_model = model1
//                weakSelf?.dataArry.add(model)
//            }
            weakSelf?.page = 2
            weakSelf?.tableview.reloadData()
            weakSelf?.tableview.mj_header.endRefreshing()
        }
    }
    func lodB() {
        self.tableview.mj_header.endRefreshing()
        weak var weakSelf = self
        let dic = ["businessId":Manager.redingwenjianming("bianhao.text"),
                   "personId":Manager.redingwenjianming("id.text"),
                   "page":String(page)]
        NetWorkTools.shared.request(requestType: .POST, urlString: NetWorkTools.shared.KURLNSString(str: "servlet/salary/mysalary/detailhtm") as String, parameters: dic as [String : AnyObject]) { (json) in
//            let dct = json as! NSDictionary
//
//            let arr = (dct["cardResultList"]! as! NSArray).mutableCopy() as! NSMutableArray
//            for i in 0..<arr.count {
//                let dic = arr.object(at: i)
//                let model  = PaiDanModel.mj_object(withKeyValues: dic) as PaiDanModel
//                let model1 = PaidanModel1.mj_object(withKeyValues: model.card) as PaidanModel1
//                model.card_model = model1
//                weakSelf?.dataArry.add(model)
//            }
            weakSelf?.page += 1
            weakSelf?.tableview.reloadData()
            weakSelf?.tableview.mj_footer.endRefreshing()
        }
    }
    

}



/*
 *
 *MARK:second controller
 *
 */
class Swift_second_controller: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(SecondCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SecondCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SecondCell
        cell.img.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        cell.img.image = UIImage.init(named: "国内-1")
        return cell
    }
}
/*
 *
 *MARK:second cell
 *
 */
class SecondCell: UITableViewCell {
    let img = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
    override func `self`() -> Self {
        contentView.addSubview(img)
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(img)
    }
}

/*
 *
 *MARK:second model
 *
 */
class SwiftModel: NSObject {
    let key = String()
    let value = String()
}






//发送通知
//let dic = NSDictionary()
//let notification = Notification.init(name: Notification.Name(rawValue: "hiddenlogin"), object: nil, userInfo: dic as? [AnyHashable : Any])
//NotificationCenter.default.post(notification)

//接收通知
//NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: "hiddenlogin"), object: nil)

//通知后方法
//@objc func notificationAction(){
//
//}

