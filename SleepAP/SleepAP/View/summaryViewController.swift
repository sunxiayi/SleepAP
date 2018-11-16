//
//  summaryViewController.swift
//  SleepAP
//
//  Created by Chunyang Zhu on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Charts
import Parse

private let summaryLabelColor : UIColor = .black

class summaryViewController: recordSummaryParentViewController {

    @IBOutlet var daysLineChartView: LineChartView!
    @IBOutlet var weeksLineChartView: LineChartView!
    @IBOutlet var daysButton: UIButton!
    @IBOutlet var weeksButton: UIButton!
    
    // connect to the database to get the weekly data
    let Hours = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0]
    let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]

    // Based on average week points calculation
    var weeklyHours = [1.0]
    var weeklyPoints = [1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.title = "Summary"

//        let Days = [1]
//        let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
        
        setDaysChart(dataPoints: Hours, values: Points)
        setWeeksChart(dataPoints: Hours, values: Points)
        //setUpPieChart()
        daysButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        weeksButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)


        // Get data from backend
        var query = PFQuery(className:"SleepHour")
        query.whereKey("objectID", equalTo:"MDelt7QayZ")
        query.findObjectsInBackground {
            (objects, error) -> Void in

            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    print(objects[0])
                }
            } else {
                // Log details of the failure
                print("failed")
            }
        }
        
        //setChart(dataPoints: Days, values: Points)
    }
    
//    func setUpPieChart() {
//        pieChartView.chartDescription?.enabled = false
//        pieChartView.drawHoleEnabled = false
//        pieChartView.rotationAngle = 0
//        pieChartView.rotationEnabled = false
//        pieChartView.isUserInteractionEnabled = false
//
//        let color1 = NSUIColor(hex: 0x000000)
//        let color2 = NSUIColor(hex: 0xFFFFFF)
//
//        var entries : [PieChartDataEntry] = []
//        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep1"))
//        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep2"))
//
//        let dataSet = PieChartDataSet(values: entries, label: "")
//
//        dataSet.colors = [color1, color2]
//        dataSet.drawValuesEnabled = false
//
//        pieChartView.data = PieChartData(dataSet: dataSet)
//    }
    
//    func setChart(dataPoints: [String], values: [Double]){
//        setChart(dataPoints: Hours, values: Points)
//        setWeeksChar(dataPoints: weeklyHours, values: weeklyPoints)
//        setLabel()
//    }
    
//    func setLabel(){
//        var pos = 0;
//        //find the maxium point of in current week
//        if (Hours.isEmpty){
//
////            recomend.text! = "Recommendations"
////            recommendtext.text! = "Sleep time: " + "8.0"  + "  hours"
//        }
//        else{
//            let points = daysLineChartView.leftAxis.axisMaximum;
//            for (index, element) in Points.enumerated(){
//                if element - points < 0.001{
//                    pos = index
//                }
//            }
//            let str = String(Hours[pos]);
////            recomend.text! = "Recommendations"
////            recommendtext.text! = "Sleep time: " + str + "  hours"
//        }
//    }

    func setDaysChart(dataPoints: [Double], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(values:dataEntries,label:"Points")
        
        let data = LineChartData()
        data.addDataSet(line1)
        daysLineChartView.data = data;
        daysLineChartView.chartDescription?.text = "Days"
        daysLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
    }
    
    func setWeeksChart(dataPoints:[Double],values:[Double]){
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let line1 = LineChartDataSet(values:dataEntries,label:"Points")
        let data = LineChartData()
        data.addDataSet(line1)
        weeksLineChartView.data = data
        weeksLineChartView.chartDescription?.text = "Hours"
        weeksLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        weeksLineChartView.isHidden = true
        
        weeksLineChartView.xAxis.axisMaximum = 12.0
        weeksLineChartView.leftAxis.axisMaximum = 10.0
        weeksLineChartView.xAxis.axisMinimum = 0
        weeksLineChartView.leftAxis.axisMinimum = 0
    }
    
    @IBAction func daysButton(_ sender: UIButton) {
        daysLineChartView.isHidden = false
        weeksLineChartView.isHidden = true
        
    }
    
    @IBAction func weeksButton(_ sender: UIButton) {
        daysLineChartView.isHidden = true
        weeksLineChartView.isHidden = false
    }
}
