//
//  TDD Workshop
//
//  Created by Lukasz Warchol on 22/04/14.
//  Copyright (c) 2014 Mobile Warsaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AgendaProvider;
@class AgendaCollectionViewDataSource;


@interface AgendaViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) AgendaCollectionViewDataSource *agendaDataSource;

@end
