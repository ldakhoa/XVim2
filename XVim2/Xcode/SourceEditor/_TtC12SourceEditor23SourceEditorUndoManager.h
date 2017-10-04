//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSUndoManager.h>

@class NSString;

@interface _TtC12SourceEditor23SourceEditorUndoManager : NSUndoManager
{
    // Error parsing type: , name: undoStack
    // Error parsing type: , name: redoStack
    // Error parsing type: , name: pendingUndoOperations
    // Error parsing type: , name: pendingRedoOperations
    // Error parsing type: , name: needsTextualCoalesce
    // Error parsing type: , name: lastTextualOperationType
    // Error parsing type: , name: lastKnownInsertionPoint
    // Error parsing type: , name: postingCheckpoint
    // Error parsing type: , name: _undoGroupingLevel
    // Error parsing type: , name: _redoGroupingLevel
    // Error parsing type: , name: undoLevel
    // Error parsing type: , name: redoLevel
}

//- (CDUnknownBlockType).cxx_destruct;
- (void)beginUndoGrouping;
@property(nonatomic, readonly) BOOL canRedo;
@property(nonatomic, readonly) BOOL canUndo;
- (void)endUndoGrouping;
@property(nonatomic) NSInteger groupingLevel;
- (id)init;
- (BOOL)isRedoing;
- (BOOL)isUndoing;
- (id)prepareWithInvocationTarget:(id)arg1;
- (void)redo;
@property(nonatomic, readonly) BOOL redoActionIsDiscardable;
@property(nonatomic, readonly, copy) NSString *redoActionName;
- (void)registerUndoWithTarget:(id)arg1 selector:(SEL)arg2 object:(id)arg3;
- (void)registerUndoWithTitle:(id)arg1 redoTitle:(id)arg2 operation:(void(^)(void))arg3;
- (void)removeAllActions;
- (void)removeAllActionsWithTarget:(id)arg1;
- (void)setActionIsDiscardable:(BOOL)arg1;
- (void)setActionName:(id)arg1;
- (void)undo;
@property(nonatomic, readonly) BOOL undoActionIsDiscardable;
@property(nonatomic, readonly, copy) NSString *undoActionName;
- (void)undoNestedGroup;

// Remaining properties
@property(nonatomic, readonly, getter=isRedoing) BOOL redoing;
@property(nonatomic, readonly, getter=isUndoing) BOOL undoing;

@end

typedef _TtC12SourceEditor23SourceEditorUndoManager SourceEditorUndoManager;
