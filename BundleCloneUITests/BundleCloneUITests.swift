//
//  BundleCloneUITests.swift
//  BundleCloneUITests
//
//  Created by Altan on 12.11.2023.
//

import XCTest

final class BundleCloneUITests: XCTestCase {

    func testTechMenu() throws {
        let app = XCUIApplication()
        app.launch()
                
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let techSectionCell = app.tables.cells.containing(.staticText, identifier:"TECHNOLOGY").children(matching: .other).element(boundBy: 0)
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["TECHNOLOGY"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        
        techSectionCell.tap()
        XCTAssertTrue(techSectionCell.exists)
        
        XCTAssertTrue(collectionView.exists)
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
                                        
    }
    
    func testGamingMenu() throws {
        let app = XCUIApplication()
        app.launch()
                
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let gamingSectionCell = app.tables.cells.containing(.staticText, identifier:"GAMING & GEEK").children(matching: .other).element(boundBy: 0)
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["GAMING & GEEK"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        gamingSectionCell.tap()
        XCTAssertTrue(collectionView.exists)
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testPoliticsMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let politicsSectionCell = app.tables.cells.containing(.staticText, identifier:"POLITICS").children(matching: .other).element(boundBy: 0)
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["POLITICS"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        politicsSectionCell.tap()
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
                
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testBusinessMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        XCTAssertTrue(sideMenuButton.exists)
        let politicsSectionCell = app.tables.cells.containing(.staticText, identifier:"BUSINESS & FINANCE").children(matching: .other).element(boundBy: 0)
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["BUSSINESS & FINANCE"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        politicsSectionCell.tap()
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
                
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testFashionMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let politicsSectionCell = app.tables.cells.containing(.staticText, identifier:"FASHION").children(matching: .other).element(boundBy: 0)
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["FASHION"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        politicsSectionCell.tap()
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
                
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testScienceMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let tablesQuery = app.tables
        let tableView = tablesQuery.children(matching: .other).element(boundBy: 1)
        let scienceSectionCell = app.tables.staticTexts["SCIENCE"]
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["SCINCE"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
                
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        tableView.swipeUp()
        scienceSectionCell.tap()
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testSportsMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let tablesQuery = app.tables
        let tableView = tablesQuery.children(matching: .other).element(boundBy: 3)
        let sportsSectionCell = app.tables.staticTexts["SPORTS"]
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["SPORTS"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
                
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        tableView.swipeUp()
        sportsSectionCell.tap()
        
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testCinemaMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let tablesQuery = app.tables
        let tableView = tablesQuery.children(matching: .other).element(boundBy: 3)
        let cinemaSectionCell = app.tables.staticTexts["CINEMA"]
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["CINEMA"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        tableView.swipeUp()
        cinemaSectionCell.tap()
        
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testArtsMenu() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let tablesQuery = app.tables
        let tableView = tablesQuery.children(matching: .other).element(boundBy: 4)
        let artsSectionCell = app.tables.staticTexts["ARTS & CULTURE"]
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["ARTS & CULTURE"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        tableView.swipeUp()
        artsSectionCell.tap()
        
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testHomeScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let collectionView = app.collectionViews.firstMatch
        let firstCollectionViewCell = app.collectionViews.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["BundleClone.DetailsView"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
        
        firstCollectionViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
    }
    
    func testFeaturedScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let featuredTab = app.tabBars["Tab Bar"].buttons["list.bullet.rectangle.portrait"]
        let tablesQuery = app.tables
        let tableView = tablesQuery.cells.element(boundBy: 0)
        let backButton = app.navigationBars["BundleClone.DetailsView"].buttons["FEATURED"]
        let collectionView = tablesQuery.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        let detailViewController = app.otherElements["DetailsViewController"]
                
        featuredTab.tap()
        tableView.tap()
        
        XCTAssertTrue(detailViewController.exists)
        
        backButton.tap()
        collectionView.tap()
        
        XCTAssertTrue(detailViewController.exists)
    }
    
    func testContentStoreScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let contentStoreTab = app.tabBars["Tab Bar"].buttons["Search"]
        let searchField = app.navigationBars["CONTENT STORE"].searchFields["Search for News, Sources or Topics"]
        let collectionView = app.collectionViews.firstMatch
        
        contentStoreTab.tap()
        searchField.tap()
        searchField.typeText("science")
        
        XCTAssertTrue(collectionView.exists, "CollectionView is not present on the new page")
    }
    
    func testNotificationScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let notificationsTab = app.tabBars["Tab Bar"].buttons["notifications"]
        let tableView = app.tables.firstMatch
        let firstTableViewCell = app.tables.cells.element(boundBy: 0)
        let detailViewController = app.otherElements["DetailsViewController"]
        let websideButton = app.navigationBars["BundleClone.DetailsView"]/*@START_MENU_TOKEN@*/.buttons["Web"]/*[[".segmentedControls.buttons[\"Web\"]",".buttons[\"Web\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let webViewViewController = app.otherElements["WebViewViewController"]
        
        notificationsTab.tap()
        XCTAssertTrue(tableView.exists, "TableView is not present on the new page")
        
        firstTableViewCell.tap()
        XCTAssertTrue(detailViewController.exists)
        
        websideButton.tap()
        XCTAssertTrue(webViewViewController.exists)
        
    }
    
    func testSettingsScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sideMenuButton = app.navigationBars["NEWS"].buttons["List"]
        let settingsButton = app.tables.buttons["Settings"]
        let settingsViewConttroller = app.otherElements["SettingsViewController"]
        
        sideMenuButton.tap()
        XCTAssertTrue(sideMenuButton.exists)
        settingsButton.tap()
        XCTAssertTrue(settingsButton.exists)
        
        XCTAssertTrue(settingsViewConttroller.exists)
    }
}
