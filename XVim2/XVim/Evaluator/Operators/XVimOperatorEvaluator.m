//
//  XVimOperatorEvaluator.m
//  XVim
//
//  Created by Shuichiro Suzuki on 3/18/12.
//  Copyright (c) 2012 JugglerShu.Net. All rights reserved.
//

#import "XVimOperatorEvaluator.h"
#import "Logger.h"
#import "SourceEditorViewProtocol.h"
#import "XVim.h"
#import "XVimKeyStroke.h"
#import "XVimKeymapProvider.h"
#import "XVimMarks.h"
#import "XVimTextObjectEvaluator.h"
#import "XVimWindow.h"
#import "XVim2-Swift.h"

@interface XVimOperatorEvaluator () {
}
@end

// TODO: Maybe need to override b,B,w,W operation (See older implementation)

@implementation XVimOperatorEvaluator

+ (XVimEvaluator*)doOperationWithMotion:(XVimMotion*)motion onView:(NSTextView*)view { return nil; }

- (id)initWithWindow:window
{
    if (self = [super initWithWindow:window]) {
    }
    return self;
}


- (float)insertionPointHeightRatio { return 0.5; }

- (BOOL)isRelatedTo:(XVimEvaluator*)other { return [super isRelatedTo:other] || other == self.parent; }

- (XVimKeymap*)selectKeymapWithProvider:(id<XVimKeymapProvider>)keymapProvider
{
    return [keymapProvider keymapForMode:XVIM_MODE_OPERATOR_PENDING];
}

- (XVimEvaluator*)a
{
    [self.argumentString appendString:@"a"];
    return [[XVimTextObjectEvaluator alloc] initWithWindow:self.window inner:NO];
}

// TODO: There used to be "b:" and "B:" methods here. Take a look how they have been.

- (XVimEvaluator*)i
{
    [self.argumentString appendString:@"i"];
    return [[XVimTextObjectEvaluator alloc] initWithWindow:self.window inner:YES];
}

- (XVimEvaluator*)_motionFixed:(XVimMotion*)motion
{
    // We have to save current selection range before fix the command to pass them to fixOperationCommandInMode...
    XVimEvaluator* evaluator = [super _motionFixed:motion];
    // Fix repeat command for change here (except for Yank)
    // Also need to set "." mark for last change.
    // We do not fix the change here if next evaluator is not nil becaust it waits more input for fix the command.
    // This happens for a command like "cw..."
    if (nil == evaluator) {
        let view = self.window.sourceView;
        NSString* className = NSStringFromClass([self class]);
        if (![className isEqualToString:@"XVimYankEvaluator"]) {
            [XVim.instance fixOperationCommands];
            XVimMark* mark = nil;
            if ([className isEqualToString:@"XVimJoinEvaluator"]) {
                // This is specical case for join operation.
                // The mark is set at the head of next line of the insertion point after the operation
                mark = [[XVimMark alloc] initWithLine:self.sourceView.insertionLine + 1
                                       column:0
                                     document:view.documentURL.path];
            }
            else if ([className isEqualToString:@"XVimShiftEvaluator"]) {
                mark = [[XVimMark alloc] initWithLine:self.sourceView.insertionLine
                                       column:0
                                     document:view.documentURL.path];
            }
            else {
                mark = [[XVimMark alloc] initWithLine:self.sourceView.insertionLine
                                       column:self.sourceView.insertionColumn
                                     document:view.documentURL.path];
            }

            if (nil != mark.document) {
                [XVim.instance.marks setMark:mark forName:@"."];
            }
        }
    }
    return evaluator;
}

- (XVimEvaluator*)executeOperationWithMotion:(XVimMotion*)motion { return [self _motionFixed:motion]; }

- (XVimEvaluator*)onChildComplete:(XVimEvaluator*)childEvaluator
{
    if ([childEvaluator isKindOfClass:[XVimTextObjectEvaluator class]]) {
        return [self _motionFixed:[(XVimTextObjectEvaluator*)childEvaluator motion]];
    }
    return nil;
}
@end
