#import "Specs.h"

#import "AgendaViewController.h"
#import "AgendaProvider.h"
#import "AgendaTableViewCell.h"
#import "FakeTableView.h"
#import "FakeAgendaProvider.h"
#import "AgendaItemFixture.h"


SPEC_BEGIN(AgendaViewController)

describe(@"AgendaViewController", ^{
    __block AgendaViewController *viewController;
    
    beforeEach(^{
        viewController = [[AgendaViewController alloc] init];
    });

    describe(@"object setup", ^{
        it(@"should have instance of an AgnedaProvider", ^{
            expect(viewController.agendaProvider).to.beKindOf([AgendaProvider class]);
        });
    });
    
    describe(@"title", ^{
        it(@"should be set to 'Agenda'", ^{
            expect(viewController.title).to.equal(@"Agenda");
        });
    });
    
    describe(@"tab bar item", ^{
        it(@"should have a agenda image", ^{
            expect(viewController.tabBarItem.selectedImage).to.equal([UIImage imageNamed:@"agenda.png"]);
        });
        
        it(@"should have a 'Agenda' title", ^{
            expect(viewController.tabBarItem.title).to.equal(@"Agenda");
        });
    });
    
    describe(@"view loads", ^{
        __block FakeAgendaProvider *fakeAgendaProvider;

        beforeEach(^{
            //Arrange
            fakeAgendaProvider = [FakeAgendaProvider new];
            viewController.agendaProvider = (id)fakeAgendaProvider;
        });

        it(@"should reload agenda", ^{
            // Act
                        viewController.view;

            // Assert
            expect(fakeAgendaProvider.reloadAgendaCalled).to.beTruthy();
        });
        
        context(@"when agenda reloading completes", ^{
            __block UITableView *tableViewMock;
            beforeEach(^{
                // Arrange
                tableViewMock = mock([UITableView class]);
                viewController.view = tableViewMock;
            });

            it(@"should reload table view", ^{
                // Act (viewDidLoad)
                [viewController viewDidLoad];

                // Simulate
                [fakeAgendaProvider simulateSuccessWithItems:@[]];

                [verify(tableViewMock) reloadData];
            });
        });
    });

    describe(@"table view", ^{
        __block UITableView *tableView;
        __block FakeAgendaProvider *fakeAgendaProvider;
        beforeEach(^{
            tableView = viewController.tableView;

            fakeAgendaProvider = [FakeAgendaProvider new];
            viewController.agendaProvider = (id)fakeAgendaProvider;
        });

        it(@"should have 1 section", ^{
            NSInteger numberOfSections = [viewController.tableView numberOfSections];
            expect(numberOfSections).to.equal(1);
        });

        context(@"when there is no items", ^{
            beforeEach(^{
                fakeAgendaProvider.agendaItems = @[];
            });

            it(@"should have 0 rows", ^{
                expect([tableView.dataSource tableView:tableView numberOfRowsInSection:0]).to.equal(0);
            });
        });

        context(@"when there are 2 items", ^{
            beforeEach(^{
                fakeAgendaProvider.agendaItems = @[[AgendaItem new], [AgendaItem new]];
            });

            it(@"should have 2 items for first section", ^{
                expect([tableView.dataSource tableView:tableView numberOfRowsInSection:0]).to.equal(2);
            });
        });

        it(@"should return cell for each item", ^{
            for (int i = 0; i < 2; ++i) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                AgendaTableViewCell *cell = (AgendaTableViewCell *)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
                expect(cell).to.beInstanceOf([AgendaTableViewCell class]);
            }
        });

        context(@"cell setup", ^{
            beforeEach(^{
                //Arrange
                AgendaItemFixture *agendaItemFixture = [AgendaItemFixture new];
                fakeAgendaProvider.agendaItems = @[agendaItemFixture];
            });

            it(@"should setup cell with AgendaItem properties", ^{
                //Act
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                AgendaTableViewCell *cell = (AgendaTableViewCell *)[tableView.dataSource tableView:tableView
                                                                             cellForRowAtIndexPath:indexPath];


                //Assert
                expect(cell.textLabel.text).to.equal(@"Spec Session");
            });
        });
    });

    afterEach(^{
        viewController = nil;
    });
});

SPEC_END
