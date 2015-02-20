#import "Specs.h"
#import "StreamItemPreviewViewController.h"
#import "StreamItemPreviewLayout.h"
#import "StreamItem.h"

SPEC_BEGIN(StreamItemPreviewViewControllerSpec)
describe(@"StreamItemPreviewViewController", ^{

    __block StreamItemPreviewViewController *streamItemPreviewViewController;

    beforeEach(^{
        streamItemPreviewViewController = [StreamItemPreviewViewController new];
    });

    afterEach(^{
        streamItemPreviewViewController = nil;
    });

    describe(@"when view is loaded", ^{

        __block UICollectionView *collectionView;

        beforeEach(^{
            collectionView = (UICollectionView *) streamItemPreviewViewController.view;
        });

        it(@"should be collection view", ^{
            expect(streamItemPreviewViewController.view).to.beKindOf([UICollectionView class]);
        });

        it(@"should have white background color", ^{
            expect(streamItemPreviewViewController.view.backgroundColor).to.equal([UIColor whiteColor]);
        });

        it(@"should have custom layout", ^{
            expect(collectionView.collectionViewLayout).to.beKindOf([StreamItemPreviewLayout class]);
        });

        it(@"should have paging enabled", ^{
            expect(collectionView.pagingEnabled).to.beTruthy();
        });

        it(@"should be horizontally scrollable", ^{
            StreamItemPreviewLayout *streamItemPreviewLayout = (StreamItemPreviewLayout *) collectionView.collectionViewLayout;
            expect(streamItemPreviewLayout.scrollDirection).to.equal(UICollectionViewScrollDirectionHorizontal);
        });

        it(@"should collection view have data source set to view controller", ^{
            expect(collectionView.dataSource).to.equal(streamItemPreviewViewController);
        });

    });

    context(@"when create with stream items", ^{
        __block NSArray *items;

        beforeEach(^{
            items = @[[StreamItem new] ];
            streamItemPreviewViewController = [[StreamItemPreviewViewController alloc] initWithStreamItems:items];
        });

        it(@"should set stream items", ^{
            expect(streamItemPreviewViewController.streamItems).to.equal(items);
        });

        //TODO 1: Write test which checks numberOfItemsInSection method of UICollectionViewDataSource

        //TODO 2: Write test which checks if for each item cell is created (method cellForItemAtIndexPath)

        //TODO 3: Write test which check setup of the cell, title and image

    });

});
SPEC_END