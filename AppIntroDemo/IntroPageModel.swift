
import Foundation

class IntroPageModel {
    private (set) var title: String!
    private (set) var subtitle: String!
    private (set) var topImageName: String!
    private (set) var backgroundImageName: String!
    
    public class func pageModel(title: String!, subtitle: String!, topImageName: String!, backgroundImageName: String!) -> IntroPageModel {
        let pageModel = IntroPageModel()
        pageModel.title = title
        pageModel.subtitle = subtitle
        pageModel.topImageName = topImageName
        pageModel.backgroundImageName = backgroundImageName
        return pageModel
    }
    
}
