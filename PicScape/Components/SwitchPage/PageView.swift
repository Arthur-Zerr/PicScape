/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    var model: Picture_Component_Model
    @State var currentPage = 0

    init(_ views: [Page], pictureModel: Picture_Component_Model) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self.model = pictureModel
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([Picture_Component(pictureData: PicScapeData[1], ShowInfo: false), Picture_Component(pictureData: PicScapeData[1], ShowInfo: true)], pictureModel: PicScapeData[1])
    }
}
