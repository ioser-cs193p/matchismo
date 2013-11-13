//
//  MatchismoTests.m
//  MatchismoTests
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"
#import "PlayingCard.h"

@interface MatchismoTests : XCTestCase

@end

@implementation MatchismoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
	PlayingCard *H8 = [PlayingCard newWithSuit:@"♥" andRank:8];
	PlayingCard *H9 = [PlayingCard newWithSuit:@"♥" andRank:9];
	PlayingCard *H10 = [PlayingCard newWithSuit:@"♥" andRank:10];
	PlayingCard *H11 = [PlayingCard newWithSuit:@"♥" andRank:11];
	PlayingCard *H12 = [PlayingCard newWithSuit:@"♥" andRank:12];
	
	PlayingCard *C7 = [PlayingCard newWithSuit:@"♣" andRank:7];
	PlayingCard *C8 = [PlayingCard newWithSuit:@"♣" andRank:8];
	PlayingCard *C9 = [PlayingCard newWithSuit:@"♣" andRank:9];
	PlayingCard *C10 = [PlayingCard newWithSuit:@"♣" andRank:10];
	PlayingCard *C11 = [PlayingCard newWithSuit:@"♣" andRank:11];
	PlayingCard *C12 = [PlayingCard newWithSuit:@"♣" andRank:12];

	PlayingCard *D7 = [PlayingCard newWithSuit:@"♦" andRank:7];
	PlayingCard *D8 = [PlayingCard newWithSuit:@"♦" andRank:8];
	PlayingCard *D9 = [PlayingCard newWithSuit:@"♦" andRank:9];
	PlayingCard *D10 = [PlayingCard newWithSuit:@"♦" andRank:10];
	PlayingCard *D11 = [PlayingCard newWithSuit:@"♦" andRank:11];
	PlayingCard *D12 = [PlayingCard newWithSuit:@"♦" andRank:12];
	
	PlayingCard *S9 = [PlayingCard newWithSuit:@"♠" andRank:9];

	NSArray *cardList = @[C8, C9, C10, H11, H12];
	int firstScore = [PlayingCard match:cardList numberOfRequiredMatches:2];
	NSLog(@"First score: %d for cards %@", firstScore, cardList);
	
	cardList = @[H12, H11, C10, C9, C8];
	int secondScore = [PlayingCard match:cardList numberOfRequiredMatches:2];
	NSLog(@"Second score: %d for cards %@", secondScore, cardList);
	
	XCTAssertTrue(firstScore == secondScore, @"Order failure.");
	
	//
	//
	//
	
	cardList = @[C10, H11, C11, H12];
	firstScore = [PlayingCard match:cardList numberOfRequiredMatches:2];
	NSLog(@"First score: %d for cards %@", firstScore, cardList);
	
	cardList = @[H12, C11, H11, C10];
	secondScore = [PlayingCard match:cardList numberOfRequiredMatches:2];
	NSLog(@"Second score: %d for cards %@", secondScore, cardList);
	
	XCTAssertTrue(firstScore == secondScore, @"Order failure.");
	
	//
	// Check predicted scores.
	//
	
	cardList = @[C7, C8, C9, C10, C11, C12];
	int score = [PlayingCard match:cardList numberOfRequiredMatches:2];
	NSLog(@"Score: %d for cards %@", score, cardList);
	XCTAssertTrue(score == 55, @"Score should have been 30 but was %d", score);
	
	cardList = @[H9, C9, C10, C11, C12];
	score = [PlayingCard match:cardList numberOfRequiredMatches:6];
	NSLog(@"Score: %d for cards %@", score, cardList);
	XCTAssertTrue(score == 26, @"Score should have been 17 but was %d", score);
	
	cardList = @[H9, C9, C10, C11, C12];
	score = [PlayingCard match:cardList numberOfRequiredMatches:8];
	NSLog(@"Score: %d for cards %@", score, cardList);
	XCTAssertTrue(score == 0, @"Score should have been 0 but was %d", score);
	
	cardList = @[H9, C9, D9, S9];
	score = [PlayingCard match:cardList numberOfRequiredMatches:1];
	NSLog(@"Score: %d for cards %@", score, cardList);
	XCTAssertTrue(score == 67, @"Score should have been 67 but was %d", score);
	
	cardList = @[S9, D9, C9, H9];
	score = [PlayingCard match:cardList numberOfRequiredMatches:1];
	NSLog(@"Score: %d for cards %@", score, cardList);
	XCTAssertTrue(score == 67, @"Score should have been 67 but was %d", score);
	
}

@end
